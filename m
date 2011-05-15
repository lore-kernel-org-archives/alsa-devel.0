From: Jeffrey Scott Flesher Gmail <jeffrey.scott.flesher@gmail.com>
Subject: Re: GR-55 Driver
Date: Sat, 14 May 2011 23:39:22 -0700
Message-ID: <1305441562.2850.7.camel@TrinaryDragon>
References: <1305224448.5083.37.camel@TrinaryDragon>
	<BANLkTimvr7TkmTiCeeNOeOH66++sHnCfbg@mail.gmail.com>
	<1305233604.8214.2.camel@TrinaryDragon>
	<BANLkTikGVDWxShJOsfspETPVwKDqcJtNOg@mail.gmail.com>
	<1305253856.5076.65.camel@TrinaryDragon>
	<BANLkTi=jj7cjxgmOpH+EHnUMuazqLOEsZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 9DEA3103806
	for <alsa-devel@alsa-project.org>;
	Sun, 15 May 2011 08:39:28 +0200 (CEST)
Received: by pwi9 with SMTP id 9so2034801pwi.38
	for <alsa-devel@alsa-project.org>; Sat, 14 May 2011 23:39:25 -0700 (PDT)
In-Reply-To: <BANLkTi=jj7cjxgmOpH+EHnUMuazqLOEsZA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I have read this article over a few times, trying to remove the kernel
and Reiser4 instructions; and I got a little confused; although I did
get it to compile and now it see's the GR-55 as a sound device; I tried
to jack it to the output but got no audio; what should I do to test it?

Do these instructions look correct?
# Path: /home/username/dev/sound/alsa/sound-2.6

git clone
git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git
cd sound-2.6
git apply 0001-ALSA-snd-usb-add-quirks-for-Roland-GR-55.patch
sudo cp -vi /boot/config-$(uname -r) .config
sudo make oldconfig
# a lot of questions, I hit enter for default

make-kpkg clean

# Since I'm not building the kernel I didn't do this:
# But since this is the only command that will write the new kernel,
# what do I do?

nice fakeroot make-kpkg --initrd --append-to-version=-lockard
--overlay-dir=/home/username/dev/kernel/source kernel-image
kernel-headers

If I was to guess; I'd change the overlay-dir to use the kernel in the
sound-2.6 folder?

nice fakeroot make-kpkg --initrd --append-to-version=-gr55
--overlay-dir=/home/username/dev/sound/alsa/sound-2.6/kernel
kernel-image kernel-headers

# is this right?

cd ..
ls -lh
sudo dpkg -i linux-*.deb
uname -r # 2.6.39-rc3-gr55+

One thing strange was that it locked up on reboot, showing rc3, but a
reset with previous kernel, I saw the gr55 version so I picked it; it
worked as stated above; just don't know why it didn't set this version
as default, maybe a step I missed.

Sorry it took so long to get back to this; I had a hard drive go bad; so
I installed Ubuntu Studio 11.04; so I'm doing this against the newest
kernel. 

Thanks

From: Daniel Mack <zonque@gmail.com>
To: Jeffrey Scott Flesher Gmail <jeffrey.scott.flesher@gmail.com>
Subject: Re: [alsa-devel] GR-55 Driver
Date: Fri, 13 May 2011 09:24:57 +0200

On Fri, May 13, 2011 at 4:30 AM, Jeffrey Scott Flesher Gmail
<jeffrey.scott.flesher@gmail.com> wrote:
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

Hope this helps, looking forward to your results.

Thanks,
Daniel
