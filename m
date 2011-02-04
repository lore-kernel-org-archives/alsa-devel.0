From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Nvidia HDMI and four codecs
Date: Fri, 04 Feb 2011 08:27:50 +0100
Message-ID: <4D4BAA76.20303@canonical.com>
References: <4D47BFEB.8040602@canonical.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0310C8E418@HQMAIL01.nvidia.com>
	<4D490FDE.9070900@canonical.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0310C8E9DE@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id A735C103922
	for <alsa-devel@alsa-project.org>; Fri,  4 Feb 2011 08:27:45 +0100 (CET)
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF0310C8E9DE@HQMAIL01.nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Nitin Daga <ndaga@nvidia.com>
List-Id: alsa-devel@alsa-project.org

On 2011-02-03 21:35, Stephen Warren wrote:
> David Henningsson wrote at Wednesday, February 02, 2011 1:04 AM:
>> On 2011-02-01 17:36, Stephen Warren wrote:
>>> David Henningsson wrote at Tuesday, February 01, 2011 1:10 AM:
>>>> I've seen a few Nvidia HDMI's recently which have four HDMI codecs
>>>> connected to the same HDA controller.
>>>> ...
>>>> The problem is that we don't know which one(s) of these four that
>>>> is the real one.
>>>> ...
>
> (oh, and note that there can be multiple displays active, and hence there
> can be more than one "real one").

True. On the ALSA level, we should support everything we can, however 
PulseAudio has a somewhat simplified focus so at that level, it is 
acceptable that only one HDMI display is active at a time (audio-wise). 
At least if anything is still possible by configuration changes in e g 
/etc/pulse/default.pa.

>>> I don't believe it's possible to determine which of the codecs are
>>> physically connected to actual connectors on the graphics board. This
>>> would be a static facet of the board design.
>> ...
>> As you might have seen, for Intel HDMI I made a patch that makes it act
>> upon the pin config default register.
>> ...
>>>> I'd love BIOS to provide a good codec probe mask, a pin config default,
>>>> or something similar, but given a codec-proc I can't see any difference
>>>> between the real ones and the unconnected ones, so I don't know how to
>>>> fix up the driver without hardcoding/quirking every one of them. Any
>>>> hints?
>>>
>>> ALSA now exposes a logical device (hdmi:Nvidia,n) for each pin complex
>>> ...
>>> If PulseAudio were to offer all HDMI devices in its UI, at least the
>>> user could configure their system using the regular GUI tools.
>>> ...
>>> http://www.mail-archive.com/pulseaudio-discuss@mail.0pointer.de/msg07433.html
>>
>> Thanks, reading that thread made a few things clearer.
>>
>> As for PulseAudio, showing four HDMI devices is quite simple [1] but I
>> still think it would be a little confusing to show four devices to
>> choose from and would wish for something more intuitive.
>
> I'm not sure if that will work.
>
> Note: My observations are based on adding the following to
> /etc/pulse/default.pa:
>
> load-module module-alsa-sink device=hw:1,7
> load-module module-alsa-sink device=hw:1,8
> load-module module-alsa-sink device=hw:1,9
>
> With the above, at least during startup (and perhaps long-term during
> operation), PulseAudio opens all the devices at once. This exceeds the
> maximum number of streams our audio controller can support (2), and hence
> the load-module fails, and hence the PulseAudio daemon fails to start.
>
> Perhaps the mechanism you presented avoids that?

I don't have the hardware here, so I can't test, but I believe so - with 
this configuration, they will open one at a time and selectable through 
setting the profile (in gnome-volume-control, that would correspond to 
four different "Profiles" on the "Hardware" tab).

Thinking of it, it might make sense to add the below as an interim 
solution even in standard PulseAudio and/or Ubuntu.

> If you know which specific subset you want, adding fewer of those entries
> to the file does work, and can be an alternative to a probe mask.
>
>> So let's sum up the options here:
>>
>> 1) Board manufacturer sets a codec probe mask.
>
> I'm not sure how they'd do that, since the probe mask is a Linux-specific
> kernel command-line option.

Hmm, you're probably right. Linux reads this from the STATESTS register 
on reset (see hda_intel.c:azx_reset) but unless you have some internal 
method of turning off the codecs completely (this might also save 
power?) this might not be an option.

>> 2) Board manufacturer sets pin config default register. This might
>> require some support in the driver as well.
>>
>> 1) and 2) won't work for existing boards and I don't know how difficult
>> it would be to persuade the board manufacturers to do it for future
>> boards.
>
> Yes, this isn't possible with any current boards.
>
> However, for some future designs, it sounds like we may be setting the
> pin config default register to indicate which pin complexes are actually
> connected to a physical connector on the board.

Sounds good to me - then at least we have some way of autodiscovering 
connections before they are active.

>> 3) Quirking in the driver - codec probe mask
>>
>> This was my primary option until yesterday, when I saw a machine which
>> had the same PCI SSID for both the primary HDA controller and the Nvidia
>> HDA controller.
>
> The 3D/VGA controller and the HD-Audio controller will always be different
> PCI functions (same domain/bus/device, different function address), and
> appropriately marked as either a 3D or audio controller. Perhaps that can
> help apply any quirk to the appropriate device/driver.
>
> In practice for all the GPUs I've seen the 3D controller is function 0 and
> the HD-audio controller is function 1. However, it would be unwise to
> assume those specific numbers will apply in all cases.
>
>> 4) Quirking in the driver - pin config default register. Will need some
>> work in the driver, but I guess it's doable.
>
> This is probably better than quirking a probe_mask; it'd be more similar to
> the case where this register was already filled in by the HW/BIOS.

Ok, this seems reasonable, although somewhat more work in the driver 
compared to the probe_mask approach.

We usually use the PCI SSID as key to selecting a quirk - are two cards 
with different layout (as in different codecs physically connected), 
guaranteed to have different PCI Subsystem IDs?

>> 3) and 4) gives us a lot of quirking to do.
>>
>> 5) Show all four devices in PulseAudio. Simple, but confusing for the
>> user.
>
> And there is the issue I mentioned above to work out.
>
>> 6) Proper jack detection in PulseAudio, which might be based on ELD
>> information. This is what would need the most work to do, and things
>> will still be confusing for people not using PulseAudio. It might be the
>> long path to go anyway, as it would enable features such as auto-moving
>> to HDMI when HDMI is plugged in, etc.
>>
>> --
>> David Henningsson, Canonical Ltd.
>> http://launchpad.net/~diwic
>>
>> [1] I haven't tested it, but I guess the following addition to
>> /usr/shared/pulseaudio/alsa-mixer/profile-sets/default.conf should do it:
>>
>> [Mapping hdmi-stereo-extra1]
>> description = HDMI out extra 1
>> device-strings = hdmi:%f,1
>> channel-map = left,right
>> priority = 2
>> direction = output
>>
>> [Mapping hdmi-stereo-extra2]
>> description = HDMI out extra 2
>> device-strings = hdmi:%f,2
>> channel-map = left,right
>> priority = 2
>> direction = output
>>
>> [Mapping hdmi-stereo-extra3]
>> description = HDMI out extra 3
>> device-strings = hdmi:%f,3
>> channel-map = left,right
>> priority = 2
>> direction = output

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
