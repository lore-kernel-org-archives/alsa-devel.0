From: Karl Beldan <karl.beldan@gmail.com>
Subject: Re: [Uclinux-dist-devel] [PATCH 2/5] ASoC codec:
 SSM2602: assign last substream to the master when shutting down
Date: Thu, 04 Jun 2009 10:17:02 +0200
Message-ID: <4A2782FE.3080103@gmail.com>
References: <1243916337-29953-1-git-send-email-vapier@gentoo.org>	<1243916337-29953-2-git-send-email-vapier@gentoo.org>	<20090603105223.GE11507@sirena.org.uk>	<8bd0f97a0906030537y1e65aa7atec4b0c5cdf4ae2f@mail.gmail.com>	<20090603145316.GA7315@rakim.wolfsonmicro.main>
	<8bd0f97a0906031826j647efa0bs1ffb6492cfd0ccd8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f223.google.com (mail-ew0-f223.google.com
	[209.85.219.223])
	by alsa0.perex.cz (Postfix) with ESMTP id 6DBE22443F
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Jun 2009 10:16:41 +0200 (CEST)
Received: by ewy23 with SMTP id 23so821335ewy.32
	for <alsa-devel@alsa-project.org>; Thu, 04 Jun 2009 01:16:40 -0700 (PDT)
In-Reply-To: <8bd0f97a0906031826j647efa0bs1ffb6492cfd0ccd8@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

Mike Frysinger wrote:
> On Wed, Jun 3, 2009 at 10:53, Mark Brown wrote:
>> On Wed, Jun 03, 2009 at 08:37:54AM -0400, Mike Frysinger wrote:
>>> On Wed, Jun 3, 2009 at 06:52, Mark Brown wrote:
>>>> However, given that this fix has missed two kernel releases due to the
>>>> very slow rate of responses to review comments I've applied it so users
>>>> get the benefit of the bug fix.
>>> not sure what you're referring to
>> This looks like a respin of a fix which was originally submitted back in
>> 2.6.29 era or so.  IIRC there's been two or three versions, each of
>> which needed fixes.
> 
> it could be.  i was going by the changes that werent in 2.6.30.  i
> thought i looked for previous submissions, but i must have missed
> previous attempts.  i'm not familiar with alsa stuff, so i'm not
> always sure when i need to bang on Cliff to get things fixed up
> (changes split / better comments / etc...).
> 

Anyways, this commit has been trying to fix something already fixed since the
first submission and if you look at its effect on the current tree you will see
duplicate code.

-- 
Karl
