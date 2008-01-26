From: "Jerone Young" <jerone@gmail.com>
Subject: [PATCH] Add missing additional verbs for SPDIF with
	AD1984 & thinkpad
Date: Fri, 25 Jan 2008 20:04:40 -0600
Message-ID: <9f50a7a00801251804t37834229td1f6768c95563c8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.156])
	by alsa0.perex.cz (Postfix) with ESMTP id EF1612435D
	for <alsa-devel@alsa-project.org>; Sat, 26 Jan 2008 03:04:41 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id l27so774673fgb.44
	for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2008 18:04:41 -0800 (PST)
Content-Disposition: inline
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
List-Id: alsa-devel@alsa-project.org

Additional verbs are missing for IEC958 code for the AD1984 in
thinkpads. This is identical to the verbs in AD19884. I missed these
in my patch last month.

Signed-off-by: Jerone Young <jerone@gmail.com>

diff -r dcc1b9d533d3 alsa-kernel/pci/hda/patch_analog.c
--- a/alsa-kernel/pci/hda/patch_analog.c	Fri Jan 25 19:49:19 2008 -0600
+++ b/alsa-kernel/pci/hda/patch_analog.c	Fri Jan 25 19:51:05 2008 -0600
@@ -3188,6 +3188,9 @@ static struct hda_verb ad1984_thinkpad_i
 	{0x20, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(4)},
 	/* enable EAPD bit */
 	{0x12, AC_VERB_SET_EAPD_BTLENABLE, 0x02},
+	/* SPDIF output selector */
+	{0x02, AC_VERB_SET_CONNECT_SEL, 0x0}, /* PCM */
+	{0x1b, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE | 0x27}, /* 0dB */
 };

 /* Digial MIC ADC NID 0x05 + 0x06 */
