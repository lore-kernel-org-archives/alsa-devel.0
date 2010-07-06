From: Smilen Dimitrov <sd@imi.aau.dk>
Subject: Re: Help with dummy.c (where/how to write?)
Date: Tue, 06 Jul 2010 06:46:49 +0200
Message-ID: <4C32B539.30801@imi.aau.dk>
References: <4C3244B6.6080409@imi.aau.dk> <4C32518B.6000505@audioscience.com>
Reply-To: sd@imi.aau.dk
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mho-02-ewr.mailhop.org (mho-02-ewr.mailhop.org [204.13.248.72])
	by alsa0.perex.cz (Postfix) with ESMTP id 48E9B24472
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Jul 2010 06:47:01 +0200 (CEST)
In-Reply-To: <4C32518B.6000505@audioscience.com>
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
Cc: Eliot Blennerhassett <eblennerhassett@audioscience.com>
List-Id: alsa-devel@alsa-project.org


Hi Eliot,

Thanks so much for your response:

>>
>> I am trying to work on dummy.c:
>>
>> http://lxr.linux.no/#linux+v2.6.32/sound/drivers/dummy.c
>>
>> as an exercise, and I'd like to modify it so it behaves as an
>> 'oscillator'; [snip]
>>
>
> You are better to look at the loopback driver in alsa-driver repo:
>
> http://git.alsa-project.org/?p=alsa-driver.git;a=blob_plain;f=drivers/aloop-kernel.c;hb=HEAD
>
> You would put your generation code in clear_capture_buf()
>


Fantastic info - that is exactly what I needed :)

(Don't know why your response hasn't shown in the alsa-devel archives 
yet, hopefully my reply will bump it up there)

Cheers!
