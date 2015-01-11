From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/4] ASoC: fsl: Update set_tdm_slot()
	semantics
Date: Sun, 11 Jan 2015 12:45:35 +0100
Message-ID: <54B2625F.6090206@metafoo.de>
References: <1420887157-18593-1-git-send-email-lars@metafoo.de>
 <1420887157-18593-3-git-send-email-lars@metafoo.de>
 <20150110200038.GA3584@Alpha>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-127.synserver.de (smtp-out-127.synserver.de
 [212.40.185.127])
 by alsa0.perex.cz (Postfix) with ESMTP id 78EC02604C2
 for <alsa-devel@alsa-project.org>; Sun, 11 Jan 2015 12:45:36 +0100 (CET)
In-Reply-To: <20150110200038.GA3584@Alpha>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Xiubo Li <Li.Xiubo@freescale.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 01/10/2015 09:00 PM, Nicolin Chen wrote:
> Hi Lars,
>
> On Sat, Jan 10, 2015 at 11:52:35AM +0100, Lars-Peter Clausen wrote:
>> The fsl-esai, fsl-ssi and imx-ssi drivers use inverted semantics for the
>> tx_mask and rx_mask parameter of the set_tdm_slot() callback compared to
>> rest of ASoC. This patch updates the driver's semantics to be consistent
>> with the rest of ASoC, i.e. a set bit means a active slot and a cleared bit
>> means a inactive slot.  This will allow us to use the set_tdm_slot() API in
>> a more generic way.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> ---
>>   sound/soc/fsl/eukrea-tlv320.c | 2 +-
>>   sound/soc/fsl/fsl_esai.c      | 3 +++
>>   sound/soc/fsl/fsl_ssi.c       | 4 ++--
>>   sound/soc/fsl/fsl_utils.c     | 6 +++---
>>   sound/soc/fsl/imx-mc13783.c   | 2 +-
>>   sound/soc/fsl/imx-ssi.c       | 4 ++--
>>   sound/soc/fsl/wm1133-ev1.c    | 4 ++--
>
> The SSI part and these machine drivers (all of them using SSI) being
> patched should be okay because the SSI uses the inverted semantics.
>
> However, the mask for ESAI does follow the common semantics, that is,
> a set bit means a active slot and a cleared bit.
>
> After hardware or software reset, the ESAI_TSMA register is preset to
> 0x0000FFFF, which means that all 16 possible slots are enabled for data
> transmission.				-- From i.MX6 Reference Manual
>
> So I think ESAI doesn't need this change at all.

Thanks, will fix it and send a v2.

- Lars
