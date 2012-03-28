From: Sangbeom Kim <sbkim73@samsung.com>
Subject: Re: [PATCH] ASoC: Samsung: fix DMA interface for
	s3c2442	boards
Date: Wed, 28 Mar 2012 17:40:48 +0900
Message-ID: <028001cd0cbe$796d05c0$6c471140$@com>
References: <1332887869-3527-1-git-send-email-GNUtoo@no-log.org>
	<1332887869-3527-2-git-send-email-GNUtoo@no-log.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	by alsa0.perex.cz (Postfix) with ESMTP id 7DD98103EAB
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Mar 2012 10:40:39 +0200 (CEST)
Received: from epcpsbgm1.samsung.com (mailout4.samsung.com [203.254.224.34])
	by mailout4.samsung.com
	(Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built
	Sep 7
	2010)) with ESMTP id <0M1L003EB6RHA8U0@mailout4.samsung.com> for
	alsa-devel@alsa-project.org; Wed, 28 Mar 2012 17:40:36 +0900 (KST)
Received: from DOSBKIM7302 ([12.23.118.225])
	by mmp1.samsung.com (Oracle Communications Messaging Exchange Server
	7u4-19.01 64bit (built Sep 7 2010)) with ESMTPA id
	<0M1L002FE6ROY701@mmp1.samsung.com>
	for alsa-devel@alsa-project.org; Wed, 28 Mar 2012 17:40:36 +0900 (KST)
In-reply-to: <1332887869-3527-2-git-send-email-GNUtoo@no-log.org>
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
To: 'Denis 'GNUtoo' Carikli' <GNUtoo@no-log.org>, 'Mark Brown' <broonie@opensource.wolfsonmicro.com>
Cc: 'Sangbeom Kim' <sbkim73@samsung.com>, alsa-devel@alsa-project.org, boojin.kim@samsung.com
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 28, 2012 at 07:38 AM , Denis 'GNUtoo' Carikli wrote:
> Subject: [alsa-devel] [PATCH] ASoC: Samsung: fix DMA interface for s3c2442 boards
> 
> Without this fix playing a wav file that said "incomming call"
>   resulted in the following beeing played: "in-in-in-co-co-co-mi-mi-mi...".
> 
> This commit was tested on the GTA02 Machine.
> 
> The problem was introduced by commit 344b4c48887a443f7478fc7047d1397b20821ed3
>   (ASoC: Samsung: Update DMA interface)

Hi, Denis,
As you know, Boojin Kim had modified PL330 dma related code in the last sep.
http://lists.infradead.org/pipermail/linux-arm-kernel/2011-September/063682.html
It just affect pl330 dma operation.
If not, problem can be happened.
Anyway, I will check all dma operation.
I have included Boojin Kim on this mail-loop.

Thanks,
Sangbeom.
