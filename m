From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ALSA: ASoc: Add regulator support to
	CS4270 codec driver
Date: Sat, 28 Nov 2009 20:31:02 +0000
Message-ID: <C78B2A7F-3D02-406C-A87B-8C3231456726@opensource.wolfsonmicro.com>
References: <1259159787-21876-1-git-send-email-daniel@caiaq.de>
	<20091125150139.GC636@rakim.wolfsonmicro.main>
	<20091125152052.GM29442@buzzloop.caiaq.de>
	<20091125153804.GA12750@rakim.wolfsonmicro.main>
	<20091126154807.GI14091@buzzloop.caiaq.de>
	<20091126160351.GB10674@rakim.wolfsonmicro.main>
	<20091126174245.GJ14091@buzzloop.caiaq.de>
	<20091127112550.GA29821@rakim.wolfsonmicro.main>
	<20091127124139.GR14091@buzzloop.caiaq.de>
	<20091127133225.GB17711@rakim.wolfsonmicro.main>
	<4B1186B8.6070606@freescale.com>
	(sfid-20091128_202336_242342_24B1ED43)
Mime-Version: 1.0 (iPhone Mail 7D11)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A247324826
	for <alsa-devel@alsa-project.org>; Sat, 28 Nov 2009 21:30:50 +0100 (CET)
In-Reply-To: <4B1186B8.6070606@freescale.com>
	(sfid-20091128_202336_242342_24B1ED43)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 28 Nov 2009, at 20:23, Timur Tabi <timur@freescale.com> wrote:

> Mark Brown wrote:
>> Looks good to me, though I suspect Timur will want error checking for
>> those enable calls - Timur?
>
> Yes, I'd like to see error checking on those calls, but I'm more  
> concerned that I don't see "#ifdef CONFIG_REGULATOR" anywhere in  
> this patch.

The regulator header file handles that -it provides stub versions of  
the core consumer API calls to save all the drivers having to have  
conditional code in them.
