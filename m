From: Logan Li <loganli@viatech.com.cn>
Subject: [PATCH 28/30] ALSA: HDA VIA: Change PW4 connect select
 default to to MW0.
Date: Sat, 10 Oct 2009 19:08:50 +0800
Message-ID: <4AD06B42.3050604@viatech.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from exchtp08.via.com.tw (exchtp08.via.com.tw [61.66.243.7])
	by alsa0.perex.cz (Postfix) with ESMTP id DC863103B9D
	for <alsa-devel@alsa-project.org>;
	Sat, 10 Oct 2009 13:08:42 +0200 (CEST)
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
Cc: tiwai@suse.de, HaraldWelte@viatech.com, LydiaWang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

From: Lydia Wang <lydiawang@viatech.com.cn>
Subject: ALSA: HDA VIA: Change PW4 connect select default to to MW0.

According to customer request, hp should be default to redirected mode,
i.e. PW4 connect select default to to MW0.

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>
Signed-off-by: Logan Li <loganli@viatech.com.cn>

---
 sound/pci/hda/patch_via.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -1541,8 +1541,8 @@
 	{0x1a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},
 	{0x1b, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},
 	
-	/* Setup default input to PW4 */
-	{0x20, AC_VERB_SET_CONNECT_SEL, 0x1},
+	/* Setup default input MW0 to PW4 */
+	{0x20, AC_VERB_SET_CONNECT_SEL, 0},
 	/* PW9 Output enable */
 	{0x25, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x40},
 	{ }
@@ -2685,8 +2685,8 @@
 	{0x1f, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},
 	{0x20, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},
 
-	/* Set input of PW4 as AOW4 */
-	{0x20, AC_VERB_SET_CONNECT_SEL, 0x1},
+	/* Set input of PW4 as MW0 */
+	{0x20, AC_VERB_SET_CONNECT_SEL, 0},
 	/* PW9 Output enable */
 	{0x24, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x40},
 	{ }
@@ -3239,7 +3239,7 @@
 	{0x27, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},
 
 	/* Setup default input to PW4 */
-	{0x1d, AC_VERB_SET_CONNECT_SEL, 0x1},
+	{0x1d, AC_VERB_SET_CONNECT_SEL, 0},
 	/* PW9 Output enable */
 	{0x20, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x40},
 	/* PW10 Input enable */
