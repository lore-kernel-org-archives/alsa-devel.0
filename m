From: "Risto Suominen" <risto.suominen@gmail.com>
Subject: Re: Releasing IRQs in older kernels
Date: Tue, 15 Apr 2008 20:36:04 +0300
Message-ID: <46e1c7760804151036l439fd36ayba074118690e212e@mail.gmail.com>
References: <46e1c7760804141348g11097cfcte0c06c204d7d28cd@mail.gmail.com>
	<s5h4pa3483i.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.245])
	by alsa0.perex.cz (Postfix) with ESMTP id 70D402473F
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Apr 2008 19:36:06 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c36so588412ana.80
	for <alsa-devel@alsa-project.org>; Tue, 15 Apr 2008 10:36:04 -0700 (PDT)
In-Reply-To: <s5h4pa3483i.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2008/4/15, Takashi Iwai <tiwai@suse.de>:
>
> Does the patch below work?
>

That was fast. And so simple. Thank you. It works :)

Risto

ps. There are still warnings about 2nd argument's types in
ppc/pmac_old.c lines 1248, 1256 , and 1263. Maybe this is the right
way to get rid of them:

--- ppc/pmac_old.c.orig	2008-02-05 11:23:23.000000000 +0200
+++ ppc/pmac_old.c	2008-04-15 20:05:56.000000000 +0300
@@ -725,7 +725,7 @@ void snd_pmac_beep_dma_stop(struct snd_p
  * interrupt handlers
  */
 static irqreturn_t
-snd_pmac_tx_intr(int irq, void *devid, struct pt_regs *regs)
+snd_pmac_tx_intr(int irq, void *devid)
 {
 	struct snd_pmac *chip = devid;
 	snd_pmac_pcm_update(chip, &chip->playback);
@@ -734,7 +734,7 @@ snd_pmac_tx_intr(int irq, void *devid, s


 static irqreturn_t
-snd_pmac_rx_intr(int irq, void *devid, struct pt_regs *regs)
+snd_pmac_rx_intr(int irq, void *devid)
 {
 	struct snd_pmac *chip = devid;
 	snd_pmac_pcm_update(chip, &chip->capture);
@@ -743,7 +743,7 @@ snd_pmac_rx_intr(int irq, void *devid, s


 static irqreturn_t
-snd_pmac_ctrl_intr(int irq, void *devid, struct pt_regs *regs)
+snd_pmac_ctrl_intr(int irq, void *devid)
 {
 	struct snd_pmac *chip = devid;
 	int ctrl = in_le32(&chip->awacs->control);
