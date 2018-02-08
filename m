From: "Wischer, Timo (ADITG/ESB)" <twischer@de.adit-jv.com>
Subject: Re: [PATCH - JACK PCM plugin] jack: Write only valid
 values to the internal hw_ptr
Date: Thu, 8 Feb 2018 08:49:53 +0000
Message-ID: <B0FB33DC1499054591F62C0EF1E013D7684F7A01@HI2EXCH01.adit-jv.com>
References: <1516610240-7772-1-git-send-email-twischer@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1516610240-7772-1-git-send-email-twischer@de.adit-jv.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello all,

any comments so far?

It would be great if someone could have a look
because I have some further fixes pending.

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
Sent: Monday, January 22, 2018 9:37 AM
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org; Wischer, Timo (ADITG/ESB)
Subject: [PATCH - JACK PCM plugin] jack: Write only valid values to the int=
ernal hw_ptr

From: Timo Wischer <twischer@de.adit-jv.com>

Otherwise the ALSA thread could for example read a hw_ptr >
buffer_size

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>

diff --git a/jack/pcm_jack.c b/jack/pcm_jack.c
index 4468ede..3aed332 100644
--- a/jack/pcm_jack.c
+++ b/jack/pcm_jack.c
@@ -137,6 +137,7 @@ static int
 snd_pcm_jack_process_cb(jack_nframes_t nframes, snd_pcm_ioplug_t *io)
 {
        snd_pcm_jack_t *jack =3D io->private_data;
+       snd_pcm_uframes_t hw_ptr;
        const snd_pcm_channel_area_t *areas;
        snd_pcm_uframes_t xfer =3D 0;
        unsigned int channel;
@@ -155,12 +156,13 @@ snd_pcm_jack_process_cb(jack_nframes_t nframes, snd_p=
cm_ioplug_t *io)
                        return 0;
                }
        }
-
+
+       hw_ptr =3D jack->hw_ptr;
        areas =3D snd_pcm_ioplug_mmap_areas(io);

        while (xfer < nframes) {
                snd_pcm_uframes_t frames =3D nframes - xfer;
-               snd_pcm_uframes_t offset =3D jack->hw_ptr;
+               snd_pcm_uframes_t offset =3D hw_ptr;
                snd_pcm_uframes_t cont =3D io->buffer_size - offset;

                if (cont < frames)
@@ -173,10 +175,11 @@ snd_pcm_jack_process_cb(jack_nframes_t nframes, snd_p=
cm_ioplug_t *io)
                                snd_pcm_area_copy(&areas[channel], offset, =
&jack->areas[channel], xfer, frames, io->format);
                }

-               jack->hw_ptr +=3D frames;
-               jack->hw_ptr %=3D io->buffer_size;
+               hw_ptr +=3D frames;
+               hw_ptr %=3D io->buffer_size;
                xfer +=3D frames;
        }
+       jack->hw_ptr =3D hw_ptr;

        pcm_poll_unblock_check(io); /* unblock socket for polling if needed=
 */

--
2.7.4
