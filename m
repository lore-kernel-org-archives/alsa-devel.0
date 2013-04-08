From: Jonas Petersen <jnsptrsn1@gmail.com>
Subject: Re: M-Audio Delta 1010LT: S/PDIF clock source not
	working
Date: Tue, 09 Apr 2013 00:56:23 +0200
Message-ID: <51634B17.3050907@gmail.com>
References: <515EEF10.1020007@gmail.com> <5160C35A.8020403@gmail.com>
 <5161A6D3.3060602@gmail.com> <201304072135.45811.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f53.google.com (mail-bk0-f53.google.com
 [209.85.214.53])
 by alsa0.perex.cz (Postfix) with ESMTP id D4828265D19
 for <alsa-devel@alsa-project.org>; Tue,  9 Apr 2013 00:56:30 +0200 (CEST)
Received: by mail-bk0-f53.google.com with SMTP id e19so3299734bku.40
 for <alsa-devel@alsa-project.org>; Mon, 08 Apr 2013 15:56:28 -0700 (PDT)
In-Reply-To: <201304072135.45811.gineera@aspect135.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alan Horstmann <gineera@aspect135.co.uk>
Cc: alsa-devel@alsa-project.org, "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
List-Id: alsa-devel@alsa-project.org

Am 07.04.2013 22:35, schrieb Alan Horstmann:
> On Sunday 07 April 2013 18:03, Gabriel M. Beddingfield wrote:
>> On 04/06/2013 05:52 PM, Jonas Petersen wrote:
>>> It seems it's related to the ICE1712... I now tried the Audiophile 2496.
>>> Same behaviour! There is no way to clock from external (S/PDIF). The
>>> 'Multi Track Internal Clock Default' setting will always override the
>>> external clock rate and mess up the capturing.
>> Well, it /should/ work -- according to the 1010's manual.  I'll bet it's
>> some register setting that's missing on the ice1712 -- but I have no
>> access to the specs/datasheets/schematics on these things.
>>
>> I wonder -- did this ever work on Linux?

Yes! I while ago I was doing stuff with the Delta 66 and things were 
fine. That was back with Ubuntu 10.04 and Alsa 1.0.22 and also 1.0.23.
I just grabbed an old Ubuntu 10.04 ISO which contains Alsa 1.0.22 and 
live booted it on my machine. Tests show that it's working as expected 
with the 1010LT: It's properly externally clocked.


> However I do seem to remember some relatively recent changes related 
> to external wordclock on the 1010; maybe it has been broken?

I found commit b8b1a4cb6842fb33769be1ad636f062d31d588c3 from Jan 17 
23:20:03 2011. It's a patch on delta.c and it's regarding a clock issue 
(though not exactly wordclock). I reverted that patch and recompiled but 
no success.

I'm going to continue later on that topic. At least there must have been 
some change that broke it since 1.0.23.

> @Jonas - are you using 'envy24control' to toggle the settings?

I suppose this shouldn't make any difference. I'm using alsamixer, 
amixer and API calls most of the time. Sometimes envy24control, mostly 
for (visual) input feedback. Tried only using envy24control, but didn't 
make any difference.

- Jonas
