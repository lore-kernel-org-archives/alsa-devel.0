From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: multiple, non-physically accesible,
 HDMI devices listed for Intel IbexPeak ALC269VB
Date: Thu, 23 Feb 2012 07:46:37 +0100
Message-ID: <4F45E0CD.3020009@canonical.com>
References: <CAH=dYrFudvU_CVkz6B7nz3mB8fyOx6HaiaxgukfAjNnW8MOLYw@mail.gmail.com>
	<s5hwr7f48jd.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by alsa0.perex.cz (Postfix) with ESMTP id D12DE104024
	for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2012 07:46:40 +0100 (CET)
In-Reply-To: <s5hwr7f48jd.wl%tiwai@suse.de>
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
Cc: Jonathan Nieder <jrnieder@gmail.com>, Andres Cimmarusti <acimmarusti@gmail.com>, alsa-devel@alsa-project.org, 660111@bugs.debian.org, swarren@nvidia.com
List-Id: alsa-devel@alsa-project.org

On 02/22/2012 08:44 AM, Takashi Iwai wrote:
> At Wed, 22 Feb 2012 01:43:44 -0500,
> Andres Cimmarusti wrote:
>>
>> [1<text/plain; UTF-8 (7bit)>]
>> Dear Mr. Warren,
>>
>> I recently upgraded my laptop to Debian testing (from Debian stable +
>> the longterm stable 3.0.x kernel). The newer kernel 3.2.x came with a
>> regression that git bisect has traced down to one of your commits in
>> the early 3.1.x kernel development stage (git bisect output and git
>> bisect log attached).
>>
>> Under kernel 3.0.x HDMI sound works out-of-the-box as tested with
>> pulse audio (choosing the option Digital
>> Stereo (HDMI) Output) and by the command:
>>
>> $ aplay -D plughw:0,3 /usr/share/sounds/alsa/Front_Center.wav
>>
>> Alsa's device list reveals:
>>
>> $ aplay -l
>> **** List of PLAYBACK Hardware Devices ****
>> card 0: Intel [HDA Intel], device 0: ALC269VB Analog [ALC269VB Analog]
>>    Subdevices: 0/1
>>    Subdevice #0: subdevice #0
>> card 0: Intel [HDA Intel], device 3: HDMI 0 [HDMI 0]
>>    Subdevices: 1/1
>>    Subdevice #0: subdevice #0
>>
>> Unfortunately with kernel 3.2.x and 3.1.x I get no sound out choosing the same
>> configuration in pulseaudio. Device is advertised correctly but
>> there's a bizarre multiplicity advertised:
>>
>> $ aplay -l
>> **** List of PLAYBACK Hardware Devices ****
>> card 0: Intel [HDA Intel], device 0: ALC269VB Analog [ALC269VB Analog]
>>    Subdevices: 1/1
>>    Subdevice #0: subdevice #0
>> card 0: Intel [HDA Intel], device 3: HDMI 0 [HDMI 0]
>>    Subdevices: 1/1
>>    Subdevice #0: subdevice #0
>> card 0: Intel [HDA Intel], device 7: HDMI 1 [HDMI 1]
>>    Subdevices: 1/1
>>    Subdevice #0: subdevice #0
>> card 0: Intel [HDA Intel], device 8: HDMI 2 [HDMI 2]
>>    Subdevices: 1/1
>>    Subdevice #0: subdevice #0
>>
>> Using aplay with device 3 says device is busy. Device 7 works
>> correctly (but is not available in pulseaudio unless forced by
>> default, which then renders internal speakers disabled) and device 8
>> produces no sound out.
>>
>> This appears to be a regression in the kernel about this device,
>> advertising non-physically connected HDMI sound devices that cause
>> pulse audio to get
>> confused (Pulseaudio only seems to be able to handle one HDMI output
>> by default device 0,3).
>
> The biggest problem is that PA checks only the first HDMI device.
> In that sense, this is no regression in the kernel side, although I
> know it's annoying.

There is active work going on in this area. In fact, I just posted a 
patch to the PA mailinglist [1]. And yes, we already have it in Ubuntu 
11.10 (to probe multiple hdmi devices for Intel and NVidia), and the 
main reason it took until now to upstream that patch, was the decision 
to switch jack detection method from input devices to kcontrols.

> If the new two pins can be never used, i.e. physically unreachable,
> we may disable these pins by giving the proper default pin-config
> values.  Usually it's a job of BIOS.  But if BIOS doesn't do it, user
> need to do it manually.
>
> Build your kernel with CONFIG_SND_HDA_HWDEP=y,
> CONFIG_SND_HDA_RECONFIG=y, CONFIG_SND_HDA_PATCH_LOADER=y.
> I guess most of distro kernels are built with them.
> Then create a file containing below in /lib/firmware, such as,
> /lib/firmware/ibx-hdmi:
>
> ================================================================
> [codec]
> 0x80862804 0x80860101 3
> [pincfg]
> 0x04 0x411111f0
> 0x06 0x411111f0
> ================================================================
>
> Now pass this file to "patch" module option for snd-hda-intel.
> For example, create a file in /etc/modprobe.d/,
> e.g. /etc/modprobe.d/50-hdmi.conf, containing the line
>
> options snd-hda-intel patch="ibx-hdmi"
>
> Then reload the driver or reboot.  This will disable pins 0x04 and
> 0x06 so that only the pin 0x05 will be used.

Let me also push for the hda-jack-retask [2] application, which is an 
easy-to-use GUI for creating these types of firmware files. I advertised 
it here a while ago [3] but it seems to have gone unnoticed.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

[1] 
http://lists.freedesktop.org/archives/pulseaudio-discuss/2012-February/012872.html

[2] 
http://voices.canonical.com/david.henningsson/2011/11/29/turn-your-mic-jack-into-a-headphone-jack/

[3] 
http://mailman.alsa-project.org/pipermail/alsa-devel/2011-December/046778.html
