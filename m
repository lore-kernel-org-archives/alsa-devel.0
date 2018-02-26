From: "Wischer, Timo (ADITG/ESB)" <twischer@de.adit-jv.com>
Subject: Re: [PATCH - JACK PCM plugin] jack: Do not Xrun the
	ALSA buffer
Date: Mon, 26 Feb 2018 08:14:11 +0000
Message-ID: <B0FB33DC1499054591F62C0EF1E013D7684FB83A@HI2EXCH01.adit-jv.com>
References: <1516794784-9993-1-git-send-email-twischer@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1516794784-9993-1-git-send-email-twischer@de.adit-jv.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "patch@alsa-project.org" <patch@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello all,

Due to merged [1] (see [2]) [3] can be merged without conflicts, now.

@Takashi: Thanks for merging [2].

Please give a feedback if there is anything which has to be changed.

The biggest change in snd_pcm_jack_process_cb() occurs =

due to the movement of the snd_pcm_area_silence() call to the end of this f=
unction.
This is required to fill the buffer with silence if there is not enough aud=
io data available for JACK.

[1] http://mailman.alsa-project.org/pipermail/alsa-devel/2018-January/13098=
6.html
[2] http://git.alsa-project.org/?p=3Dalsa-plugins.git;a=3Dcommit;h=3D3e6ace=
6fe045c580dc5490d87eff6b616f7769ef
[3] http://mailman.alsa-project.org/pipermail/alsa-devel/2018-January/13098=
7.html

Best regards

Timo Wischer

Advanced Driver Information Technology GmbH
Engineering Software Base (ADITG/ESB)
Robert-Bosch-Str. 200
31139 Hildesheim
Germany

Tel. +49 5121 49 6938
Fax +49 5121 49 6999
twischer@de.adit-jv.com

ADIT is a joint venture company of Robert Bosch GmbH/Robert Bosch Car Multi=
media GmbH and DENSO Corporation
Sitz: Hildesheim, Registergericht: Amtsgericht Hildesheim HRB 3438
Gesch=E4ftsf=FChrung: Wilhelm Grabow, Ken Yaguchi

________________________________________
From: Wischer, Timo (ADITG/ESB)
Sent: Wednesday, January 24, 2018 12:53 PM
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org; Wischer, Timo (ADITG/ESB)
Subject: [PATCH - JACK PCM plugin] jack: Do not Xrun the ALSA buffer

From: Timo Wischer <twischer@de.adit-jv.com>

when the JACK thread is requesting too many audio frames

Playback:
Without this commit the ALSA audio buffer
will be played with endless repeats as long as the user application
has not provided new audio data.
Therefore this garbage will be played as long as the user application
has not called snd_pcm_stop() after an Xrun.
With this fix the rest of the JACK buffer will be filled
with silence.

Capture:
Without this commit the audio data in the ALSA buffer would be
overwritten.
With this commit the new data from the JACK buffer
will not be copied.
Therefore the existing data in the ALSA buffer
will not be overwritten.

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
---

This patch is depending on
http://mailman.alsa-project.org/pipermail/alsa-devel/2018-January/130986.ht=
ml


