From: =?windows-1252?Q?Sune_M=F8lgaard?= <sune@molgaard.org>
Subject: Re: Noise on snd-hda-intel
Date: Fri, 24 Jun 2011 10:41:49 +0200
Message-ID: <4E044DCD.4040800@molgaard.org>
References: <4E00F373.6050001@molgaard.org> <4E00F41E.5090303@molgaard.org>
	<1308691120.6844.1.camel@mattotaupa>
	<4E01A8FA.8060709@molgaard.org> <s5hr56m1923.wl%tiwai@suse.de>
	<4E022AA4.5060802@molgaard.org>
	<BANLkTimZHrRz-cjx3kJJziCeqaJtfiF8YA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.fullrate.dk (smtp.fullrate.dk [90.185.1.42])
	by alsa0.perex.cz (Postfix) with ESMTP id 97359249C7
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Jun 2011 10:41:50 +0200 (CEST)
Received: from [10.0.0.2] (1407ds3-arsy.0.fullrate.dk [95.166.154.201])
	by smtp.fullrate.dk (Postfix) with ESMTP id B5DEF9D21A
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Jun 2011 10:41:51 +0200 (CEST)
In-Reply-To: <BANLkTimZHrRz-cjx3kJJziCeqaJtfiF8YA@mail.gmail.com>
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

Sorry for mailing in private. I'm used to lists that set Reply-to to the 
list :-$

Raymond Yau wrote:
> Does the noise appear when you increase  "Front Mic Boost" control
> from 0dB to 30 dB ?
>
> arecord -v -f CD -Dhw:CARD=Intel | aplay -v -Dhw:CARD=Intel

Those commands give

aplay: main:660: audio open error: Device or resource busy

and thus no sound. I have played around with Front Mic Boost, though - 
it doesn't seem to alter the level of noise.

/sune

-- 
Anybody who thinks a little 9,000-line program that's distributed free
and can be cloned by anyone is going to affect anything we do at
Microsoft has his head screwed on wrong.
-Bill Gates, on Java
