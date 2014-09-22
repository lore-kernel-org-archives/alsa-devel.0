From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 4/5] hda-spec: Add secret eq verbs for IDT
Date: Mon, 22 Sep 2014 13:09:05 +0200
Message-ID: <1411384146-23286-5-git-send-email-david.henningsson@canonical.com>
References: <1411384146-23286-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 07A732652C3
 for <alsa-devel@alsa-project.org>; Mon, 22 Sep 2014 13:09:13 +0200 (CEST)
In-Reply-To: <1411384146-23286-1-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

These verbs exist according to the driver, but we know nothing about
them, except they are used to calibrate some EQ.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 hda-spec.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/hda-spec.c b/hda-spec.c
index 935dcc0..0f42a2d 100644
--- a/hda-spec.c
+++ b/hda-spec.c
@@ -113,24 +113,35 @@ static struct xhda_verb_table idt_92hd7xx_verbs[] = {
 };
 
 /*
- * IDT 92HD8xx
+ * IDT 92HD8xx and 92HD9xx
  */
 static struct xhda_verb_table idt_92hd8xx_verbs[] = {
 	{ 0xf70, get_cached_verb, "get_gpio_polarity" },
 	{ 0x770, set_cached_verb, "set_gpio_polarity" },
 	{ 0xf71, get_cached_verb, "get_gpio_drive" },
 	{ 0x771, set_cached_verb, "set_gpio_drive" },
+	{ 0x772, set_cached_verb, "set_eq_10" }, /* undocumented */
 	{ 0xf74, get_cached_verb, "get_aux_audio" },
 	{ 0x774, set_cached_verb, "set_aux_audio" },
 	{ 0xf78, get_cached_verb, "get_dmic" },
 	{ 0x778, set_cached_verb, "set_dmic" },
 	{ 0xf80, get_cached_verb, "get_dac_mode" },
 	{ 0x780, set_cached_verb, "set_dac_mode" },
+	{ 0x782, set_cached_verb, "set_eq_9" }, /* undocumented */
 	{ 0xf84, get_cached_verb, "get_adc_mode" },
 	{ 0x784, set_cached_verb, "set_adc_mode" },
 	{ 0xf88, get_cached_verb, "get_eapd_mode" },
 	{ 0x788, set_cached_verb, "set_eapd_mode1" },
 	{ 0x789, set_cached_verb2, "set_eapd_mode2" },
+	{ 0x7a6, set_cached_verb, "set_eq_1" }, /* undocumented */
+	{ 0x7a7, set_cached_verb, "set_eq_2" }, /* undocumented */
+	{ 0x7a8, set_cached_verb, "set_eq_3" }, /* undocumented */
+	{ 0x7a9, set_cached_verb, "set_eq_4" }, /* undocumented */
+	{ 0x7aa, set_cached_verb, "set_eq_5" }, /* undocumented */
+	{ 0x7ab, set_cached_verb, "set_eq_6" }, /* undocumented */
+	{ 0x7ac, set_cached_verb, "set_eq_7" }, /* undocumented */
+	{ 0x7ad, set_cached_verb, "set_eq_8" }, /* undocumented */
+	{ 0x7b0, set_cached_verb, "set_eq_11" }, /* undocumented */
 	{ 0xfc0, get_cached_verb, "get_port_use" },
 	{ 0x7c0, set_cached_verb, "set_port_use" },
 	{ 0x7d8, set_cached_verb, "set_vs_power" },
-- 
1.9.1
