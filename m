From: ANISH KUMAR <anish.singh@samsung.com>
Subject: Re: No shutdown code in soc-core.c
Date: Mon, 19 Apr 2010 13:19:17 +0000 (GMT)
Message-ID: <11864963.186471271683156859.JavaMail.weblogic@epml11>
Reply-To: anish.singh@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	by alsa0.perex.cz (Postfix) with ESMTP id 2840524717
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Apr 2010 15:19:20 +0200 (CEST)
Received: from ep_ms13_bk (mailout2.samsung.com [203.254.224.25])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0L14004PFL0426@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Mon, 19 Apr 2010 22:19:16 +0900 (KST)
Received: from ep_spt02 (ms13.samsung.com [203.254.225.109])
	by ms13.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTP id <0L1400MCLL04MM@ms13.samsung.com> for
	alsa-devel@alsa-project.org; Mon, 19 Apr 2010 22:19:17 +0900 (KST)
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
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: "liam.girdwood@wolfsonmicro.com" <liam.girdwood@wolfsonmicro.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org


>Did you see Mark's reply on dev_pm_ops ? 

>i.e. 

>static const struct dev_pm_ops soc_pm_ops = { 
>   .suspend = soc_suspend, 
>    .resume = soc_resume, 
>   .poweroff = soc_poweroff, 
>};
 
 I missed out Mark reply.However i checked now  this structure is 
 not there in my code base.As i mentioned in my previous mail 
 the flow of events when restart takes place.
 Anyway i thought something is amiss in this struct platform_driver soc_driver 
 that is why i am mailing to the experts here otherwise my
 problem is fixed by having the code as mentioned in my previous 
 mail.
I just wanted to know the reason?Or Am i missing something probably the concept
of turning off the audio driver??
Kerenl version used: 2.6.29

Regards,
anish
