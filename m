From: Jeffrey Scott Flesher Gmail <jeffrey.scott.flesher@gmail.com>
Subject: Re: GR-55 Driver
Date: Mon, 16 May 2011 14:33:03 -0700
Message-ID: <1305581583.2594.40.camel@TrinaryDragon>
References: <1305224448.5083.37.camel@TrinaryDragon>
	<BANLkTimvr7TkmTiCeeNOeOH66++sHnCfbg@mail.gmail.com>
	<1305233604.8214.2.camel@TrinaryDragon>
	<BANLkTikGVDWxShJOsfspETPVwKDqcJtNOg@mail.gmail.com>
	<1305253856.5076.65.camel@TrinaryDragon>
	<BANLkTi=jj7cjxgmOpH+EHnUMuazqLOEsZA@mail.gmail.com>
	<1305441562.2850.7.camel@TrinaryDragon>
	<BANLkTik-m+BmV0+vQyVfPPDSmCgXspCuAg@mail.gmail.com>
	<1305501208.7165.13.camel@TrinaryDragon>
	<BANLkTimD7pPS6ErrWA6rVKzjV1KoOj-yWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179]) by alsa0.perex.cz (Postfix) with ESMTP id 5A84E24426
	for <alsa-devel@alsa-project.org>;
	Mon, 16 May 2011 23:33:07 +0200 (CEST)
Received: by pvf33 with SMTP id 33so2725186pvf.38
	for <alsa-devel@alsa-project.org>; Mon, 16 May 2011 14:33:05 -0700 (PDT)
In-Reply-To: <BANLkTimD7pPS6ErrWA6rVKzjV1KoOj-yWw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Results:

# cat /proc/asound/card3/stream0
cat: /proc/asound/card3/stream0: No such file or directory
***
# alsamixer -D hw:GR55
This sound device does not have any controls.
***
# amixer -D hw:GR55 controls
[Nothing]
***
# cat /proc/asound/GR55/stream0
Roland GR-55 at usb-0000:00:12.2-4, high speed : USB Audio

Playback:
  Status: Stop
  Interface 0
    Altset 1
    Format: S32_LE
    Channels: 2
    Endpoint: 5 OUT (ASYNC)
    Rates: 44100
    Data packet interval: 125 us

Capture:
  Status: Stop
  Interface 1
    Altset 1
    Format: S32_LE
    Channels: 2
    Endpoint: 4 IN (ASYNC)
    Rates: 44100
    Data packet interval: 125 us
***
# cat /proc/asound/GR55/midi0
GR-55
***
# aplay -D plughw:GR55,0,0 /usr/share/sounds/alsa/Front_Center.wav
Playing WAVE '/usr/share/sounds/alsa/Front_Center.wav' : Signed 16 bit
Little Endian, Rate 48000 Hz, Mono
[No sound]
***
I am facing two problems, I am unfamiliar with this piece of equipment
and as a result, I'm unsure how to test it.

Testing Audio function:
I tested it with Audacity in Windozes and it works;  in Linux I set it
up the same way: GR-55 USB Audio (hw:1,0) as recording device; no sound.
Using Logitech Webcam software I can record the guitar output; Using
Cheese, I do not get Audio.

Testing MIDI function:
I'm going to call tech support on this one; I have not found a Windows
app that seems to work with the MIDI; so I can not expect to test this
in Linux yet; I would like to be able to convert notes into sheet music;
I tried TuxGuitar, but must admit I don't know how to get it to work
with MIDI input, or if it even does.

So far I have not been impressed with how this device works in Windows;
asking questions at forums I get users say to use Windows, I have no
idea why, the quality was not that good. 

I must say it works great with just the headphones connected to the
device.

I'm thinking about getting M-Audio Fast track pro to provide an input
for the GR-55 as well as my NTG-1 mic; can you tell me the status of the
driver for this unit; I have seen talk about the driver here, but not
sure if the Fast track, and fast track pro are the same, or if this unit
will even work with the GR-55, I have ask at other forums and have
gotten no reply.

I'm going to keep on this till I get it 100%; I have patience; lets hope
you do too. 

Thanks
Jeff

-----Original Message-----
From: Daniel Mack <zonque@gmail.com>
To: Jeffrey Scott Flesher Gmail <jeffrey.scott.flesher@gmail.com>
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] GR-55 Driver
Date: Mon, 16 May 2011 09:05:54 +0200


On Mon, May 16, 2011 at 1:13 AM, Jeffrey Scott Flesher Gmail
<jeffrey.scott.flesher@gmail.com> wrote:
> Still no luck; I spent most of the day researching and trying things.
>
> This is a file of what information I could dig up; it should be useful
> http://vetshelpcenter.com/media/trouble-shoot-gr-55.txt
>
> Are there any programs/scripts I can install/run that will help trouble
> shoot this?

You most probably just have a confusion about the four cards connected
to your computer.

As you can see from your output of /proc/asound/cards, the GR55 is not
the first one, and hence not the default picked by tools like aplay or
amixer. However, it is present, which is a good sign. For further
parsing the contents of /proc/asound, you need to refer to the device
number, which is not 1 (as in "card1") but 3. What does "cat
/proc/asound/card3/stream0" show?

Just try "alsamixer -D hw:GR55" to control the volume levels, or
"amixer -D hw:GR55 controls" to dump them.

And then, try "aplay -D plughw:GR55,0,0 file.wav" for a first output test.

Does that help?


Daniel
