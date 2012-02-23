From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: multiple, non-physically accesible,
 HDMI devices listed for Intel IbexPeak ALC269VB
Date: Thu, 23 Feb 2012 09:30:44 +0100
Message-ID: <4F45F934.7040409@canonical.com>
References: <CAH=dYrFudvU_CVkz6B7nz3mB8fyOx6HaiaxgukfAjNnW8MOLYw@mail.gmail.com>
	<74CDBE0F657A3D45AFBB94109FB122FF17BD8BC635@HQMAIL01.nvidia.com>
	<20120222215206.GA3517@burratino>
	<CAH=dYrGuG0WfBFAMVmJdT28pckZ3TXutRq61-K++ui5VXSr+YQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by alsa0.perex.cz (Postfix) with ESMTP id 3CB9510415F
	for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2012 09:30:50 +0100 (CET)
In-Reply-To: <CAH=dYrGuG0WfBFAMVmJdT28pckZ3TXutRq61-K++ui5VXSr+YQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Andres Cimmarusti <acimmarusti@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>, "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "660111@bugs.debian.org" <660111@bugs.debian.org>, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

On 02/23/2012 01:01 AM, Andres Cimmarusti wrote:
>> If the new two pins can be never used, i.e. physically unreachable,
>> we may disable these pins by giving the proper default pin-config
>> values.  Usually it's a job of BIOS.  But if BIOS doesn't do it, user
>> need to do it manually.
>>
>> Build your kernel with CONFIG_SND_HDA_HWDEP=y,
>> CONFIG_SND_HDA_RECONFIG=y, CONFIG_SND_HDA_PATCH_LOADER=y.
>> I guess most of distro kernels are built with them.
>> Then create a file containing below in /lib/firmware, such as,
>> /lib/firmware/ibx-hdmi:
>>
>> ================================================================
>> [codec]
>> 0x80862804 0x80860101 3
>> [pincfg]
>> 0x04 0x411111f0
>> 0x06 0x411111f0
>> ================================================================
>>
>> Now pass this file to "patch" module option for snd-hda-intel.
>> For example, create a file in /etc/modprobe.d/,
>> e.g. /etc/modprobe.d/50-hdmi.conf, containing the line
>>
>> options snd-hda-intel patch="ibx-hdmi"
>>
>> Then reload the driver or reboot.  This will disable pins 0x04 and
>> 0x06 so that only the pin 0x05 will be used.
>
> I've tested this workaround and it works well. I don't suppose this
> could be added as a quirk to the kernel for this particular device?
> (when and only if there's only one physically accessible HDMI
> connector).

Stephen, could you comment on this? Are we guaranteed a certain board 
configuration (i e which pins are physically connected or not) given a 
PCI SSID, or anything else that can be used as a key to a quirk table? I 
think I've asked you before and that the answer was "no", but my memory 
could be failing me.

>> There are ways to configure pulseaudio to allow the user to select which
>> PCM device to use on a given sound card. David Henningsson made this work
>> for NVIDIA GPUs at least in Ubuntu, and I imagine the same technique
>> could be applied to Intel devices too.
>
> Mmm.. just in Ubuntu? was this work submitted upstream? It appears
> there are some related fixes shown in the Ubuntu pulseaudio changelog:
>
> http://changelogs.ubuntu.com/changelogs/pool/main/p/pulseaudio/pulseaudio_1.1-0ubuntu9/changelog
>
> I found a thread related to this issue here:
> http://www.mail-archive.com/pulseaudio-discuss@mail.0pointer.de/msg07433.html
> Started by yourself Stephen Warren! but it doesn't seem like it got anywhere...
>
>> As Takashi mentions, from a kernel perspective, this isn't really a
>> regression at all, but simply exposing all the features of the HW that
>> were previously hidden. Without that change, others can't use some HW
>> usefully at all. Unfortunately, pulseaudio makes some rather simplistic
>> assumptions about how HW works by default, and can be confused by the
>> additional features that are exposed.
>
> Agreed. But in the case of laptops, I don't think I've ever seen one
> that actually has more than one physical connector. I'm a little
> puzzled as to how all these outputs (in my case 3) make sense for my
> hardware...

Even if there is only one HDMI output, it's it not that uncommon, 
actually. Many DVI outputs can output HDMI audio as well (when connected 
through an HDMI monitor through DVI->HDMI adapter), and DisplayPort also 
has audio support.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
