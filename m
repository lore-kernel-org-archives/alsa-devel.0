From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] alsa: correct nonsensical sysfs device
	symlinks
Date: Wed, 24 Jan 2007 20:26:16 -0800
Message-ID: <20070125042616.GA21813@kroah.com>
References: <806dafc20701241750t53b86babn36831cadc7dfa76c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 87EFE2B4
	for <alsa-devel@alsa-project.org>; Thu, 25 Jan 2007 05:27:23 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <806dafc20701241750t53b86babn36831cadc7dfa76c@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Christopher Monty Montgomery <xiphmont@gmail.com>
Cc: fedora-desktop-list@redhat.com, alsa-devel@alsa-project.org, jrb@redhat.com, linux-kernel@vger.kernel.org, mclasen@redhat.com, Pierre Ossman <drzeus@drzeus.cx>, Lennart Poettering <lennart@poettering.net>, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 24, 2007 at 08:50:06PM -0500, Christopher Monty Montgomery wrote:
> This patch was generated against 2.6.20-rc5; it fixes a bug that
> cropped up in a late 2.6.19-mm kernel.
> 
> When ALSA's sysfs device creation was converted from using
> class_device_create() to device_create(), the fourth param from
> class_device_create() [dev] was simply plugged into arg 2 of
> device_create().  This causes the device symlinks under all the
> class/sound/[node] to point to nonsensical places.  Among other
> problems, this breaks HAL and all audio software that depends on HAL.

I don't understand, where does the symlink currently point to?  It looks
correct to me on my machines:

$ tree /sys/class/sound/
/sys/class/sound/
|-- card0 -> ../../devices/pci0000:00/0000:00:1b.0/card0
|-- controlC0 -> ../../devices/pci0000:00/0000:00:1b.0/card0/controlC0
|-- pcmC0D0c -> ../../devices/pci0000:00/0000:00:1b.0/card0/pcmC0D0c
|-- pcmC0D0p -> ../../devices/pci0000:00/0000:00:1b.0/card0/pcmC0D0p
|-- pcmC0D2c -> ../../devices/pci0000:00/0000:00:1b.0/card0/pcmC0D2c
|-- pcmC0D6c -> ../../devices/pci0000:00/0000:00:1b.0/card0/pcmC0D6c
|-- pcmC0D6p -> ../../devices/pci0000:00/0000:00:1b.0/card0/pcmC0D6p
`-- timer -> ../../devices/virtual/sound/timer

What do the symlinks look on your machine?

thanks,

greg k-h

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
