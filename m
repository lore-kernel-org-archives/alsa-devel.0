From: Simos Xenitellis <simos.lists@googlemail.com>
Subject: Re: Sound distortion with Realtek ALC889A
Date: Fri, 30 Oct 2009 03:47:23 +0200
Message-ID: <598e9210910291847q7014e9f8s1489d90cea9e09df@mail.gmail.com>
References: <9c09d22d0910290521t19e718c5vb38bba3b558e8710@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f196.google.com (mail-yx0-f196.google.com
	[209.85.210.196])
	by alsa0.perex.cz (Postfix) with ESMTP id 407A52442A
	for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2009 02:47:44 +0100 (CET)
Received: by yxe34 with SMTP id 34so2328656yxe.16
	for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2009 18:47:43 -0700 (PDT)
In-Reply-To: <9c09d22d0910290521t19e718c5vb38bba3b558e8710@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Damien Brossard <brossard.damien@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 29, 2009 at 2:21 PM, Damien Brossard
<brossard.damien@gmail.com> wrote:
>
> Hi.
>
> I recently bought a Gigabyte GA-MA78GM-S2H motherboard. This board uses the
> (in)famous (from what i've read for now) alc889a chip. While playing 5.1
> content, I can hear noise or distortion coming from the center channel. I
> can not test my configuration with another OS, so I can't fully dismiss a HW
> problem. However, i made several tests with 5.1 and 2.0 speakers which
> points me to soundcard problem.
>
> I've made some tests with speaker-test (speaker-test -D surround51 -c 6) :
> 1) Each time a sound is played either on front left channel or rear left
> channel, a noise can be heared on the center channel (and subwoofer, this is
> confirmed pluging a stereo headphone on the center/lfe jack). No noise when
> a sound is played on right channels (front or rear).
> 2) In alsamixer, if I set the volume to 0 for the front or rear left
> channels, i can hear the noise on center/lfe when a sound is "played" on
> this channels
> 3) In alsamixer, if I mute the front or rear left channels, i can hear no
> more noise on center/lfe
>
> Complementary tests have been made with alsaplayer and using a simple mp3
> file. In this configuration (stereo output), center and rear channels play
> the same sound as front channel.
> 1) If all channels are unmuted, I hear no noise.
> 2) If either the front channel or the rear channel are muted, I can hear the
> noise on center channel.
>
> I tried this with alsa-driver 1.0.20 and 1.0.21 with the same result, I
> recently went back to 1.0.20 due to kernel upgrade.
>
> Things that seem strange to me (maybe not so strange to alsa dev :)) :
> 1) alsamixer shows volumes in percentage, however when I set a channel
> volume to 50% and the master volume to 50%, I hope to find a resulting
> volume of 25%, not 0.
> 2) lspci reports my soundcard subsystem id as 1458:a022, but in
> /proc/asound/card0/codec#0 the subsystem id is 1458:a002
>
> Googling around made me find few references (in alsa-devel list) to a
> similar problem :
>
> http://mailman.alsa-project.org/pipermail/alsa-devel/2008-July/008942.html
> http://mailman.alsa-project.org/pipermail/alsa-devel/2008-August/009754.html
>
> The distortion / noise described here is exactly what i can hear with my
> system. Apparently the user solved the issue buying another soundcard. I'd
> like to be sure it is the only way to go.
>
> Attached is the file produced by alsa-info.sh

A user had the same issue (Gigabyte P35-DS4), with alsa-info
http://www.alsa-project.org/db/?f=eb49c36810be2543bcb913d80390f6cba13ec766
and he just reported back that setting the model line to

options snd-hda-intel model=6stack-dig

he was able to fix the problem.

He tried this on Ubuntu 9.10 (Alsa 1.0.20).
Assuming that it has not been fixed yet, what change would I make to
the Alsa source code so that newer versions would be able to
autodetect the chipset?
I would appreciate such an answer, as I tend to get a few feedback
reports on audio cards.

Simos
