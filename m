From: alex dot baldacchino dot alsasub at gmail dot com
	<alex.baldacchino.alsasub@gmail.com>
Subject: Re: Via VT2020: issues with kernel 2.6.38.{2,
 3} (alsa 1.0.23) - working with 2.6.33.2 (alsa 1.0.21)
Date: Mon, 9 May 2011 01:16:01 +0200
Message-ID: <BANLkTimUVPCHzyASs3s0MtNV1DNKS0BfzA@mail.gmail.com>
References: <BANLkTi=9d5A+oa6Bh+fis4+WY=xNbbnkYw@mail.gmail.com>
	<BANLkTi=i+3CJLtY-1OtkFnvrzWz4+=d=VA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 2CF721037FF
	for <alsa-devel@alsa-project.org>;
	Mon,  9 May 2011 01:16:04 +0200 (CEST)
Received: by wyg36 with SMTP id 36so3975077wyg.38
	for <alsa-devel@alsa-project.org>; Sun, 08 May 2011 16:16:03 -0700 (PDT)
In-Reply-To: <BANLkTi=i+3CJLtY-1OtkFnvrzWz4+=d=VA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello,

Thanks for your answer.

2011/5/8 Raymond Yau <superquad.vortex2@gmail.com>:
> 2011/5/8 alex dot baldacchino dot alsasub at gmail dot com <
> alex.baldacchino.alsasub@gmail.com>
>
>>
>> [...]
>>
> Try the snapshot tarballs or git at
>
> http://www.kernel.org/pub/linux/kernel/people/tiwai/docs/HD-Audio.html

Sorry, I've never build modules out of 'regular' kernel build process
before, so I'd have a few questions. I'm using a tarball kernel source
for kernel 2.6.38.2 taken from kernel.org, patched with some stuff
required by my distro (therein aufs) and incremented to version
2.6.38.3 with the incremental patch taken, again, from kernel.org; I
have no git version of the kernel to pull the alsa git snapshot over,
and am not using a 'real' broadband connection at the moment, so I'd
prefer not to download a full git source. For accomplishing your
request, I've downloaded tarball alsa-driver-20110508.tar.bz2 from the
ftp pointed to within the document linked above

Now my questions. In file 'SUPPORTED_KERNELS' I can read the following:

"The alsa-drivers in this package are designed for the following kernels:

 - Vanilla 2.6.29 or earlier
 - Vanilla 2.4.31 or earlier
 - Vanilla 2.2.26 or earlier

It's not guaranteed that they work with any newer version than above
or modified kernels by distributors."

Is it a harmless warning, or should I upgrade my kernel to version
2.6.38.4 or 38.5 and test the embedded alsa version (more recent than
current one I'm using) instead?

I've modified, through menuconfig ( CONFIG_LOCALVERSION ), my kernel
version string, so I can modify configuration at whim and keep
different flavors of the same kernel version (though I'm using just
one flavor for k 2.6.38.3); moreover, kernel source path doesn't match
the exact 'name' of the kernel (as named in /lib/modules/<version>)
and is located out of /usr/src, though actual source path is symlinked
from within kernel install dir as standard 'source' subdir (pointing
to <path/to/linux-2.6.33.2>). Hence, for what I've understood from
file 'INSTALL' in ALSA snapshot tarball, kernel version and source
tree should be easily identified by configure script, however, in case
there is a risk that ALSA snapshot gets misconfigured I prefer to ask
if I'd better to explicitly pass in --with-kernel and --with-build
options.

But my main concern is about overall configuration. For better
comparison, I'd wish to use the very same sound configuration I've
used in kernel build process, but that's unclear to me if configure
script for ALSA snapshot will retrieve and use it, or if the script
can just use configuration options passed in/default values (as a
'regular' configure script).

Lastly, do I need to enable debug? (that is, is it required for better
alsa-info output?)

For now, below I'm posting alsa-info.sh output for current
configuration and for kernel 2.6.33.2 (with working sound), hoping
this can help for comparison.

>
> Post the output of alsa-info.sh
>
> What is the model of your computer (desktop/notebook) ?
>

Sorry I didn't make it more clear in my previous post. Mine is a
home-build desktop with an Asrock motherboard (I don't know of any
notebook with asrock MoBo), model '890GX Extreme3', with integrated
graphics (Radeon HD4290) and audio (via vt2020 codec and ati hdmi), NB
AMD 890GX, SB850; CPU is a Phenom II X4 (kernel 2.6.38.3 is configured
with amd specific optimizations while retaining x86 compatibility
code; kernel 2.6.33.2 has no cpu-related optimization enabled; both
are 32 bit); 4 GB ddr3 memory; no expansion cards.

If more details are needed, I'll write full specs.

> How many audio jacks ?
>

Rear panel: 5 jacks for 7.1 channels audio + 1 Optical SPDIF OUT port
On board: front panel audio header for ac97/hd audio (connectors for
mic, left, right - I'm not sure if that's for supporting 2 independent
mono jacks, one stereo (headset) jack or both cases, I don't know
neither ac97, nor hd audio specifications) + header for 1 hdmi_spdif
out (to be connected to a discrete vga with hdmi capabilities)

> https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/729659
>
> It seem that vt2020 is 10 channels HDA with 5 [Audio Output] 0x8, 0x9, 0xa,
> 0xb and 0xc
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>

__________________________________________________
OUTPUT FOR ALSA-INFO.SH -- K 2.6.38.3 - ALSA 1.0.23:

http://www.pastebin.ca/2055424

__________________________________________________
OUTPUT FOR ALSA-INFO.SH -- K2.6.33.2 - ALSA 1.0.21:

http://pastebin.ca/2055501
