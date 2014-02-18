From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: Headphone output problems with HP ProDesk 600 G1
	(Realtek ALC221)
Date: Tue, 18 Feb 2014 10:31:45 -0600
Message-ID: <CADLC3L1o_nc214yPKTC6ZVeeePHYhb07Djg-_BSp3gGQfD9_hg@mail.gmail.com>
References: <CAN8cciabECOHSBC0N0WP1nb17+HsLRDD9xEUn8LcmuuBsVH+3w@mail.gmail.com>
 <CADLC3L2B_osxvrVaT-MEbGrPWf99C7eHyzw6NZZvB8ayFxJgfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f174.google.com (mail-we0-f174.google.com
 [74.125.82.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 16C4C2651F3
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 17:31:49 +0100 (CET)
Received: by mail-we0-f174.google.com with SMTP id w61so6234633wes.33
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 08:31:45 -0800 (PST)
In-Reply-To: <CADLC3L2B_osxvrVaT-MEbGrPWf99C7eHyzw6NZZvB8ayFxJgfg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 18, 2014 at 10:22 AM, Robert Hancock <hancockrwd@gmail.com> wrote:
> On Mon, Feb 17, 2014 at 8:13 PM, Raymond Yau
> <superquad.vortex2@gmail.com> wrote:
>>>> I have a HP ProDesk 600 G1 machine which seems to have some strange
>> behavior with the front headphone jack(s) running under Fedora 20
>> (running 3.13.2 kernel):
>>
>>>> This machine has two front jacks: a headphone jack and a
>> microphone/headphone jack. When the headphones are plugged into the
>> headphone jack, there's usually no change in the sound outputs list in
>> the Sound control panel. The audio (mostly) works if the audio output
>> device is set to Analog Output, but sometimes spuriously changes back
>> to Speakers and the headphone output stops working (I suspect maybe
>> from a spurious jack-sensing event, though I'm not certain). More
>> confusingly, a couple of times I have gotten it into the state
>> (through various fiddling with jacks and playing in the Sound control
>> panel) where plugging into this jack is detected and causes the
>> Headphone output to be selected in the control panel. I haven't been
>> able to figure out consistently what causes this to happen.
>>
>>>> If the headphone is plugged into the microphone/headphone jack, then
>> the control panel consistently switches to the Headphone output and
>> consistently switches back the way it was when it's unplugged.
>> However, there's no actual audio output coming out of that jack. (From
>> some of the HP manuals, it sounds like with the Windows driver, when
>> you plug into this jack, it's supposed to pop up a prompt asking you
>> whether you want to use it as a microphone or headphones.)
>>
>>>> The other strange thing is that intermittently, on the headphone jack
>> you'll start getting a bunch of loud static (clicking noises) and any
>> actual audio playback becomes very faint and distorted.
>>
>>>> I'm guessing perhaps something isn't being initialized/setup properly
>> in the codec, causing this kind of erratic behavior. The alsa-info
>> output is uploaded at:
>>
>> http://www.alsa-project.org/db/?f=594e837b7af07ffbe3473cf807465bc81a587880
>>
>>>> I tried using hda-analyzer but it fails on this machine with:
>>
>>>> ValueError: wrong proc file format (unknown dig1 bit 'KAE')
>>
>>>> Any suggestions for things to try to debug this?
>>
>>
>> Node 0x14 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
>>   Control: name="PCM Playback Switch", index=0, device=0
>>     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
>>   Control: name="Line Out Jack", index=0, device=0
>>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>>   Amp-Out vals:  [0x00 0x00]
>>   Pincap 0x00010014: OUT EAPD Detect
>>   EAPD 0x2: EAPD
>>   Pin Default 0x01014020: [Jack] Line Out at Ext Rear
>>     Conn = 1/8, Color = Green
>>     DefAssociation = 0x2, Sequence = 0x0
>>
>> it is a driver bug which assign PCM playback Switch to Line Out Jack
>>
>> try the patch  https://bugzilla.kernel.org/attachment.cgi?id=124971
>
> With this patch, I get no audio output at all (totally silent on all
> ports). Even with playing around with alsamixer and muting/unmuting
> outputs I could not get anything coming out.

I've created a Bugzilla report here:

https://bugzilla.kernel.org/show_bug.cgi?id=70791
