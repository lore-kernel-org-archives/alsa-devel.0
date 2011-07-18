From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH v5 4/4] ASoC: SAMSUNG: Add I2S0 internal
 dma driver
Date: Mon, 18 Jul 2011 13:38:33 +0100
Message-ID: <4E242949.5080902@ti.com>
References: <1310520321-11106-1-git-send-email-sbkim73@samsung.com>
	<CABb+yY1nDw-tC86Q4BFUHfBJCL=gtV92zYt4xNbp22duA3_V3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id AF112103807
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Jul 2011 14:38:40 +0200 (CEST)
In-Reply-To: <CABb+yY1nDw-tC86Q4BFUHfBJCL=gtV92zYt4xNbp22duA3_V3Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Sangbeom Kim <sbkim73@samsung.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 18/07/11 12:49, Jassi Brar wrote:
> On Wed, Jul 13, 2011 at 6:55 AM, Sangbeom Kim <sbkim73@samsung.com> wrote:
>> I2S in Exynos4 and S5PC110(S5PV210) has a internal dma.
>> It can be used low power audio mode and 2nd channel transfer.
>> This patch can support idma.
>>
>> Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
>> ---
>> V2: change idma_new by new pcm_new api
>>    add handling different idma address
>>    as jassi comments, Modify the idma driver
>>
>> V3: merge idma_reg_int and idma_addr_init
>>
>> V4: move idma setting in i2s.c to idma_hw_params in idma.c
>>    move idma_reg_addr_init calling
>>    modify idma address handling error
>>    modify module information
>>    delete useless dev_dbg
>>
>> V5: delete redundant error print and check routine
>>    modify irq handler as jassi comment
>>    fix the indent error
>>
>>  sound/soc/samsung/Makefile |    2 +
>>  sound/soc/samsung/idma.c   |  453
> 
> Acked-by: Jassi Brar <jassisinghbrar@gmail.com>

Acked-by: Liam Girdwood <lrg@ti.com>
