From: Sangbeom Kim <sbkim73@samsung.com>
Subject: Re: [PATCH] ASoC: Ensure we delay long enough for
	WM8994	FLL to lock when starting
Date: Mon, 04 Jul 2011 08:59:45 +0900
Message-ID: <032501cc39dd$489c24d0$d9d46e70$@com>
References: <1309566922-3177-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 74ECA24B6F
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Jul 2011 01:59:50 +0200 (CEST)
Received: from epcpsbgm2.samsung.com (mailout1.samsung.com [203.254.224.24])
	by mailout1.samsung.com
	(Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built
	Sep 7
	2010)) with ESMTP id <0LNS00L467YV6UC0@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Mon, 04 Jul 2011 08:59:45 +0900 (KST)
Received: from DOSBKIM7301 ([12.23.119.77])
	by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0LNS00IS27ZLGX@mmp2.samsung.com> for
	alsa-devel@alsa-project.org; Mon, 04 Jul 2011 08:59:45 +0900 (KST)
In-reply-to: <1309566922-3177-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Content-language: ko
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Mark Brown' <broonie@opensource.wolfsonmicro.com>, 'Liam Girdwood' <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Hi, Mark
Saturday, July 02, 2011 9:35 AM, Mark Brown wrote:

> This delay is very conservative.

What's the meaning of conservative?
It means 5ms delay long enough? 
or at least, FLL lock time should be ensured 5ms?

Thanks,
SB Kim
