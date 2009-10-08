From: Li Bo <liboat@gmail.com>
Subject: Re: [PATCH 29/31] HDA patch_via.c: Change PW4 connect
	select default to to MW0.
Date: Thu, 8 Oct 2009 13:50:53 +0800
Message-ID: <16685ee0910072250k443190b9p917023ba0b841f18@mail.gmail.com>
References: <16685ee0910050728j7e948ffelddd60650944d93e4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f225.google.com (mail-bw0-f225.google.com
	[209.85.218.225])
	by alsa0.perex.cz (Postfix) with ESMTP id 01207103A20
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Oct 2009 07:50:53 +0200 (CEST)
Received: by bwz25 with SMTP id 25so1488839bwz.32
	for <alsa-devel@alsa-project.org>; Wed, 07 Oct 2009 22:50:53 -0700 (PDT)
In-Reply-To: <16685ee0910050728j7e948ffelddd60650944d93e4@mail.gmail.com>
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

[ALSA] HDA VIA: Change PW4 connect select default to to MW0.

According to customer request, hp should be default to redirected mode,
i.e. PW4 connect select default to to MW0.

, i.e. PW4 should be default to MW0.

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>

---
 sound/pci/hda/patch_via.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -1538,8 +1538,8 @@
 	{0x1a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},
 	{0x1b, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},
 	
-	/* Setup default input to PW4 */
-	{0x20, AC_VERB_SET_CONNECT_SEL, 0x1},
+	/* Setup default input MW0 to PW4 */
+	{0x20, AC_VERB_SET_CONNECT_SEL, 0},
 	/* PW9 Output enable */
 	{0x25, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x40},
 	{ }
@@ -2683,8 +2683,8 @@
 	{0x1f, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},
 	{0x20, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},

-	/* Set input of PW4 as AOW4 */
-	{0x20, AC_VERB_SET_CONNECT_SEL, 0x1},
+	/* Set input of PW4 as MW0 */
+	{0x20, AC_VERB_SET_CONNECT_SEL, 0},
 	/* PW9 Output enable */
 	{0x24, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x40},
 	{ }
@@ -3237,7 +3237,7 @@
 	{0x27, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_ZERO},

 	/* Setup default input to PW4 */
-	{0x1d, AC_VERB_SET_CONNECT_SEL, 0x1},
+	{0x1d, AC_VERB_SET_CONNECT_SEL, 0},
 	/* PW9 Output enable */
 	{0x20, AC_VERB_SET_PIN_WIDGET_CONTROL, 0x40},
 	/* PW10 Input enable */
