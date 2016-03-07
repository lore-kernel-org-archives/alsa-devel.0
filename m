From: Nicolai Stange <nicstange@gmail.com>
Subject: Re: [alsa-devel] ERROR: "isa_io_base"	[sound/pci/vx222/snd-vx222.ko] undefined!
Date: Mon, 07 Mar 2016 12:28:05 +0100
Message-ID: <87k2leplx6.fsf@gmail.com>
References: <201603062033.hlQ3Lfnm%fengguang.wu@intel.com>
	<56DD39D5.80402@ti.com> <s5h1t7md2lr.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5h1t7md2lr.wl-tiwai@suse.de> (Takashi Iwai's message of "Mon,
	07 Mar 2016 11:06:08 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, kbuild test robot <fengguang.wu@intel.com>, Nicolai Stange <nicstange@gmail.com>, alsa-devel@alsa-project.org, Michal Simek <monstr@monstr.eu>, kbuild-all@01.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> writes:

> On Mon, 07 Mar 2016 09:20:37 +0100,
> Tomi Valkeinen wrote:
>> 
>> On 06/03/16 14:38, kbuild test robot wrote:
>> > Hi Nicolai,
>> > 
>> > FYI, the error/warning still remains.
>> > 
>> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> > head:   67944024c1cdd897e49a09b0d6af3ea38d1388ca
>> > commit: 48fd8ecf29e3c1199432e173858f5ca4bc529738 framebuffer: disable vgacon on microblaze arch
>> > date:   7 months ago
>> > config: microblaze-allmodconfig (attached as .config)
>> > reproduce:
>> >         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>> >         chmod +x ~/bin/make.cross
>> >         git checkout 48fd8ecf29e3c1199432e173858f5ca4bc529738
>> >         # save the attached .config to linux build tree
>> >         make.cross ARCH=microblaze 
>> > 
>> > All errors (new ones prefixed by >>):
>> > 
>> >>> ERROR: "isa_io_base" [sound/pci/vx222/snd-vx222.ko] undefined!
>> >>> ERROR: "isa_io_base" [sound/pci/trident/snd-trident.ko] undefined!
>> >>> ERROR: "isa_io_base" [sound/pci/snd-via82xx.ko] undefined!
>> >>> ERROR: "isa_io_base" [sound/pci/snd-via82xx-modem.ko] undefined!
>> >>> ERROR: "isa_io_base" [sound/pci/snd-sonicvibes.ko] undefined!
>> >>> ERROR: "isa_io_base" [sound/pci/snd-maestro3.ko] undefined!
>> >>> ERROR: "isa_io_base" [sound/pci/snd-fm801.ko] undefined!
>> >>> ERROR: "isa_io_base" [sound/pci/snd-es1968.ko] undefined!
>> >>> ERROR: "isa_io_base" [sound/pci/snd-es1938.ko] undefined!
>> >>> ERROR: "isa_io_base" [sound/pci/snd-ens1371.ko] undefined!
>> >>> ERROR: "isa_io_base" [sound/pci/snd-ens1370.ko] undefined!
>> >>> ERROR: "isa_io_base" [sound/pci/snd-cmipci.ko] undefined!
>> >>> ERROR: "isa_io_base" [sound/pci/snd-azt3328.ko] undefined!
>> >>> ERROR: "isa_io_base" [sound/pci/snd-als300.ko] undefined!
>> >>> ERROR: "isa_io_base" [sound/pci/riptide/snd-riptide.ko] undefined!
>> >>> ERROR: "isa_io_base" [sound/pci/pcxhr/snd-pcxhr.ko] undefined!
>> >>> ERROR: "isa_io_base" [sound/pci/oxygen/snd-oxygen-lib.ko] undefined!
>> >>> ERROR: "isa_io_base" [sound/pci/lx6464es/snd-lx6464es.ko] undefined!
>> >>> ERROR: "isa_io_base" [sound/pci/ice1712/snd-ice1724.ko] undefined!
>> >>> ERROR: "isa_io_base" [sound/pci/ice1712/snd-ice1712.ko] undefined!
>> 
>> I didn't look at this closely, but sounds like disabling vgacon on
>> microblaze made sound drivers fail because they or microblaze does not
>> enable something in the kernel config.
>
> Looking at this shortly, the reason is that EXPORT_SYMBOL() of
> isa_io_base is missing for microblaze.  I don't know, though, why the
> mentioned commit triggers the bug, too...
>

I think that the commit in question did not introduce the isa_io_base
link failer but rather revealed it in that the make process now proceeds
to the module linking phase.

>From the commit message in question:

    Fix an allmodconfig link failer on microblaze:
      drivers/built-in.o: In function `vgacon_save_screen':
      drivers/video/console/.tmp_vgacon.o:(.text+0x8fc10):
        undefined reference to `screen_info'

Thus, it seems to me, that before that commit, the linking of vmlinux
failed. AFAICT, module linking always comes after vmlinux has been built,
justifying my above statement.


In my opinion, the best thing to do here is simply to EXPORT_SYMBOL() the
isa_io_base as Takashi said.

Who sends a patch? Takashi, do you want to?
If you don't, I'd gladly do it.

Thanks,

Nicolai
