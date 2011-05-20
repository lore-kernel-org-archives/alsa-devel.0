From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 2/2] ASoC: tlv320aic3x: Do soft reset to codec
	when going to bias off state
Date: Fri, 20 May 2011 16:52:38 +0300
Message-ID: <1305899558-21719-2-git-send-email-jhnikula@gmail.com>
References: <1305899558-21719-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 0541B10387B
	for <alsa-devel@alsa-project.org>;
	Fri, 20 May 2011 15:51:25 +0200 (CEST)
Received: by mail-ey0-f179.google.com with SMTP id 5so1296110eyg.38
	for <alsa-devel@alsa-project.org>; Fri, 20 May 2011 06:51:25 -0700 (PDT)
In-Reply-To: <1305899558-21719-1-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

TLV320AIC33, TLV320AIC34 and I believe others too in this family have some
hw bugs that cause that analogue and digital VDD supplies remain leaking
up to a few mA of current after certain use cases even the hw blocks inside
codec are driven to off.

Highest leakages occur after using the bypass paths inside codec but it
is possible to get smaller leakages just by toggling mute switches in
unused audio paths (i.e. no DAPM changes) while codec is on due another
active audio path.

While some cases are able to workaroud by making sure that e.g. output mixer
switches are muted before powering down the output stage this doesn't help
all the cases.

Therefore use the software reset command to clear possible leakage currents
since that works in every cases and affects only this codec instance. Only
drawback is that now cache sync is required everytime when codec bias comes
out from bias off state, not only when supply regulators were off.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
---
 sound/soc/codecs/tlv320aic3x.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 9047bb1..789453d 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1120,6 +1120,13 @@ static int aic3x_set_power(struct snd_soc_codec *codec, int power)
 			aic3x_init_3007(codec);
 		codec->cache_sync = 0;
 	} else {
+		/*
+		 * Do soft reset to this codec instance in order to clear
+		 * possible VDD leakage currents in case the supply regulators
+		 * remain on
+		 */
+		snd_soc_write(codec, AIC3X_RESET, SOFT_RESET);
+		codec->cache_sync = 1;
 		aic3x->power = 0;
 		/* HW writes are needless when bias is off */
 		codec->cache_only = 1;
-- 
1.7.4.4
