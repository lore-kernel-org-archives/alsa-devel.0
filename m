From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Selecting Audio formats
Date: Thu, 19 Jul 2012 20:35:36 +0200
Message-ID: <50085378.5000300@ladisch.de>
References: <CAA4JwzUwL=nkwcpJa62i9nLW8MOZ3mcj696-53V3R-wbdkbnnA@mail.gmail.com>	<500820F3.4050302@ladisch.de>
 <CAA4JwzW3zNOCWeFoaCSxnx8WzsQTbu1+rOuq2jFxdt043MWSaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id DE617260305
 for <alsa-devel@alsa-project.org>; Thu, 19 Jul 2012 20:36:25 +0200 (CEST)
In-Reply-To: <CAA4JwzW3zNOCWeFoaCSxnx8WzsQTbu1+rOuq2jFxdt043MWSaQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Harman Kalra <harman4linux@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Harman Kalra wrote:
>     Can you please explain difference between signed and unsigned PCM
> formats,

Signed PCM formats have a sign, unsigned don't.  S16 allows values in the
range -32768..32767, U16, 0..65535.

> in what cases does unsigned is used,

In practice, never.  It was historically used by some 8-bit cards.

> which is more efficient (memory and sound clarity)

I refer the honourable gentleman to the reply I gave in the last mail.

>> If you tried to set MPEG format, ALSA would inform you that the device
>> does not support this.
>
>         But when I queried the hardware regarding the supported audio
> formats using the api " snd_pcm_format_name", it responded with a list of
> formats, including , A-law, u-law-, IMA_ADPCM, MPEG, GSM, so what does it
> mean.

It means that the sample format identified by the constant
SND_PCM_FORMAT_MPEG is indeed named "MPEG".  This has nothing to do
with what formats some particular hardware supports.

>       What would be audio sample file size in case of A-law, will it be
> same as U8.

I refer the honourable gentleman to the reply I gave in the last mail.


Regards,
Clemens
