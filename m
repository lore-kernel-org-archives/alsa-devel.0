From: Stephen Warren <swarren@nvidia.com>
Subject: Re: HDA HDMI pin to converter mapping
Date: Fri, 27 May 2011 08:58:09 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0498A488C1@HQMAIL01.nvidia.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF0498A484DD@HQMAIL01.nvidia.com>
	<s5h39k22bmu.wl%tiwai@suse.de> <4DDE22DA.7070905@canonical.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0498A486FC@HQMAIL01.nvidia.com>
	<4DDF64A6.2060403@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 9117C244C8
	for <alsa-devel@alsa-project.org>;
	Fri, 27 May 2011 17:58:21 +0200 (CEST)
In-Reply-To: <4DDF64A6.2060403@canonical.com>
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
To: David Henningsson <david.henningsson@canonical.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Wei Ni <wni@nvidia.com>, "pl bossart (bossart.nospam@gmail.com)" <bossart.nospam@gmail.com>, "Wu Fengguang (wfg@linux.intel.com)" <wfg@linux.intel.com>, Nitin Daga <ndaga@nvidia.com>
List-Id: alsa-devel@alsa-project.org

David Henningsson wrote at Friday, May 27, 2011 2:45 AM:
> So from a conceptual view, I don't really like the one-pcm-per-pin idea,
> because it makes HDMI hda and analogue hda more different. (Or are we
> considering one-pcm-per-pin for the other codecs as well?) We risc
> fragmenting the driver further, where we should instead try to unify it.
> 
> But from a pragmatic view, for this particular problem, it seems your
> solution might be the simplest way forward.

OK. Let's discuss the alternatives.

The only alternative I see is to have 1 PCM per supported converter.
Whether we end supporting just 1 or all N converters are just different
variations on this theme.

Since in general there are fewer converters than pins, we need some way
to know (or control) which pins the converters (and hence PCMs) are
routed to.

A few options exist:

1)

Statically support 1 converter and route from the converter to all pins
that can be routed to (or all pins with valid ELDs at a given time).

The advantage of this is a single PCM, so less for applications to
enumerate and handle.

The disadvantage here is that the multiple ELDs are associated with a
single PCM. I believe this creates basically intractable issues with how
to resolve what audio formats to allow.

One approach would be to take the common denominator of formats across
all ELDs, but this would prevent multi-channel audio being sent to an
A/V receiver on one HDMI link if a simple stereo-only monitor was
connected to another HDMI link. That seems like a very bad user
experience.

Another approach would be to honor just one of the ELDs. That would
allow full use of a single device's audio capabilities. I see two issues
with this: (a) How to tell the ALSA driver which ELD to honor, since it
limits a PCM's capabilities by the union of the converter's and ELD's
capabilities. (b) That same audio gets sent to all HDMI devices. Some
may not support the format. Hopefully the devices will just ignore the
signal rather than playing e.g. static. However, I'm sure some devices
will have bugs there.

2)

Allocate a PCM per converter, but somehow dynamically connect the PCM
and converter to some ALSA-kernel-driver-determined pin when it's opened,
e.g. the first not-in-use pin with a valid ELD.

The disadvantage here is that the kernel is implementing policy; it's
deciding which pin complexes to use. If there are 3 connected active
HDMI/DP monitors, this ends up meaning that audio can never be routed to
one of them (since you could only open e.g. 2 PCMs at once, and hence
only access the first two pins, since this model gives user-space no
control over the routing selection, and the ALSA driver would presumably
be consistent in its routing selection)

Again, that seems like a very bad user experience. I believe some AMD
graphics cards support 6 displays at once. I'm not sure if they support
audio on all 6 displays too, but if they do, we could actually run in
to this situation very quickly.

3)

Allocate one PCM per converter. Implement a kcontrol for the mux on the
front of each pin, so user-space can determine the routing policy; it
will open one PCM, flip the kcontrols to setup the routing to the
appropriate pin, and go.

This case starts to sound a lot like ASoC audio configuration.

This approach is more complex for user-space applications; they now need
a way to know there's routing involved, configure that routing, etc. I'm
not familiar with analog codecs, so perhaps this is completely normal?
Alternatively, this might end up needing UCM (Use-Case Manager) applied
to HD-audio controllers in addition to ASoC-based audio cards. While UCM
is good and necessary for ASoC-based cards, I'm not convinced we should
push it at situations that can be solved by simpler means.

My inclination is that this approach just dumps a lot of complexity onto
user-space, without actually achieving anything more than a PCM-per-pin
setup would.

Off the top of my head, I can't think of any other alternatives. Do let
me know if there's something better.

As an aside, I think I've got the PCM-per-pin approach coded up at least
for codecs that use the "generic" setup in patch_hdmi.c. I'll start
testing out how it works today.

More below.

> > The supported NVIDIA HDA controllers have 4 codecs, each having 1
> > converter and 1 pin. Hence, there are 4 PCMs, 1 per codec. PCMs can't
> > be unified/shared/... across codecs. However, our HDA controllers only
> > support 2 streams, because our GPUs only support two active displays
> > at once. Hence, any attempt to open all 4 PCMs at the same time
> > (rather than in serial) will fail on the 3rd PCM.
> >
> > So, the one-PCM-per-pin model for the new unsupported codecs doesn't
> > introduce any new issue here.
> >
> >> So we're effectively breaking some of the older chips by changing the
> >> PCM device from hw:X to hw:X,1 for a specific pin...?
> >
> > I don't believe the PCM device names would change for existing supported
> > codecs.
> 
> If you have one converter and three pins connected to it (I think some
> intels have this?), then addressing the second and third pin would be a
> change.

Sure, although I think some way of accessing the other 2 pins is required,
and I don't think that changes any existing device names, just adds some
new device names.

> > For the unsupported codecs, yes, we'll start to see ${pin_index} be
> > non-zero, and end up with names like hw:0,3.0, hw:0,3.1, and hw:0,3.2.
> > However, even if we made a PCM-per-converter work for those codecs,
> > rather than switching to a PCM-per-pin like I proposed, we'd still end
> > up with those new names, simply due to the existence of multiple
> > converters within the codec.
> 
> *If* you want to use the second converter at all, which will only be in
> the relative rare case of you wanting to use two converters in parallel.

Well, I do that often when testing:-)

I assume that our marketing department determined that would be a
worthwhile use-case to support, or we probably wouldn't have burned
the hardware on multiple converters.

As an aside, I believe Windows exposes the general model of PCM-per-pin.
I have no idea about Mac. Not that Linux has to follow other vendors, but
just a note that others consider the use-case worth supporting.

-- 
nvpublic
