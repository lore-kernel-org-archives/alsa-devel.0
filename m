From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Capture not working in MMAP mode with '-v'
Date: Mon, 9 Nov 2009 11:54:07 +0100 (CET)
Message-ID: <alpine.LNX.2.00.0911091144270.12612@eeebox2.perex-int.cz>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030A705212@dbde02.ent.ti.com>
	<1257753496.30157.455.camel@eenurkka-desktop>
	<5A47E75E594F054BAF48C5E4FC4B92AB030A705220@dbde02.ent.ti.com>
	<1257754351.30157.464.camel@eenurkka-desktop>
	<20091109102621.GA1245@sirena.org.uk>
	<1257762766.11847.5.camel@eenurkka-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 45F99103840
	for <alsa-devel@alsa-project.org>; Mon,  9 Nov 2009 11:54:08 +0100 (CET)
In-Reply-To: <1257762766.11847.5.camel@eenurkka-desktop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Cc: "ext Aggarwal, Anuj" <anuj.aggarwal@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, ext Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 9 Nov 2009, Eero Nurkkala wrote:

> So the patch:
>
> --- a/alsa-utils-1.0.21/aplay/aplay.c
> +++ b/alsa-utils-1.0.21/aplay/aplay-fix.c
> @@ -1104,7 +1104,8 @@ static void set_params(void)
> 	if (mmap_flag && verbose) {
> 		const snd_pcm_channel_area_t *areas;
> 		snd_pcm_uframes_t offset;
> -		int i;
> +		int i, chunk_prev = chunk_size;
> +		snd_pcm_avail_update(handle);
> 		err = snd_pcm_mmap_begin(handle, &areas, &offset, &chunk_size);
> 		if (err < 0) {
> 			error("snd_pcm_mmap_begin problem: %s", snd_strerror(err));
> @@ -1112,6 +1113,11 @@ static void set_params(void)
> 		}
> 		for (i = 0; i < hwparams.channels; i++)
> 			fprintf(stderr, "mmap_area[%i] = %p,%u,%u (%u)\n", i, areas[i].addr, areas[i].first, areas[i].step, snd_pcm_format_physical_width(hwparams.format));
> +
> +		/* Chunk size better be non-zero */
> +		if (!chunk_size)
> +                	chunk_size = chunk_prev;
> +
> 		/* not required, but for sure */
> 		snd_pcm_mmap_commit(handle, offset, 0);
> 	}

This patch removes wrong chunk_size initialization (commited to alsa-utils 
git repo now):

diff --git a/aplay/aplay.c b/aplay/aplay.c
index c7c82a1..f0fa969 100644
--- a/aplay/aplay.c
+++ b/aplay/aplay.c
@@ -1103,9 +1103,9 @@ static void set_params(void)
  	/* show mmap buffer arragment */
  	if (mmap_flag && verbose) {
  		const snd_pcm_channel_area_t *areas;
-		snd_pcm_uframes_t offset;
+		snd_pcm_uframes_t offset, size = chunk_size;
  		int i;
-		err = snd_pcm_mmap_begin(handle, &areas, &offset, &chunk_size);
+		err = snd_pcm_mmap_begin(handle, &areas, &offset, &size);
  		if (err < 0) {
  			error("snd_pcm_mmap_begin problem: %s", snd_strerror(err));
  			exit(EXIT_FAILURE);

It's not necessary to call snd_pcm_avail_update() and mangle chunk_size. 
The debug code wants to print the structure of mmaped areas only which are 
available all time.

Thanks for reporting (although only your last patch makes clear where the 
problem is for me).

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
