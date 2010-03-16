From: ANISH KUMAR <anish.singh@samsung.com>
Subject: Re: underrun problem when short audio play
Date: Tue, 16 Mar 2010 13:47:24 +0000 (GMT)
Message-ID: <25286648.826511268747244139.JavaMail.weblogic@epml03>
Reply-To: anish.singh@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	by alsa0.perex.cz (Postfix) with ESMTP id 22AFB243E7
	for <alsa-devel@alsa-project.org>; Tue, 16 Mar 2010 14:47:28 +0100 (CET)
Received: from ep_ms13_bk (mailout2.samsung.com [203.254.224.25])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KZD00HJTNN18V@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Tue, 16 Mar 2010 22:47:25 +0900 (KST)
Received: from ep_spt03 (ms13.samsung.com [203.254.225.109])
	by ms13.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTP id <0KZD00FN8NN0SV@ms13.samsung.com> for
	alsa-devel@alsa-project.org; Tue, 16 Mar 2010 22:47:24 +0900 (KST)
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
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: MAHAMMADRAFI MANIYAR <maniyar@samsung.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>Are you sure that the 
>drivers you are using implement suspend and resume at all?  
I am using s3c6410 code.I2S driver has suspend/resume call(jassi brar maintained).
Audio codec is also having generic code for suspend/resume but don't know if that is
the problem or not.However how can i verify if my codec suspend/resume has got some 
problem?Most likely my codec has got some configuration problems but i am not getting 
any pointers to debug it.Any pointers in this direction would be very helpful.
