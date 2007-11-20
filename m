From: Lennart Poettering <mznyfn@0pointer.de>
Subject: [lennart@poettering.net: Status of ALSA "simple" mixer
	interface]
Date: Tue, 20 Nov 2007 01:51:51 +0100
Message-ID: <20071120005151.GA25276@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="3MwIy2ne0vdjdPXF"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 1D85924953
	for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2007 01:51:53 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

A few days ago I sent the attached emails to Takashi and filed a
couple of bugs on the ALSA BTS. Takashi suggested to post these issues
on the ML as well, to allow public discussion. So, here we go.

The relevant bugs are:

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3570
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3569
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3568
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3572
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3571

Lennart

--3MwIy2ne0vdjdPXF
Content-Type: message/rfc822
Content-Disposition: inline

Date: Mon, 12 Nov 2007 01:31:30 +0100
From: Lennart Poettering <lennart@poettering.net>
To: Takashi Iwai <tiwai@suse.de>
Subject: Status of ALSA "simple" mixer interface
Message-ID: <20071112003130.GA3266@tango.0pointer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Red Hat, Inc.
X-Campaign-1: ()  ASCII Ribbon Campaign
X-Campaign-2: /  Against HTML Email & vCards - Against Microsoft Attachments
User-Agent: Leviathan/19.8.0 [zh] (Cray 3; I; Solaris 4.711; Console)

Hi!

/usr/include/alsa/mixer.h contains this comment:

   /* Simple (legacy) mixer elements API */

What does the "legacy" exactly mean? Shouldn't I be using it in new
code? I am currently looking for some way I can find out which PCM
channel for a stream on something like "surround51:0" maps to which
mixer element. How am I supposed to implement something like this
without stuff like the snd_mixer_selem_channel_id_t?

A second question: 

aplay -L suggest to use "surround71:" (and *only* that) as plugin for my
usb webcam that only has a single mono channel.  What's going wrong?
Any idea where I should be looking?

Thanks,

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4

--3MwIy2ne0vdjdPXF
Content-Type: message/rfc822
Content-Disposition: inline

Date: Tue, 13 Nov 2007 17:56:46 +0100
From: Lennart Poettering <lennart@poettering.net>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: Status of ALSA "simple" mixer interface
Message-ID: <20071113165646.GA735@tango.0pointer.de>
References: <20071112003130.GA3266@tango.0pointer.de> <s5habpiv0z2.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5habpiv0z2.wl%tiwai@suse.de>
Organization: Red Hat, Inc.
X-Campaign-1: ()  ASCII Ribbon Campaign
X-Campaign-2: /  Against HTML Email & vCards - Against Microsoft Attachments
User-Agent: Leviathan/19.8.0 [zh] (Cray 3; I; Solaris 4.711; Console)

On Tue, 13.11.07 12:28, Takashi Iwai (tiwai@suse.de) wrote:

Hi!

> > aplay -L suggest to use "surround71:" (and *only* that) as plugin for my
> > usb webcam that only has a single mono channel.  What's going wrong?
> > Any idea where I should be looking?
> 
> I guess it's C-Media one?  Its controller accepts only 8-channel
> interleaved output even if the hardware supports only less channels.
> Perhaps to save a few cent for the controller chip.

It's a cheap Philips webcam which really has only a single channel. If
I try to open the device with "arecord", i get:

<snip>
$ arecord -D surround71:CARD=U0x4710x311,DEV=0  -r 44100 -c 8 -f s16_le
Recording WAVE 'stdin' : Signed 16 bit Little Endian, Rate 44100 Hz, Channels 8
arecord: set_params:879: Broken configuration for this PCM: no configurations available
</snip>

i.e. the device string that arecord -L lists for the device is not
working at all. Actually, speaking of it, on my machine with 5 sound
devices "aplay/arecord -L" generate almost exclusively total
rubbish -- only for one device the list makes sense. Here's the 
full list:

<snip>
$ aplay -L | grep -v "^ "
front:CARD=AudioPCI,DEV=0
surround40:CARD=AudioPCI,DEV=0
iec958:CARD=AudioPCI,DEV=0
null
front:CARD=V8237,DEV=0
surround40:CARD=V8237,DEV=0
surround41:CARD=V8237,DEV=0
surround50:CARD=V8237,DEV=0
surround51:CARD=V8237,DEV=0
iec958:CARD=V8237,DEV=0
surround41:CARD=U0x4710x311,DEV=0
surround50:CARD=U0x4710x311,DEV=0
surround51:CARD=U0x4710x311,DEV=0
surround71:CARD=U0x4710x311,DEV=0
surround41:CARD=Audio,DEV=0
surround50:CARD=Audio,DEV=0
surround51:CARD=Audio,DEV=0
surround71:CARD=Audio,DEV=0
</snip>

And this is the output of "arecord -L":

<snip>
$ arecord -L | grep -v "^ "
front:CARD=AudioPCI,DEV=0
rear:CARD=AudioPCI,DEV=0
surround40:CARD=AudioPCI,DEV=0
iec958:CARD=AudioPCI,DEV=0
null
front:CARD=V8237,DEV=0
surround40:CARD=V8237,DEV=0
surround41:CARD=V8237,DEV=0
surround50:CARD=V8237,DEV=0
surround51:CARD=V8237,DEV=0
iec958:CARD=V8237,DEV=0
surround41:CARD=Audio,DEV=0
surround50:CARD=Audio,DEV=0
surround51:CARD=Audio,DEV=0
surround71:CARD=Audio,DEV=0
</snip>

