From: "M G" <lists.mg@googlemail.com>
Subject: Re: snd-hda-intel: Fix volume-wheel and microphone on
	Fujitsu-Siemens Amilo M3438G
Date: Thu, 6 Mar 2008 18:15:32 +0100
Message-ID: <74d457500803060915y682558fancca3691d5abd340d@mail.gmail.com>
References: <74d457500802060814j64532e95v8c689cbb491c6b46@mail.gmail.com>
	<s5hir12kpne.wl%tiwai@suse.de>
	<74d457500802061502m31d412dap15009aad087b1b75@mail.gmail.com>
	<s5h8x1vy87l.wl%tiwai@suse.de>
	<74d457500802101048t2b92cb98qe6290a0186a00585@mail.gmail.com>
	<s5h8x1rwqh7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.224])
	by alsa0.perex.cz (Postfix) with ESMTP id BA4BF24453
	for <alsa-devel@alsa-project.org>; Thu,  6 Mar 2008 18:15:35 +0100 (CET)
Received: by wr-out-0506.google.com with SMTP id 58so4181201wri.8
	for <alsa-devel@alsa-project.org>; Thu, 06 Mar 2008 09:15:34 -0800 (PST)
In-Reply-To: <s5h8x1rwqh7.wl%tiwai@suse.de>
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

On Mon, Feb 11, 2008 at 2:51 PM, Takashi Iwai <tiwai@suse.de> wrote:
>
>  OK, now applied to HG tree.  Thanks.
>
>
>  Takashi
>



It has already been a great improvement but I encountered 2 more problems:

On first use (i.e. when loading the module for the first time after
compiling it) the mixer displayed Mic as capture source but I couldn't
capture anything. When I switch to CD and then back to Mic it starts
working. It seems that the value is initialized to 0x00 but there is
no corresponding capture device on this model since the mic is 0x01 so
it needs to be initialized to 0x01.

Another thing: I can set the capture volume to a maximum of 14dB.
Above that the quality starts to degrade rapidly and at about 17dB it
goes completely dead. With VREF50 I can raise the capture all the way
up to 35dB.



diff -r 72360e8993f7 pci/hda/patch_realtek.c
--- a/pci/hda/patch_realtek.c	Thu Mar 06 16:58:35 2008 +0100
+++ b/pci/hda/patch_realtek.c	Thu Mar 06 17:37:22 2008 +0100
@@ -1927,6 +1927,7 @@ static void alc880_uniwill_p53_unsol_eve
  * HP = 0x14, speaker-out = 0x15, mic = 0x18
  */
 static struct hda_verb alc880_pin_f1734_init_verbs[] = {
+	{0x07, AC_VERB_SET_CONNECT_SEL, 0x01},
 	{0x10, AC_VERB_SET_CONNECT_SEL, 0x02},
 	{0x11, AC_VERB_SET_CONNECT_SEL, 0x00},
 	{0x12, AC_VERB_SET_CONNECT_SEL, 0x01},
@@ -1939,7 +1940,7 @@ static struct hda_verb alc880_pin_f1734_

 	{0x18, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80},
 	{0x18, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},
-	{0x19, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF80},
+	{0x19, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF50},
 	{0x19, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},
 	{0x1a, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
 	{0x1a, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
