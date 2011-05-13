From: Daniel Mack <zonque@gmail.com>
Subject: Re: GR-55 Driver
Date: Fri, 13 May 2011 09:29:27 +0200
Message-ID: <BANLkTim4rR6GPK20_Bkk=G+-74VG2_0RYQ@mail.gmail.com>
References: <1305224448.5083.37.camel@TrinaryDragon>
	<BANLkTimvr7TkmTiCeeNOeOH66++sHnCfbg@mail.gmail.com>
	<1305233604.8214.2.camel@TrinaryDragon>
	<BANLkTikGVDWxShJOsfspETPVwKDqcJtNOg@mail.gmail.com>
	<1305253856.5076.65.camel@TrinaryDragon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f170.google.com (mail-px0-f170.google.com
	[209.85.212.170])
	by alsa0.perex.cz (Postfix) with ESMTP id 4AD46103835
	for <alsa-devel@alsa-project.org>;
	Fri, 13 May 2011 09:29:30 +0200 (CEST)
Received: by pxi19 with SMTP id 19so1627004pxi.29
	for <alsa-devel@alsa-project.org>; Fri, 13 May 2011 00:29:27 -0700 (PDT)
In-Reply-To: <1305253856.5076.65.camel@TrinaryDragon>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jeffrey Scott Flesher Gmail <jeffrey.scott.flesher@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Jeff,

please, bear in mind two rules:

1. don't just reply to me, but always use the "reply-to-all" feature
in your mail client. This way, all people on the ALSA list can follow
the discussion and chime in.
2. don't top-post, always reply using proper quoting.

On Fri, May 13, 2011 at 4:30 AM, Jeffrey Scott Flesher Gmail
<jeffrey.scott.flesher@gmail.com> wrote:
> Thanks.
>
> I'm running Ubuntu Studio 10.04 x64 with realtime kernel from
> http://ppa.launchpad.net/abogani/ppa/ubuntu lucid (linux-realtime -
> 2.6.33-29.1); my motherboard is ASUS M4A78T-E onboard VIA sound, Nvidia 460
> GTX Video card; AMD 955 X4 CPU.
> Link to kernel used
> https://launchpad.net/~abogani/+archive/ppa/+packages?field.name_filter=&field.status_filter=published&field.series_filter=lucid
>
> I searched for instructions on how to do this, with no good results; so I
> must ask someone that knows how.

Things are a little more complicated as modern Linux distributions use
techniques like initramfs.

For Ubuntu, you should follow one of the tutorials. Two I found are here:

 https://help.ubuntu.com/community/Kernel/Compile
 http://parabing.com/2011/04/28/ubuntu-natty-a-custom-kernel-is-what-you-want/

That looks comprehensive. Just don't download the ubuntu Kernel
sources as described but clone the ALSA repository (which you already
did).

And instead of downloading the patches as described, just use "git
apply" on the file I sent you. On case you want to revert the patching
and return to the kernel you originally cloned, just call "git reset
--hard".

> Just to make sure I do this right, since I've never compiled ALSA driver
> before; these are the instructions I used:
>
> 1. git clone
> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git
> 2. cp 0001-ALSA-snd-usb-add-quirks-for-Roland-GR-55.patch /sound-2.6
> 3. cd sound-2.6
> 4. patch -p1 < ./0001-ALSA-snd-usb-add-quirks-for-Roland-GR-55.patch
> 5. make x86_64_defconfig
> 6. make
> 7. make install
>
> This worked, not tested; I still need to get the kernel to see it; I did
> this in my home directory; where should I move it?
>
> I see a file called vmlinux, 19.7 MB executable; I take it this is the new
> ALSA Driver.
>
> I do see vmlinux files that are new in these folders; which would seem to me
> that they got where they need to go with the make install command.
> /proc/4055/cwd
> /proc/4055/cwd/arch/x86/boot/compressed
>
> Now do I need to compile this into the Kernel, if so, what kernel do you
> recommend; realtime, low latency or normal; and what version?

I would first go for a normal kernel configuration, and once the
driver supports the device, care for optimisation.

HTH,
Daniel
