From: "Kan-I Jyo" <cecilhsujp@gmail.com>
Subject: Re: [Fwd: [Alsa-user] Intel Poulsbo(SCH) chipset does
	not recognize Adi 1986 codec under linux]]
Date: Wed, 25 Jun 2008 21:00:46 +0900
Message-ID: <1e8a3dd0806250500p6f7a343u89b11d42f556347@mail.gmail.com>
References: <1e8a3dd0806241840m76069ad8sa35058ad8ddb843b@mail.gmail.com>
	<s5hprq5onxz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.185])
	by alsa0.perex.cz (Postfix) with ESMTP id 289572436C
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Jun 2008 14:00:48 +0200 (CEST)
Received: by fk-out-0910.google.com with SMTP id b27so3251301fka.0
	for <alsa-devel@alsa-project.org>; Wed, 25 Jun 2008 05:00:47 -0700 (PDT)
In-Reply-To: <s5hprq5onxz.wl%tiwai@suse.de>
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
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Dear Takashi,

Thank you for your reply.

2008/6/25 Takashi Iwai <tiwai@suse.de>:

> The patch below enables the probe on 4th slot on SCH.

Thank you for your patch.
I have applied your patch and recompiled the snd-hda-intel kernel
module. A reload of the newly compiled driver stiil gives me the "no
codec found!" output in dmesg.

After inserting some snd_printk() into the hda_intel.c, it seems that
this "azx_readw()" macro in azx_reset() function returns a "0" to
chip->codec_mask on our not-working device. It is returns a "1" on the
other working device though.

<hda_intel.c>
-- snip --
 751         /* detect codecs */
 752         if (!chip->codec_mask) {
 753                 chip->codec_mask = azx_readw(chip, STATESTS);
 754                 snd_printk("codec_mask = 0x%x\n", chip->codec_mask);
-- snip --

<dmesg>
-- snip --
PCI: Setting latency timer of device 0000:00:1b.0 to 64
ALSA /root/alsa-driver-1.0.17rc2/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:2069:
chipset global capabilities = 0x2200
ALSA /root/alsa-driver-1.0.17rc2/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:912:
HDA snoop disabled, enabling ... OK
ALSA /root/alsa-driver-1.0.17rc2/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:754:
codec_mask = 0x0
ALSA /root/alsa-driver-1.0.17rc2/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:2142:
hda-intel: no codecs found!
ACPI: PCI interrupt for device 0000:00:1b.0 disabled

For I am not an expert in sound driver development, the above are
provided for reference. But would this be some kind of hint?

-- 
Sincerely,

Jyo
