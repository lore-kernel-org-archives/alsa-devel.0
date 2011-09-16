From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Noise using pulseaudio with ymf724f
Date: Fri, 16 Sep 2011 09:10:15 +0800
Message-ID: <CAN8cciZeXCiptD6MfJg1DZyUeReTEDz+hPVK9jMMnsXJi5uLPQ@mail.gmail.com>
References: <CAN8ccibqYPovEn=M9b-x4ZjqM3U9DwKnJtyDUKGoos-C2WBVXg@mail.gmail.com>
	<4E706E5E.2020602@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 4A137103C37
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Sep 2011 03:10:16 +0200 (CEST)
Received: by fxe22 with SMTP id 22so1206226fxe.38
	for <alsa-devel@alsa-project.org>; Thu, 15 Sep 2011 18:10:16 -0700 (PDT)
In-Reply-To: <4E706E5E.2020602@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/9/14 Clemens Ladisch <clemens@ladisch.de>:
> Raymond Yau wrote:
>> Is 256 frames/period in s16 stereo since the card support mono ,
>> stereo , U8 and S16 ,
>
> The hardware uses S16 stereo at 48 kHz internally; everything else is
> converted and resampled to that.

using ubuntu 11.04 Live CD

After select "Mono Duplex" profile in gnome sound preference  , gnome
speaker-test crash

>
>> What is the meaning of SNDRV_PCM_INFO_BLOCK_TRANSFER
>
> That the card transfers samples in blocks.
>
>> since the rewind_safeguard of PA server is 256 bytes ?
>
> A block in the native format has 1024 bytes.
>

Do you mean hardware pointer is only updated every 5.333ms ?

similar to usb audio using 5 urbs

and this is why the driver force the application to use 3 periods per buffer

>> help since minimum period time of snd_ymfpci is 5.333ms but
>> alsa-pulse plugin announce a lower value 128 bytes (period_bytes_min)
>> to the alsa application ?
>
> Doesn't PA assume that the hardware has accurate pointer positions?
> Without this, smaller periods do not make sense unless PA can
> interpolate from the period interrupts.
>

PA server use the value from snd_pcm_available() to determine the sleep time ,
You have to ask PA developer whether PA can interpolate from the
period interrupts

e.g. hda , emu10k1 and au88x0 use the values from hardware register as
the playback position in pointer callback