For comparison, here's what /proc/asound/pcm contains:

<snip>
00-01: ES1371/2 : ES1371 DAC1 : playback 1
00-00: ES1371/1 : ES1371 DAC2/ADC : playback 1 : capture 1
01-01: VIA 8237 : VIA 8237 : playback 1 : capture 1
01-00: VIA 8237 : VIA 8237 : playback 4 : capture 1
02-01: Bt87x Analog : Bt87x Analog : capture 1
02-00: Bt87x Digital : Bt87x Digital : capture 1
03-00: USB Audio : USB Audio : capture 1
04-00: USB Audio : USB Audio : playback 1 : capture 1
</snip>

First of all, the -L lists miss one device: my Bt878 tv card. It's
hwoever shown properly in /proc/asound/pcm, and works fine if
accessed.

Then, as mentioned above, it lists the mono-only webcam (U0x4710x311)
with the four surround suggestions -- which doesn't make any sense at
all. And only on "aplay -L" -- although it is a record only
channel. If I try to open the audio device with any of the four
suggestions I just get the "configuration error" back that is shown
above. The way to open it is "hw:CARD=U0x4710x311,DEV=0" -- and
of course only with arecord.

Then, it doesn't list either "front:" nor "iec958" for my USB surround
sound card (The one listed as "Audio") -- both of which happen to work
fine. However, it does list "surround71:", which is quite surprising,
since the sound card doesn't have that many output ports -- but I
guess that is one of the cases where the hardware just doesn't have
soldered all outputs the device theoretically supports. Opening the
device as surround71: works fine, BTW.

Then, for the "AudioPCI" card, it lists a "surround40:" device, which
when opened just yields:

<snip>
$ aplay -D surround40:CARD=AudioPCI,DEV=0
ALSA lib setup.c:555:(add_elem) Cannot obtain info for CTL elem (MIXER,'AC97 2ch->4ch Copy Switch',0,0,0): No such file or directory
aplay: main:546: audio open error: No such file or directory
</snip>

And it also lists a "iec958" device for the same "AudioPCI", which
just yields this:

<snip>
$ aplay -D iec958:CARD=AudioPCI,DEV=0
ALSA lib setup.c:555:(add_elem) Cannot obtain info for CTL elem (PCM,'IEC958 Playback PCM Stream',0,0,0): No such file or directory
aplay: main:546: audio open error: No such file or directory
</snip>

The hardware has no SPDIF and is stereo only.

And then, surprisingly it lists a "rear:" device -- but only for
recording (!). Not surprisingly, this one doesn't work either.

The devices listed for the V8237 are the only ones which fully work
and are complete.

So, in summary. For the five audio cards I have connected to my
machine, "aplay -L" and "arecord -L" show 11 device hints that don't
work at all. And it misses 6 device hints that are important.

I am not sure what to make of this, besides that the name hinting
system is just badly broken. 

This is alsa-lib 1.0.15 on kernel 2.6.22, btw.

Five more things I am wondering about, though:

1) Wouldn't it make sense to have a "mono:" device similar to the
   other surround/front/rear devices? The single use case would be the
   mono-only usb webcam I mentioned above.

2) If I understood correctly, then on some devices it is possible to
   open a analog output and a SPDIF output simultaneously and
   independently. On others however, they are exclusive to each
   other. The name hinting system doesn't really distuinguish
   those cases. Any idea how I could detect this? The reason is, I'd like to
   open both SPDIF and analog out in PulseAudio at the same time -- if
   it is possible. If it is not I want to give the user a quick way to
   switch the outputs.

3) Some newer soundcards lack a hw volume control if I understood
   correctly. Unfortunately I don't have access to them myself. But
   apparently if PulseAudio is run on those devices, volume control in
   PulseAudio doesn't work at all. Apparently ALSA uses softvol to add
   a software volume control (attenuation) to the mixer on those
   soundcards. PA finds that control and makes use of it -- however,
   since it accesses the PCM via the raw devices (hw:, surround41: and
   so on) softvol doesn't work: i.e. the volume that people can change
   through the PA mixer is not reflected in any way in the audio
   output.

   Now, is there a way I can detect for a mixer element if it is
   "real" or if it is implemented only for the "plughw" PCM? As it
   seems the "hw:0" mixer device does contain "virtual" tracks, isn't that a
   bit strange? Shouldn't the virtual mixer tracks be available only
   in a mixer device "plughw:0"? That at least would be symmetric to
   the PCM case, wouldn't it?

4) If I open an audio device with "plughw:" i can disable the software
   resampling that takes place via
   "snd_pcm_hw_params_get_rate_resample()". However, there is no
   equivalent for disabling the channel number adjustment or the
   sample format conversion. This would be very useful in PA however,
   since this would allow me to use only the parts of plughw I am
   interested in (softvol), and disable all the rest (resampling,
   conversion, channel remixing).

5) I really dislike the fact that ALSA insists to do the channel
   reordering for me if I access the audio device via
   "surround51:". In the interest of having the shortest pipeline
   possible with no redundant steps in PA, I'd prefer if I could open
   the device as hw:0, and query the suggested channel ordering of the
   HW, instead of always having ALSA around doing the rearranging.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4

--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--3MwIy2ne0vdjdPXF--
