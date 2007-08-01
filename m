From: Timur Tabi <timur@freescale.com>
Subject: Re: MPC5200 I2S driver for ASoC
Date: Wed, 01 Aug 2007 14:45:08 -0500
Message-ID: <46B0E2C4.2010707@freescale.com>
References: <46B0C3EE.5020401@acdstar.com> <46B0C89D.50704@freescale.com>
	<46B0DC07.4050000@acdstar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id DA15810384D
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Aug 2007 21:45:14 +0200 (CEST)
In-Reply-To: <46B0DC07.4050000@acdstar.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: lokowich <lokowich@acdstar.com>
Cc: ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

lokowich wrote:

>     Yes, I presume you mean using git into the ALSA branch.  I need to
>     get more familiar with git, and follow the appropriate coding
>     conventions before it's ready.  Any guidance will be appreciated.

No, I meant that your code and my code will probably need to merge, so we need to compare 
the code to take advantage of any commonality.

However, after looking at the 5200 manual, it appears there's not really a whole lot in 
common after all.  Still, I'd like to provide some input to your code once I see it.

>     Yes!  I had enabled the S16_BE format in my codec/i2s/pcm driver,
>     but naively thought ALSA would handle the rest.

Well, ALSA has plug-ins for sample rate and size, but I don't think it has one for 
endianness.  I'm not really sure.  Besides, if you use "aplay -Dhw:0,0", you are bypassing 
all ALSA plug-ins.

>  Converted my test
>     file to S16_BE and it sounds much closer to the original.  Thanks!

You're welcome.  The reason why it sounded garbage is because when you write a 
little-endian sample to the shift register, it bit order is this:

07-06-05-04-03-02-01-00 15-14-13-12-11-10-09-08

The bytes may be little-endian, but the bits are big-endian.

>     Found the "jitter" is due to a FIFO overflow.  

That makes sense.

 > I'm using same alarm
>     (0x120) and granularity (4) common to 2.4 I2S and ac97 drivers.  Is
>     there a more appropriate setting for 16-bit, 2-channel, 44.1kHz audio?

I don't know enough about the 5200 to say.  The I2S hardware I'm using looks like it's 
much more complicated than what's on the 5200.

>     Also, can we chat about SDRAM problems on 5200B outside of this forum?

I know nothing about the 5200, so you'll have to ask someone else about SDRAM.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
