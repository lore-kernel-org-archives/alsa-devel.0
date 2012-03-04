From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: multiple, non-physically accesible,
 HDMI devices listed for Intel IbexPeak ALC269VB
Date: Sun, 04 Mar 2012 03:43:20 +0100
Message-ID: <4F52D6C8.9020105@canonical.com>
References: <CAH=dYrFudvU_CVkz6B7nz3mB8fyOx6HaiaxgukfAjNnW8MOLYw@mail.gmail.com>
	<s5hwr7f48jd.wl%tiwai@suse.de> <4F45E0CD.3020009@canonical.com>
	<CAH=dYrEXDb_eXYr01pfq8LmNKxduKq8eLRLuenGBVj8zF_VL8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id 09D64243A7
	for <alsa-devel@alsa-project.org>; Sun,  4 Mar 2012 03:43:24 +0100 (CET)
In-Reply-To: <CAH=dYrEXDb_eXYr01pfq8LmNKxduKq8eLRLuenGBVj8zF_VL8A@mail.gmail.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, Jonathan Nieder <jrnieder@gmail.com>, alsa-devel@alsa-project.org, 660111@bugs.debian.org, swarren@nvidia.com
List-Id: alsa-devel@alsa-project.org

On 03/04/2012 12:36 AM, Andres Cimmarusti wrote:
>> There is active work going on in this area. In fact, I just posted a patch
>> to the PA mailinglist [1]. And yes, we already have it in Ubuntu 11.10 (to
>> probe multiple hdmi devices for Intel and NVidia), and the main reason it
>> took until now to upstream that patch, was the decision to switch jack
>> detection method from input devices to kcontrols.
>
> Thank you for all the references you provided and your work in fixing
> this issue for all users. I just looked at the git repository for the
> source code of pulseaudio, but I see your patches have not been
> included yet. Do you have any estimate of when they will be merged? if
> so, do you think they'll be included in the next release (do you know
> when this will be?) ?

I hope they'll be in PulseAudio 2.0, as they are currently waiting for 
review. For next release, see [2], but judging from the PulseAudio 1.0 
release process - no, I don't know when this will be ;-)

> I'm considering reassigning this bug to pulseaudio in debian and
> asking them to include the appropriate patches. Which ones would
> actually be needed (say, to apply them to pulseaudio 1.1)? would your
> 6 patches announced on the mailing list in February be enough?

If you want them to apply to PulseAudio 1.1, you can have a look at [1]. 
The patches currently posted apply to git head. You'll need all of the 
06* patches (as well as Linux 3.3 for the kcontrols).

A more light-weight version could be what I did in Ubuntu 11.04, where 
there was no jack detection, but I just exposed all four devices in 
PulseAudio and let the user choose manually, like this [4]. (I later 
renamed that file from "nvidia.conf" to "extra-hdmi.conf", and added the 
same file to be used for Intel chips.)

>> Let me also push for the hda-jack-retask [2] application, which is an
>> easy-to-use GUI for creating these types of firmware files. I advertised it
>> here a while ago [3] but it seems to have gone unnoticed.
>
> This sounds like a good tool for making this happen. I will submit a
> Request For Package in Debian... but this can take time. Would you
> consider packaging it there? then it would easily flow into Ubuntu.

Certainly, if there is interest from the Debian side to have it.

I would also not mind if it became a part of upstream ALSA, I think it 
would make a nice addition to the hda-analyzer, hda-verb etc tool set.

> I've encountered other hardware with the same issue recently. It's an
> NVIDIA card HDA MCP89 on a Macbook Pro 7,1. Is there a method I can
> follow for crafting my own "patches"? I'm afraid I don't understand
> how to find the appropriate HEX values that need to go in the [codec]
> and [pincfg] section.

I think the easiest way is just to download the hda-jack-retask 
application and build it yourself. Otherwise, [3].

> Thanks all for your help.

You're welcome.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

[1] 
http://bazaar.launchpad.net/~ubuntu-audio-dev/pulseaudio/ubuntu.precise/files/head:/debian/patches/

[2] http://pulseaudio.org/wiki/ReleasePlanning

[3] http://www.kernel.org/doc/Documentation/sound/alsa/HD-Audio.txt

[4] 
http://bazaar.launchpad.net/~ubuntu-audio-dev/pulseaudio/ubuntu.natty/view/head:/debian/patches/0001-alsa-mixer-Add-separate-profile-for-Nvidia.patch
