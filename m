From: Li Bo <liboat@gmail.com>
Subject: Re: [PATCH 12/31] HDA patch_via.c: Add VIA_JACK_EVENT
	process in via_unsol_event.
Date: Thu, 8 Oct 2009 13:44:55 +0800
Message-ID: <16685ee0910072244m7b8ca2faud45dfb52f65f8319@mail.gmail.com>
References: <16685ee0910050726t5808289eve198bd4ef7c96d4f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f212.google.com (mail-fx0-f212.google.com
	[209.85.220.212])
	by alsa0.perex.cz (Postfix) with ESMTP id 72041103962
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Oct 2009 07:44:55 +0200 (CEST)
Received: by fxm8 with SMTP id 8so5188048fxm.45
	for <alsa-devel@alsa-project.org>; Wed, 07 Oct 2009 22:44:55 -0700 (PDT)
In-Reply-To: <16685ee0910050726t5808289eve198bd4ef7c96d4f@mail.gmail.com>
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
Cc: tiwai@suse.de, LoganLi@viatech.com.cn, HaraldWelte@viatech.com, lydiawang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

[ALSA] HDA VIA: Add VIA_JACK_EVENT process in via_unsol_event.

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>

---
 sound/pci/hda/patch_via.c |   38 +++++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -124,6 +124,7 @@

 #define VIA_HP_EVENT		0x01
 #define VIA_GPIO_EVENT		0x02
+#define VIA_JACK_EVENT		0x04

 enum {
 	VIA_CTL_WIDGET_VOL,
@@ -1413,10 +1414,12 @@
 				  unsigned int res)
 {
 	res >>= 26;
-	if (res == VIA_HP_EVENT)
+	if (res & VIA_HP_EVENT)
 		via_hp_automute(codec);
-	else if (res == VIA_GPIO_EVENT)
+	if (res & VIA_GPIO_EVENT)
 		via_gpio_control(codec);
+	if (res & VIA_JACK_EVENT)
+		set_jack_power_state(codec);
 }

 static int via_init(struct hda_codec *codec)
@@ -1878,7 +1881,8 @@
 };

 static struct hda_verb vt1709_uniwill_init_verbs[] = {
-	{0x20, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_HP_EVENT},
+	{0x20, AC_VERB_SET_UNSOLICITED_ENABLE,
+	 AC_USRSP_EN | VIA_HP_EVENT | VIA_JACK_EVENT},
 	{ }
 };

@@ -2514,7 +2518,15 @@
 };

 static struct hda_verb vt1708B_uniwill_init_verbs[] = {
-	{0x1D, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_HP_EVENT},
+	{0x1d, AC_VERB_SET_UNSOLICITED_ENABLE,
+	 AC_USRSP_EN | VIA_HP_EVENT | VIA_JACK_EVENT},
+	{0x19, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_JACK_EVENT},
+	{0x1a, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_JACK_EVENT},
+	{0x1b, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_JACK_EVENT},
+	{0x1c, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_JACK_EVENT},
+	{0x1e, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_JACK_EVENT},
+	{0x22, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_JACK_EVENT},
+	{0x23, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_JACK_EVENT},
 	{ }
 };

@@ -3009,7 +3021,15 @@
 };

 static struct hda_verb vt1708S_uniwill_init_verbs[] = {
-	{0x1D, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_HP_EVENT},
+	{0x1d, AC_VERB_SET_UNSOLICITED_ENABLE,
+	 AC_USRSP_EN | VIA_HP_EVENT | VIA_JACK_EVENT},
+	{0x19, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_JACK_EVENT},
+	{0x1a, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_JACK_EVENT},
+	{0x1b, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_JACK_EVENT},
+	{0x1c, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_JACK_EVENT},
+	{0x1e, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_JACK_EVENT},
+	{0x22, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_JACK_EVENT},
+	{0x23, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_JACK_EVENT},
 	{ }
 };

@@ -3448,8 +3468,12 @@
 };

 static struct hda_verb vt1702_uniwill_init_verbs[] = {
-	{0x01, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_GPIO_EVENT},
-	{0x17, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_HP_EVENT},
+	{0x17, AC_VERB_SET_UNSOLICITED_ENABLE,
+	 AC_USRSP_EN | VIA_HP_EVENT | VIA_JACK_EVENT},
+	{0x14, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_JACK_EVENT},
+	{0x15, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_JACK_EVENT},
+	{0x16, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_JACK_EVENT},
+	{0x18, AC_VERB_SET_UNSOLICITED_ENABLE, AC_USRSP_EN | VIA_JACK_EVENT},
 	{ }
 };
