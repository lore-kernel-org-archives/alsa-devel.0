From: Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH] ASoC: sgtl5000: Use snd_soc_kcontrol_codec()
Date: Thu, 20 Jul 2017 14:36:17 -0300
Message-ID: <1500572177-14939-1-git-send-email-fabio.estevam@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM03-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam03on0082.outbound.protection.outlook.com [104.47.42.82])
 by alsa0.perex.cz (Postfix) with ESMTP id 006E6266CC9
 for <alsa-devel@alsa-project.org>; Thu, 20 Jul 2017 19:36:37 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org, richard.leitner@skidata.com
List-Id: alsa-devel@alsa-project.org

Since commit a72952672005 ("ASoC: sgtl5000: add avc support") the
following kernel crash happens after running a 'reboot' command:

ALSA: Storing mixer settings...
[   20.031604] Unable to handle kernel paging request at virtual address fffffffe
[   20.039268] pgd = de2a0000
[   20.041999] [fffffffe] *pgd=8fffd861, *pte=00000000, *ppte=00000000
[   20.048387] Internal error: Oops: 80000007 [#1] SMP ARM 

The function that takes a kcontrol parameter and returns the
codec that registered the control is snd_soc_kcontrol_codec(),
so use the correct function to fix the problem.

Fixes: a72952672005 ("ASoC: sgtl5000: add avc support")
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 sound/soc/codecs/sgtl5000.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 8f6814c..80f6d1d 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -409,7 +409,7 @@ static int dac_put_volsw(struct snd_kcontrol *kcontrol,
 static int avc_get_threshold(struct snd_kcontrol *kcontrol,
 			     struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	int db, i;
 	u16 reg = snd_soc_read(codec, SGTL5000_DAP_AVC_THRESHOLD);
 
@@ -442,7 +442,7 @@ static int avc_get_threshold(struct snd_kcontrol *kcontrol,
 static int avc_put_threshold(struct snd_kcontrol *kcontrol,
 			     struct snd_ctl_elem_value *ucontrol)
 {
-	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
 	int db;
 	u16 reg;
 
-- 
2.7.4
