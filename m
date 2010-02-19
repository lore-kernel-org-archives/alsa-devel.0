From: jassi brar <jassisinghbrar@gmail.com>
Subject: Re: Separate dma driver for cpu_dais
Date: Fri, 19 Feb 2010 18:48:58 +0900
Message-ID: <1b68c6791002190148v49678625re4fbd4127eed6ec9@mail.gmail.com>
References: <1b68c6791002161839q705df04cmeda046736948c614@mail.gmail.com>
	<1b68c6791002170415q457d0893jb1a77b864031ee6c@mail.gmail.com>
	<20100217131421.GB11510@rakim.wolfsonmicro.main>
	<1b68c6791002171814k28fccf9emcbcf17c54c445a4f@mail.gmail.com>
	<20100218093459.GB3315@rakim.wolfsonmicro.main>
	<1b68c6791002180142l422a9203se2a71cae5795d6a9@mail.gmail.com>
	<20100218095249.GE3315@rakim.wolfsonmicro.main>
	<1b68c6791002180232p6cd86811sc78699ac87236015@mail.gmail.com>
	<20100218105750.GB3542@rakim.wolfsonmicro.main>
	<1b68c6791002180359k65381c09t143d37ec5eef1cf8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id A3195103947
	for <alsa-devel@alsa-project.org>; Fri, 19 Feb 2010 10:49:00 +0100 (CET)
Received: by vws17 with SMTP id 17so245589vws.38
	for <alsa-devel@alsa-project.org>; Fri, 19 Feb 2010 01:48:58 -0800 (PST)
In-Reply-To: <1b68c6791002180359k65381c09t143d37ec5eef1cf8@mail.gmail.com>
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
Cc: kyungmin.park@samsung.com, alsa-devel@alsa-project.org, Joonyoung Shim <jy0922.shim@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 18, 2010 at 8:59 PM, jassi brar
> On Thu, Feb 18, 2010 at 7:57 PM, Mark Brown
>
>> The bits of that patch that make active a reference counter look good at
>> first glance, could you please pull them out and submit them?
> Sure I can, though I think of a few more checks to place in the code.
> Will submit tomorrow from workplace.
I was stuck with some other tasks today, I will send it next week.
Today later I will submit patches for discarding 'runtime' parameter
from snd_soc_dai, though.
