From: Vladimir Barinov <vova.barinov@gmail.com>
Subject: Re: PLL computation in TLV320AIC3x SoC driver
Date: Wed, 09 Dec 2009 23:35:01 +0300
Message-ID: <4B2009F5.8020107@gmail.com>
References: <alpine.DEB.2.00.0912081127460.22770@hippogriff.cosy.sbg.ac.at>
	<4B1E66C8.4070402@gmail.com>
	<alpine.DEB.2.00.0912081552430.22770@hippogriff.cosy.sbg.ac.at>
	<4B1E74D7.9080400@gmail.com> <4B1E7965.6030000@gmail.com>
	<alpine.DEB.2.00.0912091447230.17383@hippogriff.cosy.sbg.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f223.google.com (mail-ew0-f223.google.com
	[209.85.219.223])
	by alsa0.perex.cz (Postfix) with ESMTP id 0E16D103813
	for <alsa-devel@alsa-project.org>; Wed,  9 Dec 2009 21:35:08 +0100 (CET)
Received: by ewy23 with SMTP id 23so6849727ewy.4
	for <alsa-devel@alsa-project.org>; Wed, 09 Dec 2009 12:35:07 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.0912091447230.17383@hippogriff.cosy.sbg.ac.at>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: vbarinov@embeddedalley.com, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hello Peter,

Peter Meerwald wrote:
> Hello,
>
>   
>>>>>> I'm trying to use the SoC TLV320AIC3x codec driver with sysclk
>>>>>> 16384000 and
>>>>>> ran into some problems with setting PLL; below is a patch against
>>>>>> linux-2.6-asoc
>>>>>>             
>
>   
>>> I just tested your patch works fine with sysclk=16384000 and 12288000 but
>>> fails with 11286900: it returns FSREF=45467 instead of desired 44100. I
>>> think that this is a valuable difference. Please check it.
>>>       
>> Please check  also 33868800  sysclk, it  returns  FSREF=47545 instead of
>> 48000.
>>     
>
> I have put the proposed code at http://pmeerw.net/clk/ for review;
>
>
>   
> note that the proposed code has less deviation from fsref in all cases and 
> manages to stay within recommended settings for sysclk 33868800 
>
> I have modified the following line to get rid of rounding errors as much 
> as possible:
> /* do not use codec_clk here since we'd loose precision */
> d = ((2048 * p * fsref) - j * sysclk) * 100 / (sysclk/100);
> and fixed a bug which always set pll_p = 1 in case d!=0
>
>   
I confirm that it handles all cases with best precision now.
> if code looks good, I'll submit a patch against linux-sound-2.6 as Mark 
> suggested
>
>   
I'm ok to submit.
