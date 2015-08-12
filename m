From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 4/4] ASoC: cs42l73: Use case range at
	appropriate place
Date: Wed, 12 Aug 2015 11:10:49 +0800
Message-ID: <1439349049.3594.6.camel@ingics.com>
References: <1439348866.3594.2.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f47.google.com (mail-pa0-f47.google.com
 [209.85.220.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 275E72605D8
 for <alsa-devel@alsa-project.org>; Wed, 12 Aug 2015 05:10:55 +0200 (CEST)
Received: by pawu10 with SMTP id u10so4287605paw.1
 for <alsa-devel@alsa-project.org>; Tue, 11 Aug 2015 20:10:54 -0700 (PDT)
In-Reply-To: <1439348866.3594.2.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org

The readable registers are in continuous ranges: 0x01 ~ 0x03, 0x05 ~ 0x5f.
Use case range syntax makes the code shorter with better readability when
we have a large number of continuous switch cases.
No functional change with this patch.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 sound/soc/codecs/cs42l73.c | 96 +---------------------------------------------
 1 file changed, 2 insertions(+), 94 deletions(-)

diff --git a/sound/soc/codecs/cs42l73.c b/sound/soc/codecs/cs42l73.c
index 427d6cf..42a8fd4 100644
--- a/sound/soc/codecs/cs42l73.c
+++ b/sound/soc/codecs/cs42l73.c
@@ -153,100 +153,8 @@ static bool cs42l73_volatile_register(struct device *dev, unsigned int reg)
 static bool cs42l73_readable_register(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
-	case CS42L73_DEVID_AB:
-	case CS42L73_DEVID_CD:
-	case CS42L73_DEVID_E:
-	case CS42L73_REVID:
-	case CS42L73_PWRCTL1:
-	case CS42L73_PWRCTL2:
-	case CS42L73_PWRCTL3:
-	case CS42L73_CPFCHC:
-	case CS42L73_OLMBMSDC:
-	case CS42L73_DMMCC:
-	case CS42L73_XSPC:
-	case CS42L73_XSPMMCC:
-	case CS42L73_ASPC:
-	case CS42L73_ASPMMCC:
-	case CS42L73_VSPC:
-	case CS42L73_VSPMMCC:
-	case CS42L73_VXSPFS:
-	case CS42L73_MIOPC:
-	case CS42L73_ADCIPC:
-	case CS42L73_MICAPREPGAAVOL:
-	case CS42L73_MICBPREPGABVOL:
-	case CS42L73_IPADVOL:
-	case CS42L73_IPBDVOL:
-	case CS42L73_PBDC:
-	case CS42L73_HLADVOL:
-	case CS42L73_HLBDVOL:
-	case CS42L73_SPKDVOL:
-	case CS42L73_ESLDVOL:
-	case CS42L73_HPAAVOL:
-	case CS42L73_HPBAVOL:
-	case CS42L73_LOAAVOL:
-	case CS42L73_LOBAVOL:
-	case CS42L73_STRINV:
-	case CS42L73_XSPINV:
-	case CS42L73_ASPINV:
-	case CS42L73_VSPINV:
-	case CS42L73_LIMARATEHL:
-	case CS42L73_LIMRRATEHL:
-	case CS42L73_LMAXHL:
-	case CS42L73_LIMARATESPK:
-	case CS42L73_LIMRRATESPK:
-	case CS42L73_LMAXSPK:
-	case CS42L73_LIMARATEESL:
-	case CS42L73_LIMRRATEESL:
-	case CS42L73_LMAXESL:
-	case CS42L73_ALCARATE:
-	case CS42L73_ALCRRATE:
-	case CS42L73_ALCMINMAX:
-	case CS42L73_NGCAB:
-	case CS42L73_ALCNGMC:
-	case CS42L73_MIXERCTL:
-	case CS42L73_HLAIPAA:
-	case CS42L73_HLBIPBA:
-	case CS42L73_HLAXSPAA:
-	case CS42L73_HLBXSPBA:
-	case CS42L73_HLAASPAA:
-	case CS42L73_HLBASPBA:
-	case CS42L73_HLAVSPMA:
-	case CS42L73_HLBVSPMA:
-	case CS42L73_XSPAIPAA:
-	case CS42L73_XSPBIPBA:
-	case CS42L73_XSPAXSPAA:
-	case CS42L73_XSPBXSPBA:
-	case CS42L73_XSPAASPAA:
-	case CS42L73_XSPAASPBA:
-	case CS42L73_XSPAVSPMA:
-	case CS42L73_XSPBVSPMA:
-	case CS42L73_ASPAIPAA:
-	case CS42L73_ASPBIPBA:
-	case CS42L73_ASPAXSPAA:
-	case CS42L73_ASPBXSPBA:
-	case CS42L73_ASPAASPAA:
-	case CS42L73_ASPBASPBA:
-	case CS42L73_ASPAVSPMA:
-	case CS42L73_ASPBVSPMA:
-	case CS42L73_VSPAIPAA:
-	case CS42L73_VSPBIPBA:
-	case CS42L73_VSPAXSPAA:
-	case CS42L73_VSPBXSPBA:
-	case CS42L73_VSPAASPAA:
-	case CS42L73_VSPBASPBA:
-	case CS42L73_VSPAVSPMA:
-	case CS42L73_VSPBVSPMA:
-	case CS42L73_MMIXCTL:
-	case CS42L73_SPKMIPMA:
-	case CS42L73_SPKMXSPA:
-	case CS42L73_SPKMASPA:
-	case CS42L73_SPKMVSPMA:
-	case CS42L73_ESLMIPMA:
-	case CS42L73_ESLMXSPA:
-	case CS42L73_ESLMASPA:
-	case CS42L73_ESLMVSPMA:
-	case CS42L73_IM1:
-	case CS42L73_IM2:
+	case CS42L73_DEVID_AB ... CS42L73_DEVID_E:
+	case CS42L73_REVID ... CS42L73_IM2:
 		return true;
 	default:
 		return false;
-- 
2.1.0
