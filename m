From: "Patrick Shirkey" <pshirkey@boosthardware.com>
Subject: Re: Testing/Debugging alc668 with ASUS N750JK
Date: Thu, 31 Jul 2014 17:32:32 +1000 (EST)
Message-ID: <55293.86.107.254.57.1406791952.squirrel@boosthardware.com>
References: <cover.1406259578.git.nicoleotsuka@gmail.com>
 <f4ff79269a1680f9ce128e0e98fea926d3a41834.1406259578.git.nicoleotsuka@gmail.com>
 <53D1DC0B.1000905@gmail.com>
 <63638.86.107.254.57.1406266836.squirrel@boosthardware.com>
 <CAN8cciboNrRRFBQjX66qud7KoTCqsDHxvFAws9-ywasjemtYbQ@mail.gmail.com>
 <59187.86.107.254.57.1406362728.squirrel@boosthardware.com>
 <CAN8cciax7RreogV0otMdLt0y-dOTrZD3D_ih0doAC9F_XkJ1ew@mail.gmail.com>
 <57315.86.107.254.57.1406609183.squirrel@boosthardware.com>
 <CAN8ccia3mi9G2oyaYyvJx14xu6F8dLhNZ6r0dpraO1F8qeLjBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from boosthardware.localdomain (boosthardware.com [88.198.122.139])
 by alsa0.perex.cz (Postfix) with ESMTP id 1871F261AFC
 for <alsa-devel@alsa-project.org>; Thu, 31 Jul 2014 09:32:34 +0200 (CEST)
In-Reply-To: <CAN8ccia3mi9G2oyaYyvJx14xu6F8dLhNZ6r0dpraO1F8qeLjBg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On Thu, July 31, 2014 1:27 pm, Raymond Yau wrote:

>
> You can use hda-verb GET_PIN_SENSE to test all the pin complex nodes which
> pincap support DETECT
>

I have tried a few attempts but it's pretty confusing.

These ones don't do anything:

# hda-verb /dev/snd/hwC1D0  GET_PIN_SENSE
# hda-verb /dev/snd/hwC1D0  0x0 GET_PIN_SENSE


I don't know what to make of this output:

# hda-verb /dev/snd/hwC1D0  0x0 GET_PIN_SENSE PIN_CAP
nid = 0x0, verb = 0xf09, param = 0xc
value = 0x0
# hda-verb /dev/snd/hwC0D0  0x0 GET_PIN_SENSE PIN_CAP
nid = 0x0, verb = 0xf09, param = 0xc
value = 0x0
# hda-verb /dev/snd/hwC0D0  0x16 GET_PIN_SENSE PIN_CAP
nid = 0x16, verb = 0xf09, param = 0xc
value = 0xffffffff
# hda-verb /dev/snd/hwC0D0  0x19 GET_PIN_SENSE PIN_CAP
nid = 0x19, verb = 0xf09, param = 0xc
value = 0xffffffff
# hda-verb /dev/snd/hwC0D0  0x1a GET_PIN_SENSE PIN_CAP
nid = 0x1a, verb = 0xf09, param = 0xc
value = 0xffffffff
# hda-verb /dev/snd/hwC0D0  0x1b GET_PIN_SENSE PIN_CAP
nid = 0x1b, verb = 0xf09, param = 0xc
value = 0xffffffff



>> > Do surround 2.1 works ?
>> >
>>
>> It says it is working but I do not get sound out of the sub woofer.  I
>> can
>> hear static(whitenoise) through the front speakers (with pulseaudio
>> test)
>> if  I set pins 0x19 and 0x1a to Line Out (Center/LFE) and Internal
>> (Center/LFE) or vice versa with hdajackretask.
>>
>
> http://git.alsa-project.org/?p=alsa-tools.git;a=blob;f=hdajackretask/README;hb=HEAD
>
> Did you use apply button(dyanmic reconfiguartion) or installment boot
> override (early patching) ?
>

I have tried both options.

After rebooting with the apply option set I don't hear any static or audio
with the PA test app.

>>
>> I do not see any controls for the bass volume in alsamixer
>>
>>
>
> https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda?id=f37bc7a88d374448a1f4bba9267d308606d78bf2
>

I have checked alsamixer again after the last round of tinkering with
hdajackretask and" Speaker CLFE" is now showing up but it does not have
volume control just mute on/off.

I see the following new controls

Speaker CFLE (mute only)
Speaker Front (mute + vol)
Speaker Side (mute only)
Speaker Surround (mute + vol)


>> >>
>> >> >> - I have found a couple of kernel bug reports  for other ASUS
>> models
>> >> >> with
>> >> >> this chipset but they are both marked resolved. Should I open a
>> new
>> >> >> ticket
>> >> >> ?
>> >> >>
>> >> >> https://bugzilla.kernel.org/show_bug.cgi?id=65091
>> >> >> https://bugzilla.kernel.org/show_bug.cgi?id=66271
>> >> >>
>> >> >> - I can hear static through the front speakers (with pulseaudio
> test)
>> >> >> if
>> >> >> I set pins 0x19 and 0x1a to Line Out (Center/LFE) and Internal
>> >> >> (Center/LFE) or vice versa with hdajackretask.
>> >> >>
>
>> > For multi channel, the sequence number is ascending and the driver
> expect
>> > they have same type i.e, all speakers or all line out jacks
>> >
>
> Pin Default 0x90170110: [Fixed] Speaker at Int N/A
>     Conn = Analog, Color = Unknown
>     DefAssociation = 0x1, Sequence = 0x0
>     Misc = NO_PRESENCE
>
> The rear speaker need  same default association but  sequence number
> higher than that of the front speaker
>
> The external subwoofer may use [jack] speaker with same default
> association and higher sequence number if it can be detected
>
> The driver won't use all of them for multi channel if you retasked it as
> line out
>

I have tried several combinations with hdajackretask

I am not able to get audio out of the physical rear speakers or sonic
master output.

I can get audio to play back in the front l/c/r speakers with varying
combinations.

ex.

7.1 side l/r plays through front l/r or front c
4.0 rear r/l plays through front l/r
2.1 l/r plays through front l/r
2.1 subwoofer plays white noise through front c

Most of the time it is only front left/right that make any sound.
Sometimes there is no sound on one audio profile but it works on a couple
of channels on another profile.

Any time that the Center LFE works it produces white noise.

I have tried with both options: apply and patch/reboot

I can keep playing around with the settings until I eventually stumble on
a combination that works but it seems like this process should be
scriptable. Given that I will probably spend hours of my time on the test
process and I have already spent 4 separate sessions on testing it seems
like it would be better value for my time and others going forward to
write a test script.

So what do I need to do to write a script that will test all the
combinations and play audio through them? Or am I missing something that
someone else has already written for this purpose?

Currently I am using this process:

1: hdajackretask - modify params
2: pulseaudio -k
3: hdajackretask : apply settings
4: pulseaudio -D
5: open PA audio config
6: select audio output option and press test speakers button
7: manually press every button

Rinse and repeat.

Surely there is a more humane method for testing the variations ;-)




--
Patrick Shirkey
Boost Hardware Ltd
