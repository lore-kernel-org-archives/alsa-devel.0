From: ThomasJF <tsepp2001@t-online.de>
Subject: Re: non-blocking mode example
Date: Sun, 13 Aug 2017 13:19:54 +0200
Message-ID: <e6600808-5f98-335f-9b58-bce7b15f6c63@t-online.de>
References: <86b4d23e-d214-ccbc-33b3-4f7d2de9600f@t-online.de>
 <a9bcf062-f4cf-1466-dbfa-90e67148fb13@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout12.t-online.de (mailout12.t-online.de [194.25.134.22])
 by alsa0.perex.cz (Postfix) with ESMTP id A4A1B26693C
 for <alsa-devel@alsa-project.org>; Sun, 13 Aug 2017 13:19:58 +0200 (CEST)
Received: from fwd19.aul.t-online.de (fwd19.aul.t-online.de [172.20.27.65])
 by mailout12.t-online.de (Postfix) with SMTP id EEF6A41C1B7D
 for <alsa-devel@alsa-project.org>; Sun, 13 Aug 2017 13:19:57 +0200 (CEST)
In-Reply-To: <a9bcf062-f4cf-1466-dbfa-90e67148fb13@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks Clemens,

it is really not a small example and an uneven path to go through the 
whole files... But may be you or someone else could answer my short 
questions? I have read a file to buffer with "allframes".

1.) Do I use snd_pcm_writei(...) with a size of "allframes" or loop it 
with smaller packages (periodsize)

2.) What are the actual functions to get the interrupt and send the 
frames needed into the ringbuffer (standard I/O or select)?

If you start with ALSA you will find enough pieces of code. But it is 
not very clear, because many pieces of cake are done with much elder 
APIs from ALSA...

Best regards
Thomas


Am 12.08.2017 um 18:30 schrieb Clemens Ladisch:
> ThomasJF wrote:
>> could anyone please link me to or show me a small demo example, like
>> "pcm_min.c" with working snd_pcm_open in SND_PCM_NONBLOCK - mode?
> alsa-utils/alsaloop, but it's not quite small.
>
>
> Regards,
> Clemens
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
