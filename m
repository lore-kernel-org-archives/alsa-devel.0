From: James Pearson <james-p@moving-picture.com>
Subject: Re: hda-intel: no codecs initialized with
 Teradici	sound card and ALSA 1.0.17
Date: Tue, 10 Nov 2009 10:32:57 +0000
Message-ID: <4AF94159.6010601@moving-picture.com>
References: <4AF84FEE.6000206@moving-picture.com>
	<s5hd43qg6rv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moving-picture.com (mpc-26.sohonet.co.uk [193.203.82.251])
	by alsa0.perex.cz (Postfix) with ESMTP id B025F103850
	for <alsa-devel@alsa-project.org>; Tue, 10 Nov 2009 11:32:57 +0100 (CET)
In-Reply-To: <s5hd43qg6rv.wl%tiwai@suse.de>
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

Takashi Iwai wrote:
> At Mon, 09 Nov 2009 17:22:54 +0000,
> James Pearson wrote:
> 
>>I'm using CentOS 5.3 (which uses ALSA 1.0.17) and a Teradici KVM over IP 
>>extender - which has an hda_intel type sound chipset
>>
>>However, when the snd_hda_intel module is loaded, dmesg reports:
>>
>>PCI: Enabling device 0000:04:00.1 (0000 -> 0002)
>>ACPI: PCI Interrupt 0000:04:00.1[A] -> GSI 16 (level, low) -> IRQ 177
>>PCI: Setting latency timer of device 0000:04:00.1 to 64
>>hda-intel: no codecs initialized
> 
> 
> This means that the driver is loaded but the codec wasn't found
> on the hardware.  It's rather a hardware issue, as it seems.

But the same card works with ALSA 1.0.15 - patched to support the 
Teradici controller - using a patch based on:

<http://marc.info/?l=git-commits-head&m=121607380317261&w=2>

So how can it be a hardware issue?

I'm going to see if a more recent version of ALSA works ...

James Pearson