diff --git a/jack/pcm_jack.c b/jack/pcm_jack.c
index c22a5d0..a4f35f4 100644
--- a/jack/pcm_jack.c
+++ b/jack/pcm_jack.c
@@ -54,6 +54,68 @@ typedef struct {

 static int snd_pcm_jack_stop(snd_pcm_ioplug_t *io);

+
+static inline snd_pcm_uframes_t snd_pcm_jack_playback_avail(const snd_pcm_=
ioplug_t* const io,
+                                                            const snd_pcm_=
uframes_t hw_ptr,
+                                                            const snd_pcm_=
uframes_t appl_ptr)
+{
+       const snd_pcm_jack_t* const jack =3D io->private_data;
+
+       /* cannot use io->hw_ptr without calling snd_pcm_avail_update()
+        * because it is not guranteed that snd_pcm_jack_pointer() was alre=
ady
+        * called
+        */
+       snd_pcm_sframes_t avail;
+       avail =3D hw_ptr + io->buffer_size - appl_ptr;
+       if (avail < 0)
+               avail +=3D jack->boundary;
+       else if ((snd_pcm_uframes_t) avail >=3D jack->boundary)
+               avail -=3D jack->boundary;
+       return avail;
+}
+
+static inline snd_pcm_uframes_t snd_pcm_jack_capture_avail(const snd_pcm_i=
oplug_t* const io,
+                                                           const snd_pcm_u=
frames_t hw_ptr,
+                                                           const snd_pcm_u=
frames_t appl_ptr)
+{
+       const snd_pcm_jack_t* const jack =3D io->private_data;
+
+       /* cannot use io->hw_ptr without calling snd_pcm_avail_update()
+        * because it is not guranteed that snd_pcm_jack_pointer() was alre=
ady
+        * called
+        */
+       snd_pcm_sframes_t avail;
+       avail =3D hw_ptr - appl_ptr;
+       if (avail < 0)
+               avail +=3D jack->boundary;
+       return avail;
+}
+
+static inline snd_pcm_uframes_t snd_pcm_jack_avail(const snd_pcm_ioplug_t*=
 const io,
+                                                   const snd_pcm_uframes_t=
 hw_ptr,
+                                                   const snd_pcm_uframes_t=
 appl_ptr)
+{
+       return (io->stream =3D=3D SND_PCM_STREAM_PLAYBACK) ?
+                               snd_pcm_jack_playback_avail(io, hw_ptr, app=
l_ptr) :
+                               snd_pcm_jack_capture_avail(io, hw_ptr, appl=
_ptr);
+}
+
+static inline snd_pcm_uframes_t snd_pcm_jack_hw_avail(const snd_pcm_ioplug=
_t* const io,
+                                                      const snd_pcm_uframe=
s_t hw_ptr,
+                                                      const snd_pcm_uframe=
s_t appl_ptr)
+{
+       /* available data/space which can be transfered by the user applica=
tion */
+       const snd_pcm_uframes_t user_avail =3D snd_pcm_jack_avail(io, hw_pt=
r,
+                                                               appl_ptr);
+
+       if (user_avail > io->buffer_size) {
+               /* there was an Xrun */
+               return 0;
+       }
+       /* available data/space which can be transfered by the DMA */
+       return io->buffer_size - user_avail;
+}
+
 static int pcm_poll_block_check(snd_pcm_ioplug_t *io)
 {
        static char buf[32];
@@ -154,7 +216,6 @@ snd_pcm_jack_process_cb(jack_nframes_t nframes, snd_pcm=
_ioplug_t *io)
 {
        snd_pcm_jack_t *jack =3D io->private_data;
        snd_pcm_uframes_t hw_ptr;
-       const snd_pcm_channel_area_t *areas;
        snd_pcm_uframes_t xfer =3D 0;
        unsigned int channel;

@@ -164,40 +225,57 @@ snd_pcm_jack_process_cb(jack_nframes_t nframes, snd_p=
cm_ioplug_t *io)
                jack->areas[channel].first =3D 0;
                jack->areas[channel].step =3D jack->sample_bits;
        }
-
-       if (io->state !=3D SND_PCM_STATE_RUNNING) {
-               if (io->stream =3D=3D SND_PCM_STREAM_PLAYBACK) {
-                       for (channel =3D 0; channel < io->channels; channel=
++)
-                               snd_pcm_area_silence(&jack->areas[channel],=
 0, nframes, io->format);
-                       return 0;
-               }
-       }

        hw_ptr =3D jack->hw_ptr;
-       areas =3D snd_pcm_ioplug_mmap_areas(io);
-
-       while (xfer < nframes) {
-               snd_pcm_uframes_t frames =3D nframes - xfer;
-               snd_pcm_uframes_t offset =3D hw_ptr % io->buffer_size;
-               snd_pcm_uframes_t cont =3D io->buffer_size - offset;
-
-               if (cont < frames)
-                       frames =3D cont;
+       if (io->state =3D=3D SND_PCM_STATE_RUNNING) {
+               const snd_pcm_channel_area_t *areas =3D snd_pcm_ioplug_mmap=
_areas(io);
+
+               while (xfer < nframes) {
+                       snd_pcm_uframes_t frames =3D nframes - xfer;
+                       snd_pcm_uframes_t offset =3D hw_ptr % io->buffer_si=
ze;
+                       snd_pcm_uframes_t cont =3D io->buffer_size - offset;
+                       snd_pcm_uframes_t hw_avail =3D
+                                       snd_pcm_jack_hw_avail(io, hw_ptr,
+                                                             io->appl_ptr);
+
+                       /* stop copying if there is no more data available =
*/
+                       if (hw_avail <=3D 0)
+                               break;
+
+                       /* split the snd_pcm_area_copy() function into two =
parts
+                        * if the data to copy passes the buffer wrap around
+                        */
+                       if (cont < frames)
+                               frames =3D cont;
+
+                       if (hw_avail < frames)
+                               frames =3D hw_avail;
+
+                       for (channel =3D 0; channel < io->channels; channel=
++) {
+                               if (io->stream =3D=3D SND_PCM_STREAM_PLAYBA=
CK)
+                                       snd_pcm_area_copy(&jack->areas[chan=
nel], xfer, &areas[channel], offset, frames, io->format);
+                               else
+                                       snd_pcm_area_copy(&areas[channel], =
offset, &jack->areas[channel], xfer, frames, io->format);
+                       }

-               for (channel =3D 0; channel < io->channels; channel++) {
-                       if (io->stream =3D=3D SND_PCM_STREAM_PLAYBACK)
-                               snd_pcm_area_copy(&jack->areas[channel], xf=
er, &areas[channel], offset, frames, io->format);
-                       else
-                               snd_pcm_area_copy(&areas[channel], offset, =
&jack->areas[channel], xfer, frames, io->format);
+                       hw_ptr +=3D frames;
+                       if (hw_ptr >=3D jack->boundary)
+                               hw_ptr -=3D jack->boundary;
+                       xfer +=3D frames;
                }
-
-               hw_ptr +=3D frames;
-               if (hw_ptr >=3D jack->boundary)
-                       hw_ptr -=3D jack->boundary;
-               xfer +=3D frames;
        }
        jack->hw_ptr =3D hw_ptr;

+       /* check if requested frames were copied */
+       if (xfer < nframes) {
+               /* always fill the not yet written JACK buffer with silence=
 */
+               if (io->stream =3D=3D SND_PCM_STREAM_PLAYBACK) {
+                       const snd_pcm_uframes_t samples =3D nframes - xfer;
+                       for (channel =3D 0; channel < io->channels; channel=
++)
+                               snd_pcm_area_silence(&jack->areas[channel],=
 xfer, samples, io->format);
+               }
+       }
+
        pcm_poll_unblock_check(io); /* unblock socket for polling if needed=
 */

        return 0;
--
2.7.4
