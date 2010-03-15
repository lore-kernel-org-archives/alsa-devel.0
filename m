From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: cmipci and sound skipping ?
Date: Mon, 15 Mar 2010 13:17:20 +0100
Message-ID: <4B9E2550.4030404@ladisch.de>
References: <20100313201138.GA25034@eagle102.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 9A57A103816
	for <alsa-devel@alsa-project.org>; Mon, 15 Mar 2010 13:17:22 +0100 (CET)
In-Reply-To: <20100313201138.GA25034@eagle102.home.lan>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Matija Nalis <mnalis-alsadev@voyager.hr>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Matija Nalis wrote:
> My card is "Asonic C-Media8738, 4 channel" and mostly works with snd_cmipci
> driver - it is just that (even on completely unloaded system) the sound is
> (very annoyingly) skipping.
> ...
> ALSA pcm_lib.c:316: BUG: pcmC0D0p:0, pos = 4294918144, buffer size = 16384, period size = 1024
> 
> Note that the pos is *always* the same (4294918144 = 0xffff4000 = -16384) which might be important.

This looks like a hardware bug.

It's possible that we can get a valid pointer by reading the register
multiple times.  Please try the patch below.


Regards
Clemens


diff --git a/sound/pci/cmipci.c b/sound/pci/cmipci.c
index 1ded64e..8416b8a 100644
--- a/sound/pci/cmipci.c
+++ b/sound/pci/cmipci.c
@@ -941,13 +941,21 @@ static snd_pcm_uframes_t snd_cmipci_pcm_pointer(struct cmipci *cm, struct cmipci
 						struct snd_pcm_substream *substream)
 {
 	size_t ptr;
-	unsigned int reg;
+	unsigned int reg, rem, tries;
+
 	if (!rec->running)
 		return 0;
 #if 1 // this seems better..
 	reg = rec->ch ? CM_REG_CH1_FRAME2 : CM_REG_CH0_FRAME2;
-	ptr = rec->dma_size - (snd_cmipci_read_w(cm, reg) + 1);
-	ptr >>= rec->shift;
+	for (tries = 0; tries < 5; tries++) {
+		rem = snd_cmipci_read_w(cm, reg);
+		if (rem < rec->dma_size)
+			goto ok;
+	} 
+	printk(KERN_ERR "cmipci: invalid PCM pointer: %#x\n", rem);
+	return SNDRV_PCM_POS_XRUN;
+ok:
+	ptr = (rec->dma_size - (rem + 1)) >> rec->shift;
 #else
 	reg = rec->ch ? CM_REG_CH1_FRAME1 : CM_REG_CH0_FRAME1;
 	ptr = snd_cmipci_read(cm, reg) - rec->offset;
