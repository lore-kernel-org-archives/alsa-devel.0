From: sugar <sugar.zhang@rock-chips.com>
Subject: Re: [PATCH v3 1/3] ASoC: rockchip: i2s: add 8 channels
 capture support
Date: Mon, 9 Nov 2015 15:21:53 +0800
Message-ID: <56404991.6000505@rock-chips.com>
References: <1446773891-32174-1-git-send-email-sugar.zhang@rock-chips.com>
 <1446773891-32174-2-git-send-email-sugar.zhang@rock-chips.com>
 <20151106120020.GH18409@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from regular1.263xmail.com (regular1.263xmail.com [211.150.99.138])
 by alsa0.perex.cz (Postfix) with ESMTP id A95F9260418
 for <alsa-devel@alsa-project.org>; Mon,  9 Nov 2015 08:21:59 +0100 (CET)
In-Reply-To: <20151106120020.GH18409@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, heiko@sntech.de, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, tiwai@suse.com, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org



On 11/6/2015 20:00, Mark Brown wrote:
> On Fri, Nov 06, 2015 at 09:38:09AM +0800, Sugar Zhang wrote:
>
>> +	/* refine capture channels */
>> +	if (!of_property_read_u32(node, "rockchip,capture-channels", &val)) {
>> +		if (val >= 2 && val <= 8)
>> +			rockchip_i2s_dai.capture.channels_max = val;
>> +		else
>> +			rockchip_i2s_dai.capture.channels_max = 2;
>> +	}
>
> You should make a copy of the rockchip_i2s_dai struct in your driver
> data and modify that rather than modifying the original - what happens
> if sommeone makes a SoC with two I2S DAIs, one with many channels and
> another with only two?  Samsung SoCs often have an arrangement like that
> for exmaple.
>

Yes, I agree, because this patch was merged into mainline, I will post a 
new one based on the latest code to fix this, thanks.
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
>
