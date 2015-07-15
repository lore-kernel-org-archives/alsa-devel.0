From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [PATCH v3 3/9] ASoC: sti: Add CPU DAI driver for
	playback
Date: Wed, 15 Jul 2015 11:28:22 +0200
Message-ID: <55A627B6.70207@st.com>
References: <1434983473-25092-1-git-send-email-arnaud.pouliquen@st.com>
 <1434983473-25092-4-git-send-email-arnaud.pouliquen@st.com>
 <20150710170046.GU11162@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 622D326172C
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2015 11:28:27 +0200 (CEST)
In-Reply-To: <20150710170046.GU11162@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, kernel@stlinux.com
List-Id: alsa-devel@alsa-project.org


On 07/10/2015 07:00 PM, Mark Brown wrote:
> On Mon, Jun 22, 2015 at 04:31:07PM +0200, Arnaud Pouliquen wrote:
>
>> +	if (clk_id != 0)
>> +		return -EINVAL;
>> +
>> +	player->mclk = freq;
>> +
>> +	return clk_set_rate(player->clk, freq);
>
> You should really only set the mclk after clk_set_rate() succeeds but
> practically it probably doesn't matter.
>
>> +	case SND_SOC_DAIFMT_IB_NF:
>> +		SET_UNIPERIF_I2S_FMT_LR_POL_LOW(player);
>> +		SET_UNIPERIF_I2S_FMT_SCLK_EDGE_FALLING(player);
>> +		break;
>> +	case SND_SOC_DAIFMT_IB_IF:
>> +		SET_UNIPERIF_I2S_FMT_LR_POL_HIG(player);
>> +		SET_UNIPERIF_I2S_FMT_SCLK_EDGE_FALLING(player);
>> +	}
>
> Missing break in that last case.
>
>> +	player->clk = of_clk_get(pdev->dev.of_node, 0);
>> +	if (IS_ERR(player->clk))
>> +		ret = (int)PTR_ERR(player->clk);
>
> You shouldn't need the cast here.
>
Ok, i will sent  correction for this, do you need a V4 for this patch or 
an additional fix on top of V3?
