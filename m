From: Ludovico Cavedon <ludovico.cavedon@gmail.com>
Subject: Re: 0 or EAGAIN from snd_pcm_update_avail()?
Date: Sat, 4 Apr 2009 19:39:44 -0700
Message-ID: <7337540c0904041939l281cdd3bkac4912171f454b9d@mail.gmail.com>
References: <7337540c0904022320s2b40bf79r2ad00bd80569ffba@mail.gmail.com>
	<alpine.LNX.2.00.0904030901390.17368@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 543521037FD
	for <alsa-devel@alsa-project.org>;
	Sun,  5 Apr 2009 04:39:45 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id k40so847383wah.16
	for <alsa-devel@alsa-project.org>; Sat, 04 Apr 2009 19:39:44 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.0904030901390.17368@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 3, 2009 at 12:04 AM, Jaroslav Kysela <perex@perex.cz> wrote:
> On Thu, 2 Apr 2009, Ludovico Cavedon wrote:
>> if snd_pcm_update_avail() gets called on a PCM device in non-blocking
>> mode when no data is availabe jet, what is the expected return value?
>> -0
>> -EAGAIN
>> -either is valid
>>
>> I am asking this question because pulseaudio expect to receive 0, but
>> the the bluetooth headset pcm transfer callback returns EAGAIN, so I
>> want to find out against whoms I should open a bug :)
>
> 0.
>
> -EAGAIN should be returned only for R/W operations but not for buffer
> position routines. They should return always immediatelly with useable value
> (thus EAGAIN does not make sense).

I see.
But is it correct for the ioplug module to call the transfer callback
when snd_pcm_avail_update() is invoked?

Thanks,
Ludovico
