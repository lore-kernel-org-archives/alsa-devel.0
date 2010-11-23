From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ALSA throwing buffers away?
Date: Tue, 23 Nov 2010 18:03:01 +0100
Message-ID: <4CEBF3C5.2050108@ladisch.de>
References: <AANLkTikppY6oP0Ha7_Hej9uNBubbOUs87cp85yq3SS-X@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id B697F10392C
	for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2010 18:00:45 +0100 (CET)
In-Reply-To: <AANLkTikppY6oP0Ha7_Hej9uNBubbOUs87cp85yq3SS-X@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Radivoje Jovanovic <radivojejovanovic@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Radivoje Jovanovic wrote:
> I am developing driver for a really simple hardware. Hardware has codec that
> supports mono/stereo and the amplifier that supports only one speaker so the
> driver has to be mono driver and the codec is setup to manage mono data. I
> have setup ALSA with following parameters:
> 
> .info =            (SNDRV_PCM_INFO_NONINTERLEAVED |

Better use SNDRV_PCM_INFO_INTERLEAVED; this is the format used by almost
all (stereo) sound cards, and so it is expected even for mono files
(where there actually isn't any difference).

> after each buffer iteration ALSA skips the buffer length of the data?!

This might be a problem with the reporting of the DMA pointer.

Please explain (or show) how your DMA works and how the pointer callback
is implemented.

> I have tried SNDRV_PCM_INFO_INTERLEAVED with the same results (in this
> case ALSA will not even try to play stereo files using my mono driver).

When using the "default" or "plughw" device, alsa-lib will automatically
convert the sample format.


Regards,
Clemens
