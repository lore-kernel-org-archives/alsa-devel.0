From: ThomasJF <tsepp2001@t-online.de>
Subject: Re: non-blocking mode example
Date: Thu, 17 Aug 2017 18:47:06 +0200
Message-ID: <e19ddc02-4098-2036-1959-8ec82cd4e31e@t-online.de>
References: <86b4d23e-d214-ccbc-33b3-4f7d2de9600f@t-online.de>
 <a9bcf062-f4cf-1466-dbfa-90e67148fb13@ladisch.de>
 <e6600808-5f98-335f-9b58-bce7b15f6c63@t-online.de>
 <693e0d31-9b74-3ccf-e4a5-aac3b94ee4da@ladisch.de>
 <2a3cecc4-730c-208b-0674-68bbbe5d72d4@t-online.de>
 <f811f743-3433-2b1a-f932-677290d5d562@ladisch.de>
 <a0bfdc84-d5d3-3d0f-7113-ad95440e9f3d@t-online.de>
 <c2b0d797-0cb4-6592-5a2f-f7661b0871fb@ladisch.de>
 <c57a7ec3-a69b-342e-759c-049a98abc14a@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout10.t-online.de (mailout10.t-online.de [194.25.134.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 123DA266F7E
 for <alsa-devel@alsa-project.org>; Thu, 17 Aug 2017 18:47:16 +0200 (CEST)
Received: from fwd26.aul.t-online.de (fwd26.aul.t-online.de [172.20.26.131])
 by mailout10.t-online.de (Postfix) with SMTP id 75D1741FD607
 for <alsa-devel@alsa-project.org>; Thu, 17 Aug 2017 18:47:16 +0200 (CEST)
In-Reply-To: <c57a7ec3-a69b-342e-759c-049a98abc14a@t-online.de>
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

If I use a higher timeout than 0 with poll, the stream starts without 
snd_pcm_wait().

Now I get these snd_pcm_writei errors:

stop: File descriptor in bad state
pause: ok
play (after pause): Resource temporarily unavailable

Regards
Thomas


Am 17.08.2017 um 18:03 schrieb ThomasJF:
> Without snd_pcm_wait() I get an open error (Device or resource busy).
>
> In short I have inside the loop:
>
> poll(ufds, 2, 0);
> snd_pcm_wait()
> snd_pcm_writei(...)
>
> Regards
> Thomas
>
>
> Am 17.08.2017 um 16:48 schrieb Clemens Ladisch:
>> ThomasJF wrote:
>>> now it is working with poll and the two fds. Also pause, play and stop.
>>>
>>> If it stops, the snd_pcm_wait in my loop returns a negative error code
>> Why are you calling snd_pcm_wait() when you already have poll()?
>>
>>
>> Regards,
>> Clemens
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
