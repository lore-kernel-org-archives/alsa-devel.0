From: Andres Cimmarusti <acimmarusti@gmail.com>
Subject: Bug#660111: multiple, non-physically accesible, HDMI devices listed for Intel IbexPeak ALC269VB
Date: Wed, 22 Feb 2012 19:01:54 -0500
Message-ID: <CAH=dYrGuG0WfBFAMVmJdT28pckZ3TXutRq61-K++ui5VXSr+YQ@mail.gmail.com>
References: <CAH=dYrFudvU_CVkz6B7nz3mB8fyOx6HaiaxgukfAjNnW8MOLYw@mail.gmail.com>
	<74CDBE0F657A3D45AFBB94109FB122FF17BD8BC635@HQMAIL01.nvidia.com>
	<20120222215206.GA3517@burratino>
Reply-To: Andres Cimmarusti <acimmarusti@gmail.com>, 660111@bugs.debian.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.660111.B660111.132995532127516@bugs.debian.org>
In-Reply-To: <20120222215206.GA3517@burratino>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
To: Jonathan Nieder <jrnieder@gmail.com>
Cc: Stephen Warren <swarren@nvidia.com>, "David Henningsson (david.henningsson@canonical.com)" <david.henningsson@canonical.com>, "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "660111@bugs.debian.org" <660111@bugs.debian.org>
List-Id: alsa-devel@alsa-project.org

First of all, thank you for your feedback. It's been quite helpful / insigh=
tful

> The biggest problem is that PA checks only the first HDMI device.
> In that sense, this is no regression in the kernel side, although I
> know it's annoying.

I agree this seems more like a shortcoming of pulseaudio. Else it's my
BIOS' fault, which doesn't surprise me, seeing at this notebook is
manufactured by some "unknown" OEM in Taiwan for other vendors and all
they care is if Windows runs ok on it. In fact, I currently have many
unsupported ACPI keys events because of it.

> If the new two pins can be never used, i.e. physically unreachable,
> we may disable these pins by giving the proper default pin-config
> values.  Usually it's a job of BIOS.  But if BIOS doesn't do it, user
> need to do it manually.
>
> Build your kernel with CONFIG_SND_HDA_HWDEP=3Dy,
> CONFIG_SND_HDA_RECONFIG=3Dy, CONFIG_SND_HDA_PATCH_LOADER=3Dy.
> I guess most of distro kernels are built with them.
> Then create a file containing below in /lib/firmware, such as,
> /lib/firmware/ibx-hdmi:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [codec]
> 0x80862804 0x80860101 3
> [pincfg]
> 0x04 0x411111f0
> 0x06 0x411111f0
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Now pass this file to "patch" module option for snd-hda-intel.
> For example, create a file in /etc/modprobe.d/,
> e.g. /etc/modprobe.d/50-hdmi.conf, containing the line
>
> options snd-hda-intel patch=3D"ibx-hdmi"
>
> Then reload the driver or reboot.  This will disable pins 0x04 and
> 0x06 so that only the pin 0x05 will be used.

I've tested this workaround and it works well. I don't suppose this
could be added as a quirk to the kernel for this particular device?
(when and only if there's only one physically accessible HDMI
connector).

> There are ways to configure pulseaudio to allow the user to select which
> PCM device to use on a given sound card. David Henningsson made this work
> for NVIDIA GPUs at least in Ubuntu, and I imagine the same technique
> could be applied to Intel devices too.

Mmm.. just in Ubuntu? was this work submitted upstream? It appears
there are some related fixes shown in the Ubuntu pulseaudio changelog:

http://changelogs.ubuntu.com/changelogs/pool/main/p/pulseaudio/pulseaudio_1=
.1-0ubuntu9/changelog

I found a thread related to this issue here:
http://www.mail-archive.com/pulseaudio-discuss@mail.0pointer.de/msg07433.ht=
ml
Started by yourself Stephen Warren! but it doesn't seem like it got anywher=
e...

> As Takashi mentions, from a kernel perspective, this isn't really a
> regression at all, but simply exposing all the features of the HW that
> were previously hidden. Without that change, others can't use some HW
> usefully at all. Unfortunately, pulseaudio makes some rather simplistic
> assumptions about how HW works by default, and can be confused by the
> additional features that are exposed.

Agreed. But in the case of laptops, I don't think I've ever seen one
that actually has more than one physical connector. I'm a little
puzzled as to how all these outputs (in my case 3) make sense for my
hardware...

> I thought that "no regressions" meant that the first sentence and not
> the second sentence of the previous paragraph apply from a kernel
> perspective. =C2=A0No? =C2=A0So I would be happiest if there is some way =
to
> teach the kernel about this quirk until everyone already has had a
> fixed pulseaudio for a year or two.

I agree fixing pulseaudio is ideal, but a kernel quirk can be
backported more easily from a distribution perspective.

Anyways, thank you for your support

Best Regards,

Andres
