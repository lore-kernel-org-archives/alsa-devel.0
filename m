From: Stuart Longland <redhatter@gentoo.org>
Subject: [PATCH] ASoC: Fix overflow bug in SOC_DOUBLE_R_SX_TLV
Date: Fri, 18 Jun 2010 12:56:10 +1000
Message-ID: <1276829770-31557-1-git-send-email-redhatter@gentoo.org>
References: <20100618023810.GS7759@www.longlandclan.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ossa.mas.viperplatform.net.au (ossa.mas.viperplatform.net.au
	[202.147.75.25])
	by alsa0.perex.cz (Postfix) with ESMTP id 81A87103819
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Jun 2010 04:56:16 +0200 (CEST)
Received: from mail by ossa.mas.viperplatform.net.au with spam-scanned (Exim
	4.43) id 1OPRkc-0005WX-V3
	for alsa-devel@alsa-project.org; Fri, 18 Jun 2010 12:56:15 +1000
Received: from [203.94.56.252] (helo=longlandclan.yi.org)
	by ossa.mas.viperplatform.net.au with esmtp (Exim 4.43)
	id 1OPRkb-0005Vy-Ml
	for alsa-devel@alsa-project.org; Fri, 18 Jun 2010 12:56:14 +1000
In-Reply-To: <20100618023810.GS7759@www.longlandclan.yi.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

When SX_TLV widgets are read, if the gain is set to a value below 0dB,
the mixer control is erroniously read as being at maximum volume.

The value read out of the CODEC register is never sign-extended, and
when the minimum value is subtracted (read; added, since the minimum is
negative) the result is a number greater than the maximum allowed value
for the control, and hence it saturates.

Solution: Mask the result so that it "wraps around", emulating
sign-extension.

Signed-off-by: Stuart Longland <redhatter@gentoo.org>
---
 sound/soc/soc-core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index a82a797..0470288 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2400,8 +2400,8 @@ int snd_soc_get_volsw_2r_sx(struct snd_kcontrol *kcontrol,
 	int val = snd_soc_read(codec, mc->reg) & mask;
 	int valr = snd_soc_read(codec, mc->rreg) & mask;
 
-	ucontrol->value.integer.value[0] = ((val & 0xff)-min);
-	ucontrol->value.integer.value[1] = ((valr & 0xff)-min);
+	ucontrol->value.integer.value[0] = ((val & 0xff)-min) & mask;
+	ucontrol->value.integer.value[1] = ((valr & 0xff)-min) & mask;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_get_volsw_2r_sx);
-- 
1.6.4.4
