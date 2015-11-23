From: "Wu, Songjun" <songjun.wu@atmel.com>
Subject: Re: [PATCH] ASoC: Atmel: ClassD: Set GCK's parent clock
Date: Mon, 23 Nov 2015 11:01:54 +0800
Message-ID: <565281A2.4050500@atmel.com>
References: <1447903590-3285-1-git-send-email-songjun.wu@atmel.com>
 <20151120180854.GD1929@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from DVREDG02.corp.atmel.com (nasmtp01.atmel.com [192.199.1.246])
 by alsa0.perex.cz (Postfix) with ESMTP id C45BE265158
 for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2015 04:02:10 +0100 (CET)
In-Reply-To: <20151120180854.GD1929@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org



On 11/21/2015 02:08, Mark Brown wrote:
> On Thu, Nov 19, 2015 at 11:26:30AM +0800, Songjun Wu wrote:
>> Set GCK's parent clock as audio clock, make
>> sure the GCK's parent clock is audio clock.
>
>> +	ret = clk_set_parent(dd->gclk, dd->aclk);
>> +	if (ret) {
>> +		dev_err(dev, "failed to set GCK parent clock: %d\n", ret);
>> +		return ret;
>> +	}
>
> Why are we doing this in the driver?  This should be done by whatever
> creates the clock tree, not by the driver that uses the clocks - that
> way if some future SoC has a different clock tree the driver will
> continue to work.
>

You are right. The GCK's parent clock should be assigned in device tree, 
not in the driver. The DT binding for classD should be modified to set 
the GCK's parent clock as audio clock.
Thank you.
