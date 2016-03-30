From: John Hsu <KCHSU0@nuvoton.com>
Subject: Re: [PATCH] ASoC: nau8825: reduce standby power
	consumption
Date: Wed, 30 Mar 2016 19:06:05 +0800
Message-ID: <56FBB31D.5070304@nuvoton.com>
References: <1458619025-28306-1-git-send-email-KCHSU0@nuvoton.com>
 <20160328190544.GD2350@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8FE3D26055C
 for <alsa-devel@alsa-project.org>; Wed, 30 Mar 2016 13:06:08 +0200 (CEST)
In-Reply-To: <20160328190544.GD2350@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, YHCHuang@nuvoton.com, lgirdwood@gmail.com, benzh@chromium.org, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org

Hi,
On 3/29/2016 3:05 AM, Mark Brown wrote:
> On Tue, Mar 22, 2016 at 11:57:05AM +0800, John Hsu wrote:
>
>   
>> @@ -1116,6 +1116,9 @@ static int nau8825_configure_sysclk(struct nau8825 *nau8825, int clk_id,
>>  		regmap_update_bits(regmap, NAU8825_REG_CLK_DIVIDER,
>>  			NAU8825_CLK_SRC_MASK, NAU8825_CLK_SRC_MCLK);
>>  		regmap_update_bits(regmap, NAU8825_REG_FLL6, NAU8825_DCO_EN, 0);
>> +		/* MCLK not changed by clock tree */
>> +		regmap_update_bits(regmap, NAU8825_REG_CLK_DIVIDER,
>> +			NAU8825_CLK_MCLK_SRC_MASK, 0);
>>     
>
> I'm going to apply this since I suspect there are already similar
> assumptions in the code but it does look like the issues Ben raised with
> one of your other patches with confusing sysclk management and overall
> device power might apply here.  We can't rely on people changing the
> clock configuration in lower power modes.
>   
If the platform has internal clock for interrupt, the codec power should
use less power as possible. The patch is made to guarantee that requirement.
The system has better power saving by slowing down the internal clock.
