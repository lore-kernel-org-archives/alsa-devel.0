From: Damien Brossard <brossard.damien@gmail.com>
Subject: Sound distortion with Realtek ALC889A
Date: Thu, 11 Feb 2010 13:33:24 +0100
Message-ID: <9c09d22d1002110433h564647c0y31ae3e7d3d9cea71@mail.gmail.com>
References: <9c09d22d0910290521t19e718c5vb38bba3b558e8710@mail.gmail.com>
	<598e9210910291847q7014e9f8s1489d90cea9e09df@mail.gmail.com>
	<9c09d22d0910300401g60ea830cif137b1ab6726d1ac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f223.google.com (mail-ew0-f223.google.com
	[209.85.219.223])
	by alsa0.perex.cz (Postfix) with ESMTP id D96B2243DB
	for <alsa-devel@alsa-project.org>; Thu, 11 Feb 2010 13:33:25 +0100 (CET)
Received: by ewy23 with SMTP id 23so67263ewy.4
	for <alsa-devel@alsa-project.org>; Thu, 11 Feb 2010 04:33:24 -0800 (PST)
In-Reply-To: <9c09d22d0910300401g60ea830cif137b1ab6726d1ac@mail.gmail.com>
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

>
> > Damien Brossard wrote:
>> >
>> > Hi.
>> >
>> > I recently bought a Gigabyte GA-MA78GM-S2H motherboard. This board uses
>> the
>> > (in)famous (from what i've read for now) alc889a chip. While playing 5.1
>> > content, I can hear noise or distortion coming from the center channel.
>> I
>> > can not test my configuration with another OS, so I can't fully dismiss
>> a HW
>> > problem. However, i made several tests with 5.1 and 2.0 speakers which
>> > points me to soundcard problem.
>> >
>> > I've made some tests with speaker-test (speaker-test -D surround51 -c 6)
>> :
>> > 1) Each time a sound is played either on front left channel or rear left
>> > channel, a noise can be heared on the center channel (and subwoofer,
>> this is
>> > confirmed pluging a stereo headphone on the center/lfe jack). No noise
>> when
>> > a sound is played on right channels (front or rear).
>> > 2) In alsamixer, if I set the volume to 0 for the front or rear left
>> > channels, i can hear the noise on center/lfe when a sound is "played" on
>> > this channels
>> > 3) In alsamixer, if I mute the front or rear left channels, i can hear
>> no
>> > more noise on center/lfe
>> >
>> > Complementary tests have been made with alsaplayer and using a simple
>> mp3
>> > file. In this configuration (stereo output), center and rear channels
>> play
>> > the same sound as front channel.
>> > 1) If all channels are unmuted, I hear no noise.
>> > 2) If either the front channel or the rear channel are muted, I can hear
>> the
>> > noise on center channel.
>> >
>> > I tried this with alsa-driver 1.0.20 and 1.0.21 with the same result, I
>> > recently went back to 1.0.20 due to kernel upgrade.
>> >
>> > Things that seem strange to me (maybe not so strange to alsa dev :)) :
>> > 1) alsamixer shows volumes in percentage, however when I set a channel
>> > volume to 50% and the master volume to 50%, I hope to find a resulting
>> > volume of 25%, not 0.
>> > 2) lspci reports my soundcard subsystem id as 1458:a022, but in
>> > /proc/asound/card0/codec#0 the subsystem id is 1458:a002
>> >
>> > Googling around made me find few references (in alsa-devel list) to a
>> > similar problem :
>> >
>> >
>> http://mailman.alsa-project.org/pipermail/alsa-devel/2008-July/008942.html
>> >
>> http://mailman.alsa-project.org/pipermail/alsa-devel/2008-August/009754.html
>> >
>> > The distortion / noise described here is exactly what i can hear with my
>> > system. Apparently the user solved the issue buying another soundcard.
>> I'd
>> > like to be sure it is the only way to go.
>> >
>> > Attached is the file produced by alsa-info.sh
>>
>> A user had the same issue (Gigabyte P35-DS4), with alsa-info
>> http://www.alsa-project.org/db/?f=eb49c36810be2543bcb913d80390f6cba13ec766
>> and he just reported back that setting the model line to
>>
>> options snd-hda-intel model=6stack-dig
>
>
>> he was able to fix the problem.
>>
>
> He tried this on Ubuntu 9.10 (Alsa 1.0.20).
>> Assuming that it has not been fixed yet, what change would I make to
>> the Alsa source code so that newer versions would be able to
>> autodetect the chipset?
>> I would appreciate such an answer, as I tend to get a few feedback
>> reports on audio cards.
>>
>> Simos
>>
>
> Hi,
>
> I tried the "model" solution, but it did not solve the problem for me.
>
> Playing a bit with "PCM Volume" in alsamixer allows me to give a better
> description of what can be heared (very clear when you use "-t sine" option
> with speaker-test) :
> * the distortion played on center channel looks like the same tone but in
> higher octave (that's remind me of harmonics - if the term have any sense in
> english), I don't know how to clearly explain the phenomenon, but the center
> channel plays a higher frequency than the one played on left channels (front
> or rear), few octaves higher (original frequency multiplied by an unknown
> factor)
>
> Damien.
>

Hi.

Sorry for bringing back my problem. I was finally able to test my board
under Vista with Realtek drivers. The sound produced is nice and much more
loud than with alsa 1.0.20. I can hear no distortion as well. So my
conclusion is : software issue. Perhaps an interesting thing to notice is
that with Vista, i must plug my rear speakers on the side slot, while with
alsa i use the rear slot.

Is there a way to dump the codec configuration (as with
/proc/asound/card0/codec#0) in Windows so as to be able to compare it with
the one obtained in Linux ?

Thanks

Damien.
