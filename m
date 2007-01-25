From: "Christopher \"Monty\" Montgomery" <xiphmont@gmail.com>
Subject: Re: [PATCH] alsa: correct nonsensical sysfs device
	symlinks
Date: Thu, 25 Jan 2007 09:11:32 -0500
Message-ID: <806dafc20701250611u9935049ja8f88deb2aac4d40__14686.4635673866$1169734456$gmane$org@mail.gmail.com>
References: <806dafc20701241750t53b86babn36831cadc7dfa76c@mail.gmail.com>
	<20070125042616.GA21813@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.224])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9DB302DE
	for <alsa-devel@alsa-project.org>; Thu, 25 Jan 2007 15:11:33 +0100 (MET)
Received: by nz-out-0506.google.com with SMTP id l8so396147nzf
	for <alsa-devel@alsa-project.org>; Thu, 25 Jan 2007 06:11:32 -0800 (PST)
In-Reply-To: <20070125042616.GA21813@kroah.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Greg KH <greg@kroah.com>
Cc: fedora-desktop-list@redhat.com, alsa-devel@alsa-project.org, jrb@redhat.com, linux-kernel@vger.kernel.org, mclasen@redhat.com, Pierre Ossman <drzeus@drzeus.cx>, Lennart Poettering <lennart@poettering.net>, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

On 1/24/07, Greg KH <greg@kroah.com> wrote:
> I don't understand, where does the symlink currently point to?  It looks
> correct to me on my machines:

