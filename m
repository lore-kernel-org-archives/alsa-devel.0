From: "Pedro I. Sanchez" <psanchez@fosstel.com>
Subject: Re: ASoC: at91sam9260-PCM1808/TAS5709-based board
	driver
Date: Tue, 25 Aug 2009 13:31:57 -0400
Message-ID: <4A94200D.6080707@fosstel.com>
References: <4A7DB844.3030303@fosstel.com>	<9e4733910908090635j29db4ebn64f92c2176f3cb85@mail.gmail.com>	<9e4733910908090637g4b9eaf19ud1b46de354664df2@mail.gmail.com>	<4A81BB75.3070405@fosstel.com>
	<20090811224132.GB4691@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from a2s40.a2hosting.com (a2s40.a2hosting.com [74.126.24.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 09C06245A7
	for <alsa-devel@alsa-project.org>;
	Tue, 25 Aug 2009 19:32:32 +0200 (CEST)
Received: from [207.35.173.122] (helo=[192.168.215.229])
	by a2s40.a2hosting.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69) (envelope-from <psanchez@fosstel.com>)
	id 1Mfzsk-0001Ye-JW
	for alsa-devel@alsa-project.org; Tue, 25 Aug 2009 13:32:30 -0400
In-Reply-To: <20090811224132.GB4691@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

I've been working on my driver, this time concentrating on the TAS5760. 
I decided to use the WM8731 codec and the sam9g20_wm8731 machine drivers 
as templates.

Things are mostly OK now, my kernel modules install, and the driver can 
read/write the chip registers properly. User space applications can see 
my custom board as a sound card. Tha's progress!

The TAS5709 is a playback-slave-only device The SSC is therefore put in 
master mode and I can see the SSC clock signals (SCLK and LRCLK) on the 
scope when playing a sound file. I can also see the activity on the data 
line. But unfortunately, there is no sound, just a speaker Hisss when I 
play a file. I doubled checked all the volume levels to ensure they are 
not mutted.

However, I noticed that the duty cycle of the SSC clocks is not 50% as I 
would expect it to be. There seem to be much more bits on one channel 
than in the other (my sample file is stereo, 16 bits, 44.1 MHz). The 
sample clock illustrations in the TAS5709 all have the same number of 
bits per channel, but it doesn't say explicitly that this is mandatory. 
 From my understanding of the I2S spec, this is not.

The TAS5709 is supposed to detect the clock and data rates 
automatically. Do you know if this non-50% duty cycle could be the 
reason for the lack of sound? Is there a way to force it to be 50%?

Thanks,

-- 
Pedro
