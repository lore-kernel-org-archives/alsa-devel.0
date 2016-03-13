From: "Vittorio Gambaletta (VittGam)" <linuxbugs@vittgam.net>
Subject: [PATCH] ALSA: intel8x0: Add clock quirk entry for
	AD1981B on IBM ThinkPad X41.
Date: Sun, 13 Mar 2016 22:19:34 +0100
Message-ID: <linux-patch-20160313-1@vittgam.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.vittgam.net (server1.vittgam.net [213.239.197.142])
 by alsa0.perex.cz (Postfix) with ESMTP id 69D7D260535
 for <alsa-devel@alsa-project.org>; Sun, 13 Mar 2016 22:19:37 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-sound@vger.kernel.org, alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The clock measurement on the AC'97 audio card found in the IBM ThinkPad X41
will often fail, so add a quirk entry to fix it.

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=441087
Cc: <stable@vger.kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Vittorio Gambaletta <linuxbugs@vittgam.net>
---

When the clock measurement doesn't fail, the `pos` variable after line 2861
will be around 48367, but when it does fail it will be somewhere between
45000 and 47500. So the bus clock gets set between 48500 and 52000 (!),
resulting in faster audio for rates with final clocks below 48000, and
distorted audio for rates with final clocks above 48000.

The problem is always reproducible on kernel 4.4.5, but very rarely on 3.13.

This patch fixes the problem for my computer, and will also speed up module
loading a bit as said on Bugzilla, but I've got some questions regarding
other hardware...

Do we want to protect against overclock for all hardware, by never setting
the measured bus clock higher than 48000? Do we actually risk burning or
otherwise permanently ruining something here, or not? Does hardware clocked
above 48000 exist?

Also, is line 2874 actually correct? As `pos` gets higher, the bus clock gets
lower, and vice versa. Note that in this function the bus clock is always
48000 before it gets updated here; so the code first computes 48000 * 48000,
and then it divides the result by `pos`. It doesn't seem right to me... By the
way, the history of that line goes beyond Git (so before kernel 2.6.12-rc2).

--- a/sound/pci/intel8x0.c
+++ b/sound/pci/intel8x0.c
@@ -2879,6 +2879,7 @@
 
 static struct snd_pci_quirk intel8x0_clock_list[] = {
 	SND_PCI_QUIRK(0x0e11, 0x008a, "AD1885", 41000),
+	SND_PCI_QUIRK(0x1014, 0x0581, "AD1981B", 48000),
 	SND_PCI_QUIRK(0x1028, 0x00be, "AD1885", 44100),
 	SND_PCI_QUIRK(0x1028, 0x0177, "AD1980", 48000),
 	SND_PCI_QUIRK(0x1028, 0x01ad, "AD1981B", 48000),
