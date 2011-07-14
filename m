From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [regression] "BUG: Unable to handle kernel paging request at
 ffffc90013cd8000" and no sound card recognized
Date: Thu, 14 Jul 2011 13:27:02 -0500
Message-ID: <20110714182702.GA14014@elie>
References: <s5haage43qz.wl%tiwai@suse.de>
 <1301396296.32453.1.camel@s1499.it.kth.se>
 <s5h7hbi41xs.wl%tiwai@suse.de>
 <1301480744.21366.110.camel@hp.my.own.domain>
 <s5hpqp827sv.wl%tiwai@suse.de>
 <1301486370.32453.9.camel@s1499.it.kth.se>
 <4D932C71.10402@ladisch.de>
 <1301524966.21366.118.camel@hp.my.own.domain>
 <1301906577.32453.92.camel@s1499.it.kth.se>
 <s5h8vvqv0r2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5h8vvqv0r2.wl%tiwai@suse.de>
Sender: linux-pci-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: srs@kth.se, Clemens Ladisch <clemens@ladisch.de>, 619034@bugs.debian.org, alsa-devel@alsa-project.org, 613979-submitter@bugs.debian.org, linux-pci@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi,

Takashi Iwai wrote:
>>> On Wed, 2011-03-30 at 15:13 +0200, Clemens Ladisch wrote:
>>>>>>>>> Svante Signell wrote:

>>>>>>>>>> During boot of kernel 2.6.38 (and 2.6.37) udev bugs out:
>>>>>>>>>> Waiting for /dev to be fully populated
>>>>>>>>>> BUG: Unable to handle kernel paging request at ffffc90013cd8000
>>>>>>>>>> axz_probe+ ... [snd_hda_intel]
>>>>>>>>>> ...lots of output lost...
>>>>>>>>>> udevadm timeout 180 sec ...
>>>>>>>>>> udevd[390]: worker [439] failed while handling
>>>>>>>>>> '/devices/pci0000:80/0000:80:01.0'
>>>>>>>>>> 
>>>>>>>>>> After the timeout the boot continues! Have not yet tested if sound is
>>>>>>>>>> functional.
[...]
>>>> This is the azx_readw(chip, GCAP) in azx_create(); chip->remap_addr is
>>>> 0xffffc90011c08000 which does look like a valid pointer, but isn't.
[...]
> The point where it Oops implies that the problem isn't in the sound
> driver but rather in a breakage in a deeper level, either PCI core,
> x86 mm or ACPI/BIOS.
>
> Any chance to bisect the kernel?

Svante bisected it to v2.6.34-rc1~218^2~27 (x86/pci: Use
resource_size_t in update_res, 2010-02-10) --- thanks.  Which is
pretty weird, since I think phys_addr_t on an amd64 machine (and hence
resource_size_t) would be 64 bits, making that commit a no-op.

Svante, more questions (sorry):

 - could you try booting b74fd238a9cf and b74fd238a9cf^ again
   (to make sure we haven't hit a heisenbug) and send the
   corresponding full dmesg and .config files?

Puzzled,
Jonathan
