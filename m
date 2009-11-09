From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Subject: Re: Capture not working in MMAP mode with '-v'
Date: Mon, 09 Nov 2009 12:32:46 +0200
Message-ID: <1257762766.11847.5.camel@eenurkka-desktop>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030A705212@dbde02.ent.ti.com>
	<1257753496.30157.455.camel@eenurkka-desktop>
	<5A47E75E594F054BAF48C5E4FC4B92AB030A705220@dbde02.ent.ti.com>
	<1257754351.30157.464.camel@eenurkka-desktop>
	<20091109102621.GA1245@sirena.org.uk>
Reply-To: ext-eero.nurkkala@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 6377F103867
	for <alsa-devel@alsa-project.org>; Mon,  9 Nov 2009 11:34:38 +0100 (CET)
In-Reply-To: <20091109102621.GA1245@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "ext Aggarwal, Anuj" <anuj.aggarwal@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 2009-11-09 at 11:26 +0100, ext Mark Brown wrote:
> On Mon, Nov 09, 2009 at 10:12:31AM +0200, Eero Nurkkala wrote:
> 
> > As far as I know, nobody fixed it. Yeah, aplay = arecord, and it occurs
> > only with arecord to be more specific, and is present on all platforms
> > out there:
> 
> Has anyone reported whatever the problem is?
> _______________________________________________

Does the below make any sense?


Call to:
err = snd_pcm_mmap_begin(handle, &areas, &offset, &chunk_size);
Will make the chuck_size to zero.

It's perfectly fine to be zero:

/**
 * \brief Application request to access a portion of direct (mmap) area
 * \param pcm PCM handle 
 * \param areas Returned mmap channel areas
 * \param offset Returned mmap area offset in area steps (== frames)
 * \param frames mmap area portion size in frames (wanted on entry, contiguous
available on exit)
 * \return 0 on success otherwise a negative error code
 *
 * It is necessary to call the snd_pcm_avail_update() function directly before
 * this call. Otherwise, this function can return a wrong count of available
frames.
 *
 * The function should be called before a sample-direct area can be accessed.
 * The resulting size parameter is always less or equal to the input count of
frames
 * and can be zero, if no frames can be processed (the ring buffer is full).
 *
 * See the snd_pcm_mmap_commit() function to finish the frame processing in
 * the direct areas.
 */
int snd_pcm_mmap_begin(snd_pcm_t *pcm,
                       const snd_pcm_channel_area_t **areas,
                       snd_pcm_uframes_t *offset,
                       snd_pcm_uframes_t *frames)
{


--> aplay doesn't call "snd_pcm_avail_update()" as this function suggest. I try
is also, but the problem is chuck_size, when zero:

at aplay:
static ssize_t pcm_read(u_char *data, size_t rcount)

returns rcount always, never reading any through readi_func!!!!

This pcm_read is called at aplay:

                /* capture */
                fdcount = 0;
                while (rest > 0) {
                        size_t c = (rest <= (off64_t)chunk_bytes) ?
                                (size_t)rest : chunk_bytes;
                        size_t f = c * 8 / bits_per_frame;
                        if (pcm_read(audiobuf, f) != f)
                                break;
                        if (write(fd, audiobuf, c) != c) {
                                perror(name);
                                exit(EXIT_FAILURE);
                        }
                        count -= c;
                        rest -= c;
                        fdcount += c;
                        printf("here!\n");
                }


--> like you see  this thing is always fine:

                        if (pcm_read(audiobuf, f) != f)
                                break;
                        if (write(fd, audiobuf, c) != c) {
                                perror(name);
                                exit(EXIT_FAILURE);
                        }


so it keeps on writing in the file, not reading any from ALSA. (try with
strace)

-->> Aplay is buggy, period.



So the patch:

--- a/alsa-utils-1.0.21/aplay/aplay.c
+++ b/alsa-utils-1.0.21/aplay/aplay-fix.c
@@ -1104,7 +1104,8 @@ static void set_params(void)
 	if (mmap_flag && verbose) {
 		const snd_pcm_channel_area_t *areas;
 		snd_pcm_uframes_t offset;
-		int i;
+		int i, chunk_prev = chunk_size;
+		snd_pcm_avail_update(handle);
 		err = snd_pcm_mmap_begin(handle, &areas, &offset, &chunk_size);
 		if (err < 0) {
 			error("snd_pcm_mmap_begin problem: %s", snd_strerror(err));
@@ -1112,6 +1113,11 @@ static void set_params(void)
 		}
 		for (i = 0; i < hwparams.channels; i++)
 			fprintf(stderr, "mmap_area[%i] = %p,%u,%u (%u)\n", i, areas[i].addr, areas[i].first, areas[i].step, snd_pcm_format_physical_width(hwparams.format));
+
+		/* Chunk size better be non-zero */
+		if (!chunk_size)
+                	chunk_size = chunk_prev;
+
 		/* not required, but for sure */
 		snd_pcm_mmap_commit(handle, offset, 0);
 	}
