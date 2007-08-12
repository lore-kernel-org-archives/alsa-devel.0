From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Re: Writing a new sound driver
Date: Sun, 12 Aug 2007 15:02:09 +1200
Message-ID: <200708121502.09106.linux@audioscience.com>
References: <8e4fc8270708111546k328a0575h9e362ee01a2917ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
	by alsa0.perex.cz (Postfix) with ESMTP id D7F8F243A9
	for <alsa-devel@alsa-project.org>;
	Sun, 12 Aug 2007 05:01:04 +0200 (CEST)
Received: from zaphod (121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp4.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0JMN00B6K4DN4M40@smtp4.clear.net.nz> for
	alsa-devel@alsa-project.org; Sun, 12 Aug 2007 15:01:00 +1200 (NZST)
In-reply-to: <8e4fc8270708111546k328a0575h9e362ee01a2917ec@mail.gmail.com>
Content-disposition: inline
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
Cc: Michael Bourgeous <sts.nitrogen@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Mike,

On Sunday 12 August 2007 10:46:07 Michael Bourgeous wrote:
> I am the developer of the work-in-progress MyHD/TL880 Linux driver.
> The TL880 chip can act as a sound input and output device, but it
> doesn't seem to support DMA for sound.  Is it possible to write a
> sound driver for ALSA that uses a polling mechanism?  

Yes.

Read about the copy and silence callbacks here:
http://www-old.alsa-project.org/~iwai/writing-an-alsa-driver/x1409.htm

Get the alsa-driver source code and grep -r "\.copy" to find drivers that use 
this method. E.g. RME, asihpi

Does it support interrupts?
If so see 
http://www-old.alsa-project.org/~iwai/writing-an-alsa-driver/x773.htm

otherwise you need to use a timer to poll the transfer status and call
snd_pcm_period_elapsed appropriately  similar to the High-frequent timer 
interrupts section of the above reference.  

> Also, how would 
> I integrate this driver with my core driver for accessing the TL880?
> The chip's features span four separate kernel subsystems: v4l, dvb,
> sound, and fb.

What are dependencies if any between these functions on the chip?

> I guess my main question is this: what is the bare minimum of code and
> hardware functionality required to write a sound driver?

The "dummy" driver provides a starting point to which you can add your own 
functionality.

For alsa driver code implementing mixer controls is almost completely 
independent of audio I/O (apart from very top level where they belong to the 
same card object), so you can leave it out to start with,  unless you need to 
set some controls to get audio out!

--
Eliot
