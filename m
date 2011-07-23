From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Re: [arch-general] Panic - no sound devices after
	upgrade
Date: Sat, 23 Jul 2011 17:07:53 +0200
Message-ID: <4E2AE3C9.8060509@drcomp.erfurt.thur.de>
References: <20110720163844.GB16901@linuxaudio.org>
	<CAG-2HqWqATSJ=oJTTvULXwPEG82yN+8e6GJFs759hPA-=krAOQ@mail.gmail.com>
	<20110721100944.GA13971@linuxaudio.org>
	<CAG-2HqX23C79vfccnu0tMqx+6K9Z5pS0_HekaLizQx7XfkPQ1Q@mail.gmail.com>
	<20110721112331.GA15059@linuxaudio.org>
	<CAG-2HqWK3x5-szkyzX8AMxuMpDZNVRXHYtQ0AkAPMsGcLK0Z9w@mail.gmail.com>
	<4E28313E.60900@drcomp.erfurt.thur.de>
	<CAG-2HqVew75LE68fObz7e3WwcT-5Gwu1ka9Zr4vb1JdbSUOYEQ@mail.gmail.com>
	<20110722193710.GA8452@linuxaudio.org>
	<20110722231430.GN3771@ltw.loris.tv>
	<20110723142117.GA21836@linuxaudio.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [85.14.220.160])
	by alsa0.perex.cz (Postfix) with ESMTP id B19F52458D
	for <alsa-devel@alsa-project.org>;
	Sat, 23 Jul 2011 17:08:17 +0200 (CEST)
In-Reply-To: <20110723142117.GA21836@linuxaudio.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Fons Adriaensen <fons@linuxaudio.org>
Cc: Tom Gundersen <teg@jklm.no>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, General Discussion about Arch Linux <arch-general@archlinux.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 07/23/11 16:21, Fons Adriaensen wrote:

Note: I suggest to narrow the CC list a bit and better move the
discussion to alsa-devel. At least, let's drop LKML and arch.

>>> Seems to have solved the problem :-) :-)
>> Good to know. I'll wait for your final confirmation and then commit it.
> 
> One problem: the gain settings have changed, now having a range of 0..64.
> How do these values map to the internal ones (0..0xffff) ? I *hope* there
> is value corresponding to EXACTLY 0x8000 (gain = 1) !!!

For the simple ALSA mixer, the driver does

   gain = ucontrol->value.integer.value[0]*UNITY_GAIN/64;

UNITY_GAIN is 32768 (0x8000), so if you select 64 on the ALSA side, it
gives you exactly what you need. Or in other words: faders to 100% in
alsamixer, that's it.

With hdspmixer or any other software that's using the full mixer, you
can still use the fine-grained 65k steps.


> BTW, why was this change made?

No idea. I reckon faberman was tired of stepping through 65k mixer
levels in alsamixer. ;) (disclaimer: I never used the old driver, so I
don't know how it was before)


Cheers
