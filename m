From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [alsa-devel] Internal Mics and Speakers
	not visible in PulseAudio
Date: Fri, 01 Jun 2012 05:38:13 +0200
Message-ID: <4FC83925.7030309@canonical.com>
References: <4FC616B8.3090608@canonical.com>
	<CAN8cciYgk5L5PWQkzcd3XF_7eZvzTpzC_eUifCG=hOFymJsx7Q@mail.gmail.com>
	<4FC6329A.1040008@canonical.com>
	<CAN8cciaip04p6+_hUkoXeyv2HScd38oerNdZUp8GzBGZpR+ntA@mail.gmail.com>
Reply-To: General PulseAudio Discussion
	<pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <pulseaudio-discuss-bounces+gcapd-polypaudio-discuss=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <CAN8cciaip04p6+_hUkoXeyv2HScd38oerNdZUp8GzBGZpR+ntA@mail.gmail.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@lists.freedesktop.org>
List-Help: <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=subscribe>
Sender: pulseaudio-discuss-bounces+gcapd-polypaudio-discuss=m.gmane.org@lists.freedesktop.org
Errors-To: pulseaudio-discuss-bounces+gcapd-polypaudio-discuss=m.gmane.org@lists.freedesktop.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>
List-Id: alsa-devel@alsa-project.org

On 06/01/2012 04:54 AM, Raymond Yau wrote:
> 2012/5/30 David Henningsson<david.henningsson@canonical.com>:
>> On 05/30/2012 03:04 PM, Raymond Yau wrote:
>>>
>>> I am afraid this does not work with desktop computer which has front
>>> mic , internal mic, Line in ,CD (or stereo mix with those via hda
>>> codecs)
>>>
>>> With ubuntu 12.04 and unity ,  if I enable hda jack detect with my
>>> ad198x on my desktop, sound  preference does not allow me to select
>>> front mic since I am still using ac97 front panel (with no jack detect
>>> circuit)
>>
>>
>> In that case your BIOS should detect that you're using an ac'97 front panel
>> and set the "no prescence detect" bit in the default pin config.
>>
>> The codec driver should then not create any jack at all, and PulseAudio
>> would pick up 'Input Source' ->  'Front Mic' as a reason to have create a
>> 'Front Mic' port.
>
> The patched driver just create two jack detect controls for rear panel
> jacks when BIOS set front audio panel type to AC97
>
> There are difference for the system settings/sound in unity and gnome
>
> In gnome session, the system settings/sound list the three hardcoded
> ports (front mic, line and rear mic) instead of all the items in the
> "Input source" / "Capture Source" controls ( There is no CD in HDA,
> and no CD , stereo mix, aux, phone for my other sound cards with ac97
> codec)
>
> Is there any way to add back "Stereo Mix" to pulseaudio 's port ?

Yes. See:

http://www.freedesktop.org/wiki/Software/PulseAudio/Backends/ALSA/Profiles

However if you have additional questions about how to write PulseAudio 
profiles and paths I might not have the time to help you out with that, 
hopefully you will be able to sort that out by yourself.

> In unity session, the system settings/sound only list  the plugged jacks.
>
> I think the usage of jack detect to select input source automatically
> is broken for for those  motherboards which have three audio jacks in
> rear panel and retask those pink and blue jacks for surround51 output.
>
> The module-switch-on-available-port should check whether "Channel
> mode' is 6 and exclude the result those jack detect of "rear mic" and
> "line in" since they have been retasked for output

Hmm. That would lead to quite hairy code in PulseAudio, I'm afraid...and 
I don't think it's the right way to solve the problem either.

I think we could go about this in different ways.

1) The easiest way is to say that if you're changing "Channel mode" 
manually in alsamixer, you're on your own. After all, the normal/newbie 
end user would not know about alsamixer at all, so if you're capable of 
changing things in alsamixer you're assumed to be capable of configuring 
PulseAudio's profiles (using the link above) to match that as well.

2) We could make a policy decision to remove the code that retasks the 
jacks, and direct people to hda-jack-retask if they want to do that. 
That would mean simpler code for everyone - however, with the recent 
addition of multi-IO in the Realtek driver (for example), things doesn't 
seem to head that way...

3) We could add both "Line Out Surround Jack" and "Rear Mic Jack". The 
"Rear Mic Jack" would always return present=no when you're in 6-channel 
surround retask mode, and "Line Out Surround Jack" would always return 
present=no when you're in the normal mode.

> BTW, the ICH8 HDA controller support multi stream capturing and ad1988
> has thee capture subdevices
>
> arecord -l
> card 1: Intel [HDA Intel], device 0: AD198x Analog [AD198x Analog]
>    Subdevices: 3/3
>    Subdevice #0: subdevice #0
>    Subdevice #1: subdevice #1
>    Subdevice #2: subdevice #2

You would be able to make a multi-source profile in PulseAudio that can 
record from all of these simultaneously, but we're missing a patch that 
can control volumes and switches with indices, so you would have to 
control the gain manually in alsamixer.

> what is the definition of "Mono Output" in pulseaudio ?
>
> it is just the capability of the sound card to play mono  or have a
> mono speaker with a specific volume control
>
> My three other sound cards does support mono playback and mono capture
>
> The system setting/sound in gnome session allow me to select "mono
> duplex" but when it does not allow me to select "mono output + mono
> input" in unity session.

That sounds like the known bug I was working on yesterday.

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
