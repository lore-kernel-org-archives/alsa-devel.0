From: Mihail Zenkov <mihail.zenkov@gmail.com>
Subject: Re: [PATCH] Fix regression in emu1010 firmware loading
Date: Fri, 22 Feb 2013 11:25:27 +0000
Message-ID: <CAD-m0i_1Tkra9qht3h_Bos=TgiYJ0u4bGnKuQ9gL4s4aWm9fig@mail.gmail.com>
References: <CAD-m0i87HKAb-2DM1tWBtCTneUh9eUm2J71z3FimfD4Gwyeyiw@mail.gmail.com>
 <s5h7gm0j2fm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f45.google.com (mail-qa0-f45.google.com
 [209.85.216.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 8104C2616FA
 for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2013 12:25:29 +0100 (CET)
Received: by mail-qa0-f45.google.com with SMTP id g10so340382qah.4
 for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2013 03:25:28 -0800 (PST)
In-Reply-To: <s5h7gm0j2fm.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This patch fix regression in emu1010 firmware loading after
http://git.alsa-project.org/?p=alsa-kprivate.git;a=commitdiff;h=b209c4dfcd960ab176d4746ab7dc442a3edb4575

I just revert small part of this commit. Tested on emu1212m pci.

Signed-off-by: Mihail Zenkov <mihail.zenkov@gmail.com>

--- linux-3.8/sound/pci/emu10k1/emu10k1_main.c
+++ linux-3.8-1/sound/pci/emu10k1/emu10k1_main.c
@@ -860,6 +860,11 @@
 		}
 		snd_printk(KERN_INFO "emu1010: firmware file = %s, size = 0x%zx\n",
 			   filename, emu->firmware->size);
+		err = snd_emu1010_load_firmware(emu);
+		if (err != 0) {
+			snd_printk(KERN_INFO "emu1010: Loading Firmware file %s failed\n",
filename);
+			return err;
+		}
 	}

 	/* ID, should read & 0x7f = 0x55 when FPGA programmed. */
