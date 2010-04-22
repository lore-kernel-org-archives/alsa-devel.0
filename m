From: ANISH KUMAR <anish.singh@samsung.com>
Subject: Re: No shutdown code in soc-core.c
Date: Thu, 22 Apr 2010 08:10:31 +0000 (GMT)
Message-ID: <27549835.342171271923831455.JavaMail.weblogic@epml11>
Reply-To: anish.singh@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	by alsa0.perex.cz (Postfix) with ESMTP id BFC82103803
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Apr 2010 10:12:26 +0200 (CEST)
Received: from ep_ms13_bk (mailout1.samsung.com [203.254.224.24])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0L1900D0CQPJKA@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Thu, 22 Apr 2010 17:10:31 +0900 (KST)
Received: from ep_spt04 (ms13.samsung.com [203.254.225.109])
	by ms13.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTP id <0L1900BCUQPJI4@ms13.samsung.com> for
	alsa-devel@alsa-project.org; Thu, 22 Apr 2010 17:10:31 +0900 (KST)
Content-return: prohibited
MIME-version: 1.0
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
Cc: "liam.girdwood@wolfsonmicro.com" <liam.girdwood@wolfsonmicro.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


Thanks everyone for the replies but i think for this trivial problem
i don't need to backport the kernel.Anyway now i know the answer
for my posted question.I have kept backporting as an excersie
as my assignment which i will do in due period of time.

 
 

------- Original Message-------
Sender: Mark Brown<broonie@opensource.wolfsonmicro.com>
Date: Apr 20, 2010 01:59 (GMT+09:00)
Title: Re: [alsa-devel] No shutdown code in soc-core.c

On Mon, Apr 19, 2010 at 03:10:55PM +0100, Liam Girdwood wrote: 

> Ah, your kernel is very old. I would just do what you are currently 
> doing with shutdown and use the dev_pm_ops when you upgrade your kernel. 

Actually, IME it's probably as easy to just backport current ASoC to 
2.6.29 if you're doing anything non-trivial - the backport is very 
straightforward for most platforms and the benefits of the enhancements 
in ASoC are well worth the effort. 
