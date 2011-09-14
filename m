From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Noise using pulseaudio with ymf724f
Date: Wed, 14 Sep 2011 11:05:34 +0200
Message-ID: <4E706E5E.2020602@ladisch.de>
References: <CAN8ccibqYPovEn=M9b-x4ZjqM3U9DwKnJtyDUKGoos-C2WBVXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id E1A8A246EA
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Sep 2011 11:05:19 +0200 (CEST)
In-Reply-To: <CAN8ccibqYPovEn=M9b-x4ZjqM3U9DwKnJtyDUKGoos-C2WBVXg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Raymond Yau wrote:
> Is 256 frames/period in s16 stereo since the card support mono ,
> stereo , U8 and S16 ,

The hardware uses S16 stereo at 48 kHz internally; everything else is
converted and resampled to that.

> What is the meaning of SNDRV_PCM_INFO_BLOCK_TRANSFER

That the card transfers samples in blocks.

> since the rewind_safeguard of PA server is 256 bytes ?

A block in the native format has 1024 bytes.

> Will this

What's "this"?

> help since minimum period time of snd_ymfpci is 5.333ms but
> alsa-pulse plugin announce a lower value 128 bytes (period_bytes_min)
> to the alsa application ?

Doesn't PA assume that the hardware has accurate pointer positions?
Without this, smaller periods do not make sense unless PA can
interpolate from the period interrupts.


Regards,
Clemens
