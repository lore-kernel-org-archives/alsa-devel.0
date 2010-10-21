From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Alsamixertest
Date: Thu, 21 Oct 2010 09:50:19 +0200
Message-ID: <4CBFF0BB.5060900@canonical.com>
References: <4C9F6409.6010400@aknet.ru>
	<20100927005858.GD21247@sirena.org.uk>	<4CA0221D.6030208@aknet.ru>
	<i7qltg$bph$1@dough.gmane.org>	<AANLkTi=9gcs0A6s55wSS-RP4NucvUqkxCoYynezdF+5g@mail.gmail.com>	<4CA306CB.1090305@canonical.com>	<AANLkTi=h+ZKXNdhmC1BtTbBaGF6_V+uD2ZO7sx4WMJMW@mail.gmail.com>	<4CA9877F.7060009@canonical.com>
	<4CA9C22A.2010104@ladisch.de>	<4CA9C7BE.7020804@canonical.com>
	<AANLkTinJnCQvQmQL16-pWBhmaZjW1_nUayHVa-yaC3FO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id C0E7D103816
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Oct 2010 09:50:25 +0200 (CEST)
Received: from hutte.canonical.com ([91.189.90.181])
	by adelie.canonical.com with esmtp (Exim 4.69 #1 (Debian))
	id 1P8pum-0007Im-Vb
	for <alsa-devel@alsa-project.org>; Thu, 21 Oct 2010 08:50:21 +0100
Received: from c-83-233-18-148.cust.bredband2.com ([83.233.18.148]
	helo=[192.168.8.102]) by hutte.canonical.com with esmtpsa
	(TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32) (Exim 4.69)
	(envelope-from <david.henningsson@canonical.com>) id 1P8pum-0005Um-SW
	for alsa-devel@alsa-project.org; Thu, 21 Oct 2010 08:50:20 +0100
In-Reply-To: <AANLkTinJnCQvQmQL16-pWBhmaZjW1_nUayHVa-yaC3FO@mail.gmail.com>
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

On 2010-10-21 06:36, Raymond Yau wrote:
> 2010/10/4 David Henningsson<david.henningsson@canonical.com>
>
>>
>>
>> Exactly, this is a test tool that checks whether the mixer control names
>> and dB information live up to PulseAudio's expectations. That's the
>> tool's purpose.
>>
>> What's PulseAudio' s expectation ?
>
> PA 's developer seem expect max_dB of all HDA codec are 0dB
>
> Your alsamixertest program does not test any dB range above 0dB

That's correct, I don't really know how to deal with that, and I'm not 
sure how PA deals with that either. I assume it goes above 0 dB on one 
of the volume controls when a user wants it to.

But from alsamixertest's perspective, the question is: if you do, should 
detected distortion cause an error or not?

Also alsamixertest could be expanded to trust playback and test 
recording, and then I assume this question will be even more important 
as most mic boost controls go from 0 dB to +20 dB or so (if they even 
provide dB information).

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
