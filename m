From: Maarten Baert <maarten-baert@hotmail.com>
Subject: Re: [PATCH] Bugfix: Fix resampling when client
 and	slave both use format float
Date: Wed, 26 Feb 2014 14:32:51 +0100
Message-ID: <BLU0-SMTP175CCD2DD79CCAB8548A5C5E2800@phx.gbl>
References: <BLU0-SMTP134831A0E1EA4F209F321CAE2850@phx.gbl>
 <s5hwqgkyimw.wl%tiwai@suse.de> <BLU0-SMTP25F099B950B03725BED93DE2860@phx.gbl>
 <s5hios4ps18.wl%tiwai@suse.de> <s5hha7opr7l.wl%tiwai@suse.de>
 <BLU0-SMTP4567C0162DA792F75B98686E2860@phx.gbl>
 <s5hbnxuuycz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030400000801090909040102"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from blu0-omc3-s24.blu0.hotmail.com (blu0-omc3-s24.blu0.hotmail.com
 [65.55.116.99]) by alsa0.perex.cz (Postfix) with ESMTP id 539A92656B0
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 14:32:56 +0100 (CET)
In-Reply-To: <s5hbnxuuycz.wl%tiwai@suse.de>
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

--------------030400000801090909040102
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On 26/02/14 08:28, Takashi Iwai wrote:
> It's not applicable via git am. Please resubmit with the right format
> (that is cleanly applied via git am). 
Sorry, this one should work.

--------------030400000801090909040102
Content-Type: text/x-patch;
	name="0001-snd_pcm_plug_change_format-Insert-linear-to-float-co.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-snd_pcm_plug_change_format-Insert-linear-to-float-co.pa";
	filename*1="tch"

>From 3a576686760ec6bb76892443e3c3c9ed2657bf93 Mon Sep 17 00:00:00 2001
From: Maarten Baert <maarten-baert@hotmail.com>
Date: Wed, 26 Feb 2014 14:23:45 +0100
Subject: [PATCH] snd_pcm_plug_change_format: Insert linear-to-float conversion
 when rate or channel count is incorrect.

This fixes a bug where snd_pcm_plug_insert_plugins fails when both
client and slave use format float, but the rate or channel count does
not match. I also removed some redundant code.

Signed-off-by: Maarten Baert <maarten-baert@hotmail.com>
---
 src/pcm/pcm_plug.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

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
-- 
1.9.0


--------------030400000801090909040102
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------030400000801090909040102--
