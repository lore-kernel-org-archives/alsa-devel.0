From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: [PATCH] [alsa-lib] pcm: softvol: Allow up to 90 dB of
	gain
Date: Wed, 18 Apr 2018 17:03:09 +0200
Message-ID: <alpine.DEB.2.11.1804181632580.5586@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id BAE4726765C
 for <alsa-devel@alsa-project.org>; Wed, 18 Apr 2018 17:03:53 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


The gain algorithm used in softvol can handle gain factors of up to
32767 which is slightly more than 90 dB, so allow a max_dB of 90 dB.
This doesn't affect existing asound.conf files, but does allow a
max_dB of up to 90 dB when needed.

Tested using Audacity that there is no undue distorsion or other
artefacts when 90 dB of gain is applied to a suitable signal (i.e.
a signal quiet enough not be clipped whan applying 90 dB of gain).

Signed-off-by: Ricard Wanderlof <ricardw@axis.com>
---

I discussed this with Takashi and Jaroslav back in January, but the =

discussion petered out and didn't reach a conclusion on which maximum gain =

would be acceptable, so I thought I'd send an actual patch and we can take =

it from here.

We have a couple of usecases where we are using digital microphones, which =

have 24 bit resolution, and with an acoustic overload point of about 120 =

dB SPL, the output level can be quite low when the sound source is a fair =

distance form the microphone. The current softvol limit of 50 dB is =

therefore a bit restrictive.

When studying the code, it becomes apparent that the limit of the actual =

gain function is a gain factor of 32767, which corresponds to 90.3 dB. So =

it makes sense to set the MAX_DB_UPPER_LIMIT (whose only function is to =

cause _snd_pcm_softvol_open() to bail out and emit an error message if the =

gain is set higher than this limit) to 90 dB as it corresponds to the =

technical limitations of the gain algorithm. Granted, 90 dB is probably =

more than most people need, but there's no real harm in allowing a large =

gain; the user gain limit in a given application is still set by the =

max_dB parameter in asound.conf . The worst that can happen is that the =

signal becomes clipped as would happen with any signal if the applied gain =

drives it over 0 dB. If in fact a signal is close to 0 dB to start with, =

then the resulting clipping when increased by 90 dB is not much worse than =

when increased by 50 dB.

 src/pcm/pcm_softvol.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/pcm/pcm_softvol.c b/src/pcm/pcm_softvol.c
index 8bb4a39..0eaeace 100644
--- a/src/pcm/pcm_softvol.c
+++ b/src/pcm/pcm_softvol.c
@@ -59,7 +59,11 @@ typedef struct {
 #define PRESET_RESOLUTION	256
 #define PRESET_MIN_DB		-51.0
 #define ZERO_DB                  0.0
-#define MAX_DB_UPPER_LIMIT      50
+/*
+ * The gain algorithm as it stands supports gain factors up to 32767, which
+ * is a fraction more than 90 dB, so set 90 dB as the maximum possible gai=
n.
+ */
+#define MAX_DB_UPPER_LIMIT      90
 =

 static const unsigned int preset_dB_value[PRESET_RESOLUTION] =3D {
 	0x00b8, 0x00bd, 0x00c1, 0x00c5, 0x00ca, 0x00cf, 0x00d4, 0x00d9,
-- =

2.1.4

-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
