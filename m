From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Constraining the number of frames per period
Date: Fri, 22 Oct 2010 08:38:11 +0200
Message-ID: <4CC13153.7040002@ladisch.de>
References: <AANLkTi=v2DKXfptubtwEPfH_4eZJ-vwLqVHAkmf3iE2D@mail.gmail.com>	<alpine.LNX.2.00.1010211649160.29422@eeebox2.perex-int.cz>
	<AANLkTikAf+o7e-=hosi+dwEywK-Mt5UTvJtqzT=i_5Fz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id C4F7B103AD5
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Oct 2010 08:36:21 +0200 (CEST)
In-Reply-To: <AANLkTikAf+o7e-=hosi+dwEywK-Mt5UTvJtqzT=i_5Fz@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Adam Rosenberg <adam@alcorn.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Adam Rosenberg wrote:
> I am trying to constrain the number of frames per period (not the number of
> periods).  The DMA transfer creates an interrupt every 512 frames (1 frame =
> 16 channels with 32bits per channel) .  I am having a difficult time
> understanding how to properly write the ALSA driver so that it will work
> with many different formats and between 1 and 2 channels.

Using period_bytes_min/max doesn't work for this situation; these fields
are intended for hardware that has constraints on the number of bytes.

Set the snd_pcm_hardware fields so that all sample formats are supported.
In the PCM devive's open callback, add another constraint by calling
snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_PERIOD_SIZE, 512, 512);

>     // the max number of bytes in one PCM stream
>     // must allow for a minimum of 4 periods with
>     // 512 frames per period and up to 2 channels of
>     // 32 bit data per frame
>     .buffer_bytes_max = 32768,  // this value allows 8 periods of the max frame size

Are the minimum 4 and maximum 8 periods actual hardware constraints?


Regards,
Clemens
