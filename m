From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH 4/8] emu10k1 multichannel support
Date: Tue, 15 Feb 2005 19:47:18 -0500
Message-ID: <1108514838.3772.33.camel@krustophenia.net>
References: <1108514291.3772.19.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-lcIvFd4/N6TGheCVsTcB"
In-Reply-To: <1108514291.3772.19.camel@krustophenia.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
Cc: Takashi Iwai <tiwai@suse.de>, James Courtier-Dutton <James@superbug.co.uk>
List-Id: alsa-devel@alsa-project.org


--=-lcIvFd4/N6TGheCVsTcB
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2005-02-15 at 19:38 -0500, Lee Revell wrote:
> This series of patches adds a 16 channel non interleaved PCM playback
> device, hw:x,3, to the emu10k1 driver.  It also adds support for the
> newly discovered per channel half loop interrupt.

Add support for half loop interrupt.

Signed-Off-By: Lee Revell <rlrevell@joe-job.com>

--=-lcIvFd4/N6TGheCVsTcB
Content-Disposition: attachment; filename=io.c.patch
Content-Type: text/x-patch; name=io.c.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

Index: alsa-v009-test/alsa-kernel/pci/emu10k1/io.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/io.c,v
retrieving revision 1.8
diff -u -r1.8 io.c
--- alsa-v009-test/alsa-kernel/pci/emu10k1/io.c	22 Nov 2004 18:36:05 -0000	1.8
+++ alsa-v009-test/alsa-kernel/pci/emu10k1/io.c	15 Feb 2005 23:51:23 -0000
@@ -170,6 +170,63 @@
 	spin_unlock_irqrestore(&emu->emu_lock, flags);
 }
 
+void snd_emu10k1_voice_half_loop_intr_enable(emu10k1_t *emu, unsigned int voicenum)
+{
+	unsigned long flags;
+	unsigned int val;
+
+	spin_lock_irqsave(&emu->emu_lock, flags);
+	/* voice interrupt */
+	if (voicenum >= 32) {
+		outl(HLIEH << 16, emu->port + PTR);
+		val = inl(emu->port + DATA);
+		val |= 1 << (voicenum - 32);
+	} else {
+		outl(HLIEL << 16, emu->port + PTR);
+		val = inl(emu->port + DATA);
+		val |= 1 << voicenum;
+	}
+	outl(val, emu->port + DATA);
+	spin_unlock_irqrestore(&emu->emu_lock, flags);
+}
+
+void snd_emu10k1_voice_half_loop_intr_disable(emu10k1_t *emu, unsigned int voicenum)
+{
+	unsigned long flags;
+	unsigned int val;
+
+	spin_lock_irqsave(&emu->emu_lock, flags);
+	/* voice interrupt */
+	if (voicenum >= 32) {
+		outl(HLIEH << 16, emu->port + PTR);
+		val = inl(emu->port + DATA);
+		val &= ~(1 << (voicenum - 32));
+	} else {
+		outl(HLIEL << 16, emu->port + PTR);
+		val = inl(emu->port + DATA);
+		val &= ~(1 << voicenum);
+	}
+	outl(val, emu->port + DATA);
+	spin_unlock_irqrestore(&emu->emu_lock, flags);
+}
+
+void snd_emu10k1_voice_half_loop_intr_ack(emu10k1_t *emu, unsigned int voicenum)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&emu->emu_lock, flags);
+	/* voice interrupt */
+	if (voicenum >= 32) {
+		outl(HLIPH << 16, emu->port + PTR);
+		voicenum = 1 << (voicenum - 32);
+	} else {
+		outl(HLIPL << 16, emu->port + PTR);
+		voicenum = 1 << voicenum;
+	}
+	outl(voicenum, emu->port + DATA);
+	spin_unlock_irqrestore(&emu->emu_lock, flags);
+}
+
 void snd_emu10k1_voice_set_loop_stop(emu10k1_t *emu, unsigned int voicenum)
 {
 	unsigned long flags;

--=-lcIvFd4/N6TGheCVsTcB--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
