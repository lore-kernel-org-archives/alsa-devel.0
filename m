From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: how to mandate the use of PCM plugin?
Date: Wed, 29 Sep 2010 11:28:43 +0200
Message-ID: <4CA306CB.1090305@canonical.com>
References: <4C9F6409.6010400@aknet.ru>
	<20100927005858.GD21247@sirena.org.uk>	<4CA0221D.6030208@aknet.ru>
	<i7qltg$bph$1@dough.gmane.org>
	<AANLkTi=9gcs0A6s55wSS-RP4NucvUqkxCoYynezdF+5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 79A231037F7
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Sep 2010 11:28:46 +0200 (CEST)
Received: from hutte.canonical.com ([91.189.90.181])
	by adelie.canonical.com with esmtp (Exim 4.69 #1 (Debian))
	id 1P0sxx-0001WK-1e
	for <alsa-devel@alsa-project.org>; Wed, 29 Sep 2010 10:28:45 +0100
Received: from c-83-233-18-148.cust.bredband2.com ([83.233.18.148]
	helo=[192.168.8.102]) by hutte.canonical.com with esmtpsa
	(TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32) (Exim 4.69)
	(envelope-from <david.henningsson@canonical.com>) id 1P0sxw-0008GG-Ut
	for alsa-devel@alsa-project.org; Wed, 29 Sep 2010 10:28:45 +0100
In-Reply-To: <AANLkTi=9gcs0A6s55wSS-RP4NucvUqkxCoYynezdF+5g@mail.gmail.com>
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
List-Id: alsa-devel@alsa-project.org

On 2010-09-28 06:07, Raymond Yau wrote:
> 2010/9/28 Colin Guthrie<gmane@colin.guthr.ie>
>
>>
>>
>> And today, one of the Canonical guys published his version of a tool to
>> help here:
>> http://thread.gmane.org/gmane.comp.audio.pulseaudio.general/7542
>>
>> Hope this helps.
>>
>> Col
>>
>>
>>
> why did runtest.sh use a format  FLOAT64_LE which was not supported by PA ?

runtest.sh isn't meant to be used directly in that way, you're supposed 
to run "alsamixertest". Try "alsamixertest -r" and "alsamixertest -h" to 
get started. (Perhaps I should rename the .sh file to something else.)

That said, if you find a good use case where you want to use it directly 
and need a different sample format - patches welcome (as long as they 
don't break something else).

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
