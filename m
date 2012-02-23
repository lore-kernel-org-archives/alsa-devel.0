From: Stephen Warren <swarren@nvidia.com>
Subject: Re: multiple, non-physically accesible,
 HDMI devices listed for Intel IbexPeak ALC269VB
Date: Thu, 23 Feb 2012 08:17:55 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17BD8BC961@HQMAIL01.nvidia.com>
References: <CAH=dYrFudvU_CVkz6B7nz3mB8fyOx6HaiaxgukfAjNnW8MOLYw@mail.gmail.com>
	<74CDBE0F657A3D45AFBB94109FB122FF17BD8BC635@HQMAIL01.nvidia.com>
	<20120222215206.GA3517@burratino>
	<CAH=dYrGuG0WfBFAMVmJdT28pckZ3TXutRq61-K++ui5VXSr+YQ@mail.gmail.com>
	<4F45F934.7040409@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 42BB51041EC
	for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2012 17:18:07 +0100 (CET)
In-Reply-To: <4F45F934.7040409@canonical.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>, Andres Cimmarusti <acimmarusti@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>, "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "660111@bugs.debian.org" <660111@bugs.debian.org>
List-Id: alsa-devel@alsa-project.org

David Henningsson wrote at Thursday, February 23, 2012 1:31 AM:
> On 02/23/2012 01:01 AM, Andres Cimmarusti wrote:
> >> If the new two pins can be never used, i.e. physically unreachable,
> >> we may disable these pins by giving the proper default pin-config
> >> values.  Usually it's a job of BIOS.  But if BIOS doesn't do it, user
> >> need to do it manually.
> >>
> >> Build your kernel with CONFIG_SND_HDA_HWDEP=y,
> >> CONFIG_SND_HDA_RECONFIG=y, CONFIG_SND_HDA_PATCH_LOADER=y.
> >> I guess most of distro kernels are built with them.
> >> Then create a file containing below in /lib/firmware, such as,
> >> /lib/firmware/ibx-hdmi:
> >>
> >> ================================================================
> >> [codec]
> >> 0x80862804 0x80860101 3
> >> [pincfg]
> >> 0x04 0x411111f0
> >> 0x06 0x411111f0
> >> ================================================================
> >>
> >> Now pass this file to "patch" module option for snd-hda-intel.
> >> For example, create a file in /etc/modprobe.d/,
> >> e.g. /etc/modprobe.d/50-hdmi.conf, containing the line
> >>
> >> options snd-hda-intel patch="ibx-hdmi"
> >>
> >> Then reload the driver or reboot.  This will disable pins 0x04 and
> >> 0x06 so that only the pin 0x05 will be used.
> >
> > I've tested this workaround and it works well. I don't suppose this
> > could be added as a quirk to the kernel for this particular device?
> > (when and only if there's only one physically accessible HDMI
> > connector).
> 
> Stephen, could you comment on this? Are we guaranteed a certain board
> configuration (i e which pins are physically connected or not) given a
> PCI SSID, or anything else that can be used as a key to a quirk table? I
> think I've asked you before and that the answer was "no", but my memory
> could be failing me.

Any quirks would definitely have to include the PCI subsystem vendor ID
and subsystem device ID to stand any chance of working; the main dev and
vendor IDs certainly aren't enough.

For NVIDIA GPUs, my expectation is that matching on all 4 IDs would often
provide a unique key that determines which quirks to apply. However, the
subsystem IDs are assigned by OEMs, and I have no idea whether they re-
use the same IDs for different boards sometimes (I believe they shouldn't,
but that doesn't necessarily mean anything). I assume the situation is
identical for Intel graphics chips, but I can't really comment there at
all!

In summary: Our GPUs have a bunch of output port pins, and it's up to the
individual board design which of those to use for which ports. There
should be a 1:1 mapping between the 4-part PCI ID and the set of ports
used and what for, but there's no way to guarantee that's true across all
boards.

Finally, if we did start quirking this, a complete table would end up
being potentially enormous; an entry for every graphics board or mother-
board with integrated graphics ever made...

-- 
nvpublic
