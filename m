From: "Timofei V. Bondarenko" <tim@ipi.ac.ru>
Subject: cmipci CM_FLINKOFF disables multinchannel playback
Date: Mon, 29 Oct 2007 17:14:16 +0300
Message-ID: <4725EAB8.9070804@ipi.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ipi.ac.ru (blackpeer.ipi.ac.ru [83.149.227.82])
	by alsa0.perex.cz (Postfix) with ESMTP id A6818244A0
	for <alsa-devel@alsa-project.org>; Mon, 29 Oct 2007 15:14:17 +0100 (CET)
Received: from black.ipi.ac.ru (black.ipi.ac.ru [192.168.1.44])
	by ipi.ac.ru (8.14.1/8.14.1) with ESMTP id l9TEEG9j029677
	for <alsa-devel@alsa-project.org>; Mon, 29 Oct 2007 17:14:17 +0300
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

Hi.

I found the latest cmipci driver cannot playback in multichannel mode 
anymore.

My hardware is 'CMI8738 model 55' attempting to play 2 or 4 channels 
through the 2nd DAC i get no sound at all. 6 ch produces sound only at 
center/bass while front and rear still mute.

I found the root of problem in redefinition of some bits of the 
CM_REG_MISC_CTRL (0x18) register.
Was: CM_FLINKON=0x40, CM_FLINKOFF=0x20
Now it is: CM_FLINKON=0x80 CM_FLINKOFF=0x40

Note the CM_FLINKOFF does collide with the CM_MUTECH1=0x40 bit.
This bit disables playback on 2nd DAC.

The CM_FLINKOFF/CM_FLINKON bits used in the 'Modem' mixer control only.
During startup the mixer turns the modem off somewhere and this disables
2nd DAC as well.

Complete removal of this 'Modem' control fixes the problem.
Is it an acceptable solution?

I guess the snd_cmipci_control_switches could be removed too.

Regards.
	Tim.
--- alsa-driver-hg20071027/alsa-kernel/pci/cmipci.c	2007-09-18 
04:00:10.000000000 +0400
+++ alsa-driver/alsa-kernel/pci/cmipci.c	2007-10-29 17:09:31.000000000 +0300
@@ -2389,7 +2389,6 @@ DEFINE_BIT_SWITCH_ARG(fourch, CM_REG_MIS
  // DEFINE_BIT_SWITCH_ARG(line_rear, CM_REG_MIXER1, CM_REAR2LIN, 1, 0);
  // DEFINE_BIT_SWITCH_ARG(line_bass, CM_REG_LEGACY_CTRL, 
CM_CENTR2LIN|CM_BASE2LIN, 0, 0);
  // DEFINE_BIT_SWITCH_ARG(joystick, CM_REG_FUNCTRL1, CM_JYSTK_EN, 0, 
0); /* now module option */
-DEFINE_SWITCH_ARG(modem, CM_REG_MISC_CTRL, CM_FLINKON|CM_FLINKOFF, 
CM_FLINKON, 0, 0);

  #define DEFINE_SWITCH(sname, stype, sarg) \
  { .name = sname, \
@@ -2597,7 +2596,7 @@ static struct snd_kcontrol_new snd_cmipc
  /* card control switches */
  static struct snd_kcontrol_new snd_cmipci_control_switches[] 
__devinitdata = {
  	// DEFINE_CARD_SWITCH("Joystick", joystick), /* now module option */
-	DEFINE_CARD_SWITCH("Modem", modem),
+//	DEFINE_CARD_SWITCH("Modem", modem),
  };
