From: "Wu, Songjun" <songjun.wu@atmel.com>
Subject: Re: atmel_ssc_dai.c, use of dai->id
Date: Tue, 5 Jul 2016 09:12:44 +0800
Message-ID: <b50d70ac-a07f-2db5-7cc7-2cf7a23479f9@atmel.com>
References: <alpine.DEB.2.02.1607041956420.11824@pmeerw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ussmtp01.atmel.com (nasmtp01.atmel.com [192.199.1.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 8342C265AB9
 for <alsa-devel@alsa-project.org>; Tue,  5 Jul 2016 03:12:55 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.02.1607041956420.11824@pmeerw.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org



On 7/5/2016 03:00, Peter Meerwald-Stadler wrote:
> Hello,
>
> I am trying to use SSC1 (not SSC0 which might work) on a SAMA5D4-Xplained
> board (4.1 kernel, but close to mainline)
>
> c706f2e5 ASoC: atmel_ssc_dai: distinguish the different SSC
> fixes an issue with cpu_dai id being always 0, while the ssc id should
> have been used (or the platform_device id)
>
> I think there is a remaining issue with DMA parameters in
> atmel_ssc_startup():
>
> line 324:
> dma_params = &ssc_dma_params[dai->id][dir];
>
> I think it should be
> dma_params = &ssc_dma_params[pdev->id][dir];
>
> I am new to this platform, please comment
> I can submit a formal patch later-on of course
>
Hi Peter,

Yes, you are right. It should be fixed in atmel_ssc_startup().
Thank you.

> thanks, regards, p.
>
