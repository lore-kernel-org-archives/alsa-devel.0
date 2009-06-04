From: "Cai, Cliff" <Cliff.Cai@analog.com>
Subject: Re: [PATCH 3/5] ASoC: Blackfin: tweak how weinitialize
	the SPORT
Date: Thu, 4 Jun 2009 10:36:48 +0800
Message-ID: <0F1B54C89D5F954D8535DB252AF412FA042577ED@chinexm1.ad.analog.com>
References: <1243916337-29953-1-git-send-email-vapier@gentoo.org>
	<1243916337-29953-3-git-send-email-vapier@gentoo.org>
	<20090603102918.GA32595@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nwd2mail10.analog.com (nwd2mail10.analog.com [137.71.25.55])
	by alsa0.perex.cz (Postfix) with ESMTP id 77D36103801
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Jun 2009 04:33:20 +0200 (CEST)
Content-Class: urn:content-classes:message
In-Reply-To: <20090603102918.GA32595@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Mike Frysinger <vapier@gentoo.org>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

 

>-----Original Message-----
>From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com] 
>Sent: Wednesday, June 03, 2009 6:29 PM
>To: Mike Frysinger
>Cc: alsa-devel@alsa-project.org; 
>uclinux-dist-devel@blackfin.uclinux.org; Cai, Cliff
>Subject: Re: [alsa-devel] [PATCH 3/5] ASoC: Blackfin: tweak 
>how weinitialize the SPORT
>
>On Tue, Jun 02, 2009 at 12:18:55AM -0400, Mike Frysinger wrote:
>
>> @@ -199,7 +190,7 @@ static void bf5xx_i2s_shutdown(struct 
>snd_pcm_substream *substream,
>>  			       struct snd_soc_dai *dai)
>>  {
>>  	pr_debug("%s enter\n", __func__);
>> -	bf5xx_i2s.counter--;
>> +	bf5xx_i2s.configured = 0;
>>  }
>
>Are you sure this works properly with simultaneous record and playback?
>If one stops while the other is running then the configured 
>flag will be cleared, meaning that the stopped stream can be 
>restarted and used to reconfigure the DAI which appears to be 
>what the code is trying to prevent.
>
>This should be using constraints to stop applications trying 
>to reconfigure active streams - for the sample rate you just 
>need to set symmetric_rates in the DAI.
>


This is not a problem of rate but format,I think combine the two flags
will solve all the problems.
The reason I write this patch is that I found when some oss-based
applications open soundcard ,the startup callbacks will be called
several times.
So using the counter to record opened pcm streams is not reliable.

Thanks

Cliff 