My machines and the fedora rawhide machines using the 2.6.20-rcX
releases look nothing like what you pasted.  If they did, hald would
be working...  (I'll note that bugs have also been logged against
Pulse and HAL by users having trouble, so it's not just us.)

What you said you have:

> $ tree /sys/class/sound/
> /sys/class/sound/
> |-- card0 -> ../../devices/pci0000:00/0000:00:1b.0/card0
> |-- controlC0 -> ../../devices/pci0000:00/0000:00:1b.0/card0/controlC0
> |-- pcmC0D0c -> ../../devices/pci0000:00/0000:00:1b.0/card0/pcmC0D0c
> |-- pcmC0D0p -> ../../devices/pci0000:00/0000:00:1b.0/card0/pcmC0D0p
> |-- pcmC0D2c -> ../../devices/pci0000:00/0000:00:1b.0/card0/pcmC0D2c
> |-- pcmC0D6c -> ../../devices/pci0000:00/0000:00:1b.0/card0/pcmC0D6c
> |-- pcmC0D6p -> ../../devices/pci0000:00/0000:00:1b.0/card0/pcmC0D6p
> `-- timer -> ../../devices/virtual/sound/timer

What we actually have here:
/sys/class/sound/
|-- adsp
|   |-- dev
|   |-- device -> ../../../class/sound/card0
|   |-- power
|   |   `-- wakeup
|   |-- subsystem -> ../../../class/sound
|   `-- uevent
|-- audio
|   |-- dev
|   |-- device -> ../../../class/sound/card0
|   |-- power
|   |   `-- wakeup
|   |-- subsystem -> ../../../class/sound
|   `-- uevent
|-- audio1
|   |-- dev
|   |-- device -> ../../../class/sound/card1
|   |-- power
|   |   `-- wakeup
|   |-- subsystem -> ../../../class/sound
|   `-- uevent
|-- card0
|   |-- 0-0:AD1981B
|   |   |-- bus -> ../../../../bus/ac97
|   |   |-- power
|   |   |   `-- wakeup
|   |   |-- subsystem -> ../../../../bus/ac97
|   |   `-- uevent
|   |-- device -> ../../../devices/pci0000:00/0000:00:1f.5
|   |-- power
|   |   `-- wakeup
|   |-- sound:adsp -> ../../../class/sound/adsp
|   |-- sound:audio -> ../../../class/sound/audio
|   |-- sound:controlC0 -> ../../../class/sound/controlC0
|   |-- sound:dsp -> ../../../class/sound/dsp
|   |-- sound:mixer -> ../../../class/sound/mixer
|   |-- sound:pcmC0D0c -> ../../../class/sound/pcmC0D0c
|   |-- sound:pcmC0D0p -> ../../../class/sound/pcmC0D0p
|   |-- sound:pcmC0D1c -> ../../../class/sound/pcmC0D1c
|   |-- sound:pcmC0D2c -> ../../../class/sound/pcmC0D2c
|   |-- sound:pcmC0D3c -> ../../../class/sound/pcmC0D3c
|   |-- sound:pcmC0D4p -> ../../../class/sound/pcmC0D4p
|   |-- subsystem -> ../../../class/sound
|   `-- uevent
|-- card1
|   |-- 1-1:unknown codec
|   |   |-- bus -> ../../../../bus/ac97
|   |   |-- power
|   |   |   `-- wakeup
|   |   |-- subsystem -> ../../../../bus/ac97
|   |   `-- uevent
|   |-- device -> ../../../devices/pci0000:00/0000:00:1f.6
|   |-- power
|   |   `-- wakeup
|   |-- sound:audio1 -> ../../../class/sound/audio1
|   |-- sound:controlC1 -> ../../../class/sound/controlC1
|   |-- sound:dsp1 -> ../../../class/sound/dsp1
|   |-- sound:mixer1 -> ../../../class/sound/mixer1
|   |-- sound:pcmC1D0c -> ../../../class/sound/pcmC1D0c
|   |-- sound:pcmC1D0p -> ../../../class/sound/pcmC1D0p
|   |-- subsystem -> ../../../class/sound
|   `-- uevent
|-- controlC0
|   |-- dev
|   |-- device -> ../../../class/sound/card0
|   |-- power
|   |   `-- wakeup
|   |-- subsystem -> ../../../class/sound
|   `-- uevent
|-- controlC1
|   |-- dev
|   |-- device -> ../../../class/sound/card1
|   |-- power
|   |   `-- wakeup
|   |-- subsystem -> ../../../class/sound
|   `-- uevent
|-- dsp
|   |-- dev
|   |-- device -> ../../../class/sound/card0
|   |-- power
|   |   `-- wakeup
|   |-- subsystem -> ../../../class/sound
|   `-- uevent
|-- dsp1
|   |-- dev
|   |-- device -> ../../../class/sound/card1
|   |-- power
|   |   `-- wakeup
|   |-- subsystem -> ../../../class/sound
|   `-- uevent
|-- mixer
|   |-- dev
|   |-- device -> ../../../class/sound/card0
|   |-- power
|   |   `-- wakeup
|   |-- subsystem -> ../../../class/sound
|   `-- uevent
|-- mixer1
|   |-- dev
|   |-- device -> ../../../class/sound/card1
|   |-- power
|   |   `-- wakeup
|   |-- subsystem -> ../../../class/sound
|   `-- uevent
|-- pcmC0D0c
|   |-- dev
|   |-- device -> ../../../class/sound/card0
|   |-- pcm_class
|   |-- power
|   |   `-- wakeup
|   |-- subsystem -> ../../../class/sound
|   `-- uevent
|-- pcmC0D0p
|   |-- dev
|   |-- device -> ../../../class/sound/card0
|   |-- pcm_class
|   |-- power
|   |   `-- wakeup
|   |-- subsystem -> ../../../class/sound
|   `-- uevent
|-- pcmC0D1c
|   |-- dev
|   |-- device -> ../../../class/sound/card0
|   |-- pcm_class
|   |-- power
|   |   `-- wakeup
|   |-- subsystem -> ../../../class/sound
|   `-- uevent
|-- pcmC0D2c
|   |-- dev
|   |-- device -> ../../../class/sound/card0
|   |-- pcm_class
|   |-- power
|   |   `-- wakeup
|   |-- subsystem -> ../../../class/sound
|   `-- uevent
|-- pcmC0D3c
|   |-- dev
|   |-- device -> ../../../class/sound/card0
|   |-- pcm_class
|   |-- power
|   |   `-- wakeup
|   |-- subsystem -> ../../../class/sound
|   `-- uevent
|-- pcmC0D4p
|   |-- dev
|   |-- device -> ../../../class/sound/card0
|   |-- pcm_class
|   |-- power
|   |   `-- wakeup
|   |-- subsystem -> ../../../class/sound
|   `-- uevent
|-- pcmC1D0c
|   |-- dev
|   |-- device -> ../../../class/sound/card1
|   |-- pcm_class
|   |-- power
|   |   `-- wakeup
|   |-- subsystem -> ../../../class/sound
|   `-- uevent
|-- pcmC1D0p
|   |-- dev
|   |-- device -> ../../../class/sound/card1
|   |-- pcm_class
|   |-- power
|   |   `-- wakeup
|   |-- subsystem -> ../../../class/sound
|   `-- uevent
|-- seq
|   |-- dev
|   |-- power
|   |   `-- wakeup
|   |-- subsystem -> ../../../class/sound
|   `-- uevent
|-- sequencer
|   |-- dev
|   |-- power
|   |   `-- wakeup
|   |-- subsystem -> ../../../class/sound
|   `-- uevent
|-- sequencer2
|   |-- dev
|   |-- power
|   |   `-- wakeup
|   |-- subsystem -> ../../../class/sound
|   `-- uevent
`-- timer
    |-- dev
    |-- power
    |   `-- wakeup
    |-- subsystem -> ../../../class/sound
    `-- uevent

In other words... no resemblance whatsoever, so something is obviously
very wrong.  That is a vanilla 2.6.20-rc5 build on a fedora rawhide
machine, the rawhide-tweaked kernel and 2.6.19-rc6-mm2 produces the
same results.

With my patch, at least the 'old' entries for the pcm devices are as
before (The patch doesn't 'correct' anything for the device types
other than pcm and control, adsp and audio are still messed):

/sys/class/sound/
|-- adsp
|   |-- dev
|   |-- device -> ../../../class/sound/card0
|   |-- power
|   |   `-- wakeup
|   |-- subsystem -> ../../../class/sound
|   `-- uevent
|-- audio
|   |-- dev
|   |-- device -> ../../../class/sound/card0
|   |-- power
|   |   `-- wakeup
|   |-- subsystem -> ../../../class/sound
|   `-- uevent
|-- audio1
|   |-- dev
|   |-- device -> ../../../class/sound/card1
|   |-- power
|   |   `-- wakeup
|   |-- subsystem -> ../../../class/sound
|   `-- uevent
|-- card0
|   |-- 0-0:AD1981B
|   |   |-- bus -> ../../../../bus/ac97
|   |   |-- power
|   |   |   `-- wakeup
|   |   |-- subsystem -> ../../../../bus/ac97
|   |   `-- uevent
|   |-- device -> ../../../devices/pci0000:00/0000:00:1f.5
|   |-- power
|   |   `-- wakeup
|   |-- sound:adsp -> ../../../class/sound/adsp
|   |-- sound:audio -> ../../../class/sound/audio
|   |-- sound:dsp -> ../../../class/sound/dsp
|   |-- sound:mixer -> ../../../class/sound/mixer
|   |-- subsystem -> ../../../class/sound
|   `-- uevent
|-- card1
|   |-- 1-1:unknown codec
|   |   |-- bus -> ../../../../bus/ac97
|   |   |-- power
|   |   |   `-- wakeup
|   |   |-- subsystem -> ../../../../bus/ac97
|   |   `-- uevent
|   |-- device -> ../../../devices/pci0000:00/0000:00:1f.6
|   |-- power
|   |   `-- wakeup
|   |-- sound:audio1 -> ../../../class/sound/audio1
|   |-- sound:dsp1 -> ../../../class/sound/dsp1
|   |-- sound:mixer1 -> ../../../class/sound/mixer1
|   |-- subsystem -> ../../../class/sound
|   `-- uevent
|-- controlC0
|   |-- dev
|   |-- device -> ../../../devices/pci0000:00/0000:00:1f.5
|   |-- power
|   |   `-- wakeup
|   |-- subsystem -> ../../../class/sound
|   `-- uevent
|-- controlC1
|   |-- dev
|   |-- device -> ../../../devices/pci0000:00/0000:00:1f.6
|   |-- power
|   |   `-- wakeup
|   |-- subsystem -> ../../../class/sound
|   `-- uevent
|-- dsp
|   |-- dev
|   |-- device -> ../../../class/sound/card0
|   |-- power
|   |   `-- wakeup
|   |-- subsystem -> ../../../class/sound
|   `-- uevent
|-- dsp1
|   |-- dev
|   |-- device -> ../../../class/sound/card1
|   |-- power
|   |   `-- wakeup
|   |-- subsystem -> ../../../class/sound
|   `-- uevent
|-- mixer
|   |-- dev
|   |-- device -> ../../../class/sound/card0
|   |-- power
|   |   `-- wakeup
|   |-- subsystem -> ../../../class/sound
|   `-- uevent
|-- mixer1
|   |-- dev
|   |-- device -> ../../../class/sound/card1
|   |-- power
|   |   `-- wakeup
|   |-- subsystem -> ../../../class/sound
|   `-- uevent
|-- pcmC0D0c
|   |-- dev
|   |-- device -> ../../../devices/pci0000:00/0000:00:1f.5
|   |-- pcm_class
|   |-- power
|   |   `-- wakeup
|   |-- subsystem -> ../../../class/sound
|   `-- uevent
|-- pcmC0D0p
|   |-- dev
|   |-- device -> ../../../devices/pci0000:00/0000:00:1f.5
|   |-- pcm_class
|   |-- power
|   |   `-- wakeup
|   |-- subsystem -> ../../../class/sound
|   `-- uevent
|-- pcmC0D1c
|   |-- dev
|   |-- device -> ../../../devices/pci0000:00/0000:00:1f.5
|   |-- pcm_class
|   |-- power
|   |   `-- wakeup
|   |-- subsystem -> ../../../class/sound
|   `-- uevent
|-- pcmC0D2c
|   |-- dev
|   |-- device -> ../../../devices/pci0000:00/0000:00:1f.5
|   |-- pcm_class
|   |-- power
|   |   `-- wakeup
|   |-- subsystem -> ../../../class/sound
|   `-- uevent
|-- pcmC0D3c
|   |-- dev
|   |-- device -> ../../../devices/pci0000:00/0000:00:1f.5
|   |-- pcm_class
|   |-- power
|   |   `-- wakeup
|   |-- subsystem -> ../../../class/sound
|   `-- uevent
|-- pcmC0D4p
|   |-- dev
|   |-- device -> ../../../devices/pci0000:00/0000:00:1f.5
|   |-- pcm_class
|   |-- power
|   |   `-- wakeup
|   |-- subsystem -> ../../../class/sound
|   `-- uevent
|-- pcmC1D0c
|   |-- dev
|   |-- device -> ../../../devices/pci0000:00/0000:00:1f.6
|   |-- pcm_class
|   |-- power
|   |   `-- wakeup
|   |-- subsystem -> ../../../class/sound
|   `-- uevent
|-- pcmC1D0p
|   |-- dev
|   |-- device -> ../../../devices/pci0000:00/0000:00:1f.6
|   |-- pcm_class
|   |-- power
|   |   `-- wakeup
|   |-- subsystem -> ../../../class/sound
|   `-- uevent
|-- seq
|   |-- dev
|   |-- power
|   |   `-- wakeup
|   |-- subsystem -> ../../../class/sound
|   `-- uevent
|-- sequencer
|   |-- dev
|   |-- power
|   |   `-- wakeup
|   |-- subsystem -> ../../../class/sound
|   `-- uevent
|-- sequencer2
|   |-- dev
|   |-- power
|   |   `-- wakeup
|   |-- subsystem -> ../../../class/sound
|   `-- uevent
`-- timer
    |-- dev
    |-- power
    |   `-- wakeup
    |-- subsystem -> ../../../class/sound
    `-- uevent

Monty

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
