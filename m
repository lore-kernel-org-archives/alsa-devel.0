From: "Cai, Cliff" <Cliff.Cai@analog.com>
Subject: Re: [PATCH 3/5] ASoC: Blackfin: tweak howweinitialize
	the SPORT
Date: Mon, 8 Jun 2009 10:14:12 +0800
Message-ID: <0F1B54C89D5F954D8535DB252AF412FA04292614@chinexm1.ad.analog.com>
References: <1243916337-29953-1-git-send-email-vapier@gentoo.org>
	<1243916337-29953-3-git-send-email-vapier@gentoo.org>
	<20090603102918.GA32595@rakim.wolfsonmicro.main>
	<0F1B54C89D5F954D8535DB252AF412FA042577ED@chinexm1.ad.analog.com>
	<20090604105127.GA11496@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nwd2mail11.analog.com (nwd2mail11.analog.com [137.71.25.57])
	by alsa0.perex.cz (Postfix) with ESMTP id 8FFDF24486
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Jun 2009 04:10:39 +0200 (CEST)
Content-Class: urn:content-classes:message
In-Reply-To: <20090604105127.GA11496@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Mike Frysinger <vapier@gentoo.org>
List-Id: alsa-devel@alsa-project.org

 

>-----Original Message-----
>From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com] 
>Sent: Thursday, June 04, 2009 6:51 PM
>To: Cai, Cliff
>Cc: Mike Frysinger; uclinux-dist-devel@blackfin.uclinux.org; 
>alsa-devel@alsa-project.org
>Subject: Re: [alsa-devel] [PATCH 3/5] ASoC: Blackfin: tweak 
>howweinitialize the SPORT
>
>On Thu, Jun 04, 2009 at 10:36:48AM +0800, Cai, Cliff wrote:
>
>> This is not a problem of rate but format,I think combine the 
>two flags 
>> will solve all the problems.
>
>Ah, yes - I was remembering the ssm2602 driver which does do 
>rate constraints.
>
>> The reason I write this patch is that I found when some oss-based 
>> applications open soundcard ,the startup callbacks will be called 
>> several times.
>
>All OSS applications do this, OSS has a separate ioctl for 
>each configuration option so you get lots of configuration calls.
>
>> So using the counter to record opened pcm streams is not reliable.
>
>It's only hw_params() that get called repeatedly.
>
>I could be wrong but looking at the code I suspect you may 
>just need to make the reconfiguration conditional on if it's a 
>capture or playback stream and you'll be fine - at the minute 
>you're configuring both RX and TX on every hw_params() but 
>there are separate tcr2 and rcr2 registers that you write to.  
>If you only wrote to the appropriate one then you wouldn't 
>need to worry about interfering with another stream for that 
>configuration.  There is the wdsize parameter for the SPORT as 
>well but a brief glance at the code for that suggests that 
>there are actually separate RX and TX configurations there too.
>
>If not then adding constraint code would help a lot.

Yes,if RX and TX can be configured separately ,it would be much
easier...
But for full-duplex consideration,we now don't run RX and TX
independently,
I've tested the combining of "counter" and "configured" together to
sovle the problem
You mentioned by clearing "configured" when counter is 0.Once blackfin
tree has been
Updated to the head I will send you the patch.

Thanks a lot!

Cliff
