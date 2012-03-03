From: Andres Cimmarusti <acimmarusti@gmail.com>
Subject: Bug#660111: [alsa-devel] multiple, non-physically accesible, HDMI devices listed for Intel IbexPeak ALC269VB
Date: Sat, 3 Mar 2012 18:36:57 -0500
Message-ID: <CAH=dYrEXDb_eXYr01pfq8LmNKxduKq8eLRLuenGBVj8zF_VL8A@mail.gmail.com>
References: <CAH=dYrFudvU_CVkz6B7nz3mB8fyOx6HaiaxgukfAjNnW8MOLYw@mail.gmail.com>
	<s5hwr7f48jd.wl%tiwai@suse.de>
	<4F45E0CD.3020009@canonical.com>
Reply-To: Andres Cimmarusti <acimmarusti@gmail.com>, 660111@bugs.debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.660111.B660111.133081782310316@bugs.debian.org>
In-Reply-To: <4F45E0CD.3020009@canonical.com>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, Jonathan Nieder <jrnieder@gmail.com>, alsa-devel@alsa-project.org, 660111@bugs.debian.org, swarren@nvidia.com
List-Id: alsa-devel@alsa-project.org

> There is active work going on in this area. In fact, I just posted a patc=
h
> to the PA mailinglist [1]. And yes, we already have it in Ubuntu 11.10 (t=
o
> probe multiple hdmi devices for Intel and NVidia), and the main reason it
> took until now to upstream that patch, was the decision to switch jack
> detection method from input devices to kcontrols.

Thank you for all the references you provided and your work in fixing
this issue for all users. I just looked at the git repository for the
source code of pulseaudio, but I see your patches have not been
included yet. Do you have any estimate of when they will be merged? if
so, do you think they'll be included in the next release (do you know
when this will be?) ?

I'm considering reassigning this bug to pulseaudio in debian and
asking them to include the appropriate patches. Which ones would
actually be needed (say, to apply them to pulseaudio 1.1)? would your
6 patches announced on the mailing list in February be enough?

>> If the new two pins can be never used, i.e. physically unreachable,
>> we may disable these pins by giving the proper default pin-config
>> values. =C2=A0Usually it's a job of BIOS. =C2=A0But if BIOS doesn't do i=
t, user
>> need to do it manually.
>>
>> Build your kernel with CONFIG_SND_HDA_HWDEP=3Dy,
>> CONFIG_SND_HDA_RECONFIG=3Dy, CONFIG_SND_HDA_PATCH_LOADER=3Dy.
>> I guess most of distro kernels are built with them.
>> Then create a file containing below in /lib/firmware, such as,
>> /lib/firmware/ibx-hdmi:
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> [codec]
>> 0x80862804 0x80860101 3
>> [pincfg]
>> 0x04 0x411111f0
>> 0x06 0x411111f0
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> Now pass this file to "patch" module option for snd-hda-intel.
>> For example, create a file in /etc/modprobe.d/,
>> e.g. /etc/modprobe.d/50-hdmi.conf, containing the line
>>
>> options snd-hda-intel patch=3D"ibx-hdmi"
>>
>> Then reload the driver or reboot. =C2=A0This will disable pins 0x04 and
>> 0x06 so that only the pin 0x05 will be used.
>
> Let me also push for the hda-jack-retask [2] application, which is an
> easy-to-use GUI for creating these types of firmware files. I advertised =
it
> here a while ago [3] but it seems to have gone unnoticed.

This sounds like a good tool for making this happen. I will submit a
Request For Package in Debian... but this can take time. Would you
consider packaging it there? then it would easily flow into Ubuntu.

I've encountered other hardware with the same issue recently. It's an
NVIDIA card HDA MCP89 on a Macbook Pro 7,1. Is there a method I can
follow for crafting my own "patches"? I'm afraid I don't understand
how to find the appropriate HEX values that need to go in the [codec]
and [pincfg] section.

Thanks all for your help.

Cheers,

Andres
