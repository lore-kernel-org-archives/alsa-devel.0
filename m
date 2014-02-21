From: Maarten Baert <maarten-baert@hotmail.com>
Subject: [PATCH] Bugfix: Fix resampling when client and slave
 both use format float
Date: Fri, 21 Feb 2014 21:01:00 +0100
Message-ID: <BLU0-SMTP134831A0E1EA4F209F321CAE2850@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010904000605080000020002"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from blu0-omc3-s3.blu0.hotmail.com (blu0-omc3-s3.blu0.hotmail.com
 [65.55.116.78]) by alsa0.perex.cz (Postfix) with ESMTP id AC35C261A3A
 for <alsa-devel@alsa-project.org>; Fri, 21 Feb 2014 21:01:05 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--------------010904000605080000020002
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

I found a bug in libasound. When both the client and the slave (in my
case, the JACK plugin) try to use the float format, but the sample rate
or channel count does not match, libasound *should* insert linear
conversion plugins to convert from float to linear, then resample/remap
channels, and then convert back to float (because apparently the
resamplers and channel remapper don't support floating point, only
'linear' i.e. integers). Currently this doesn't work,
snd_pcm_plug_change_format doesn't know what to do and simply returns
EINVAL. As a result, snd_pcm_hw_params fails even though the HW params
were perfectly valid (it indicates that both the float format and any
sample rate are supported).

In my test, this broke audio for WINE (and any other application that
tries to use float, such as aplay with the right settings) when I wanted
to use the JACK plugin (which only supports the float format).

This patch fixes this bug by doing a conversion to S16 and back when
resampling or remapping is needed. And while I was at it, I also removed
a check that had no effect because the exact same check is already being
done at the start of the function.

I still think it's a bit silly that libasound requires integers for
resampling, because both libsamplerate and libspeex use float internally
for resampling. So now ALSA is literally doing a
float-to-s16-to-float-to-s16-to-float conversion. But changing that
would have been a lot harder.

Maarten Baert

--------------010904000605080000020002
Content-Type: text/x-patch; name="fix-float-resampling.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="fix-float-resampling.patch"

diff --git a/src/pcm/pcm_plug.c b/src/pcm/pcm_plug.c
index fa84eaa..ede9c15 100644
--- a/src/pcm/pcm_plug.c
+++ b/src/pcm/pcm_plug.c
@@ -522,15 +522,13 @@ static int snd_pcm_plug_change_format(snd_pcm_t *pcm, snd_pcm_t **new, snd_pcm_p
 		}
 #ifdef BUILD_PCM_PLUGIN_LFLOAT
 	} else if (snd_pcm_format_float(slv->format)) {
-		/* Conversion is done in another plugin */
-		if (clt->format == slv->format &&
-		    clt->rate == slv->rate &&
-		    clt->channels == slv->channels)
-			return 0;
-		cfmt = clt->format;
-		if (snd_pcm_format_linear(clt->format))
+		if (snd_pcm_format_linear(clt->format)) {
+			cfmt = clt->format;
 			f = snd_pcm_lfloat_open;
-		else
+		} else if (clt->rate != slv->rate || clt->channels != slv->channels) {
+			cfmt = SND_PCM_FORMAT_S16;
+			f = snd_pcm_lfloat_open;
+		} else
 			return -EINVAL;
 #endif
 #ifdef BUILD_PCM_NONLINEAR

--------------010904000605080000020002
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------010904000605080000020002--
