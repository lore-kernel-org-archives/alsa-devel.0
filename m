From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] ASoC: SAMSUNG: Add Aquila sound driver
Date: Mon, 12 Jul 2010 16:23:57 +0900
Message-ID: <4C3AC30D.2000107@samsung.com>
References: <4C355AC2.8090502@samsung.com>
	<20100708070549.GA29850@opensource.wolfsonmicro.com>
	<4C368794.2040600@samsung.com>
	<20100709024215.GA13944@opensource.wolfsonmicro.com>
	<4C369DA7.6070902@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	by alsa0.perex.cz (Postfix) with ESMTP id 60357103818
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Jul 2010 09:24:00 +0200 (CEST)
Received: from epmmp2 (mailout3.samsung.com [203.254.224.33])
	by mailout3.samsung.com
	(Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12
	2010)) with ESMTP id <0L5F00I73OJXS5A0@mailout3.samsung.com> for
	alsa-devel@alsa-project.org; Mon, 12 Jul 2010 16:23:57 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0L5F00HNEOJXKV@mmp2.samsung.com> for
	alsa-devel@alsa-project.org; Mon, 12 Jul 2010 16:23:57 +0900 (KST)
In-reply-to: <4C369DA7.6070902@samsung.com>
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
Cc: alsa-devel@alsa-project.org, Joonyoung Shim <jy0922.shim@samsung.com>, Jassi Brar <jassisinghbrar@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Dear Mark,

Liam reviewed this patch.(Thank you for your review.)

The upstream kernel include i2s CPU drivers excepts for i2sv5 CPU driver.
I should upgrade existing i2s CPU drivers to support i2s operation 
for sound on Aquila board, becuase the sound driver on Aquila board
to need i2sv5 CPU driver.

I have a question.

After upgrading existing i2s CPU drivers to run sound on Aquila board,
Should I post this patch to upstream kernel?
Or,
Now, I post this patch which haven't used i2sv5 CPU driver to upstream kernel.
Then, I will implement it and post incremental patch using it to run
on Aquila board.

Could you give me the opinion about this question?

Thank you,
Chanwoo Choi
