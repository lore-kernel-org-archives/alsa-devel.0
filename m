From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [REPOST] opti93x: conversion to use cs4231 library
Date: Thu, 07 Feb 2008 01:09:56 +0100
Message-ID: <47AA4C54.80305@keyaccess.nl>
References: <20080126104411.50c2035f.krzysztof.h1@poczta.fm>
	<s5hd4rl6f4h.wl%tiwai@suse.de> <479E804E.7070500@keyaccess.nl>
	<479FC816.5060405@keyaccess.nl> <47AA49AB.4060802@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl
	[213.51.146.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 542B82444C
	for <alsa-devel@alsa-project.org>; Thu,  7 Feb 2008 01:08:46 +0100 (CET)
In-Reply-To: <47AA49AB.4060802@keyaccess.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-devel <alsa-devel@alsa-project.org>, Krzysztof Helt <krzysztof.h1@poczta.fm>, Massimo Piccioni <alsa@piccio.org>
List-Id: alsa-devel@alsa-project.org

On 07-02-08 00:58, Rene Herman wrote:

> On 30-01-08 01:43, Rene Herman wrote:
> 
>> 931 and 933 work and 930 (a non-PnP chip) is being a royal pain in the 
>> ass again. With the new code, I haven't yet been able to get it to 
>> work -- no IRQ is firing. However, I also experienced this _once_ with 
>> the old driver so I'm not sure what's going on. When I now try to 
>> reproduce with the old one, I can't. Maybe a timing difference.
>>
>> Will need further testing -- I have no time in the next few days.
> 
> Hate it but will need to confirm that this is definitely a regression. OPTi
> 82C930A does not work with the cs4231-lib using driver, does work with the
> current driver. It loads, but gets no interrupts.
> 
> However, relevant -- "does work with the old driver" is conditional on 
> one accepting a definition of "does work" which includes "does not 
> produce any sound". OPTi 930 is a Non-PnP chip, and it seems it might 
> need the same kind of internal switching that the Non-PnP sound galaxies 
> need before the output circuitry is actually connected to the WSS part 
> and not the SB part.

(oh, by the way, that's not a hardware problem -- work fine under DOS)

> Given that for most people sound cards have producing sound as one of 
> their more important characteristics it not in fact doing such no doubt 
> means that this chip isn't used at _all_ by anyone. I have one, but I 
> can't say I've ever found another one either. Could've sworn I tested it 
> before and got it to work but not able to say with certainty either.
> 
> Massimo, do you remember if the driver was ever tested on a 930?
> 
> In any case, it works on 931 and 933, not 930. 931/3 are the chips 
> actually used. No opinion on just integrating this anyway. Debugging 930 
> is going to require some work and time.

Rene.
