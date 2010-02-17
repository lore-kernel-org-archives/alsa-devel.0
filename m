From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: Separate dma driver for cpu_dais
Date: Wed, 17 Feb 2010 15:58:15 +0900
Message-ID: <4B7B9387.1070506@samsung.com>
References: <1b68c6791002161839q705df04cmeda046736948c614@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	by alsa0.perex.cz (Postfix) with ESMTP id 51AAD103840
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 07:58:18 +0100 (CET)
Received: from epmmp2 (mailout4.samsung.com [203.254.224.34])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0KXZ00MDE4P481@mailout1.samsung.com> for
	alsa-devel@alsa-project.org; Wed, 17 Feb 2010 15:58:16 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0KXZ00HY14P3Z2@mmp2.samsung.com> for
	alsa-devel@alsa-project.org; Wed, 17 Feb 2010 15:58:15 +0900 (KST)
In-reply-to: <1b68c6791002161839q705df04cmeda046736948c614@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jassi brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, kyungmin.park@samsung.com
List-Id: alsa-devel@alsa-project.org

On 2/17/2010 11:39 AM, jassi brar wrote:
> Hi,
>   The query concerns ASOC.
> 
> Currently we have one platform per card.
> What if my card has two dai_links with each cpu_dai fed data
> with different mechanism(one with system dma controller and
> the other with a dma dedicated to the Audio block). The cpu_dai's
> are tightly coupled and I don't wanna have separate socdev's for them.
> 

Hi, all.

Additionally, i have one more question.

At the ASoC, is there a situation to share the dai(cpu or codec)?
If the dai is shared, i just think the ASoC core cannot support it.

There is the case at the S5PC1XX, it supports the hardware mixing by
using two tx fifo. First Jassi implemented codes using each other cpu
dai as Jassi says at the above for the hardware mixing, but it should
share codec_dai and need some modification of ASoC core.
(I can see codes at the below url
http://git.kernel.org/?p=linux/kernel/git/kki_ap/linux-2.6-samsung.git)

Jassi, how do you think about this?
