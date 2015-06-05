From: Sergej Sawazki <ce3a@gmx.de>
Subject: Re: [RFC PATCH] ASoC: wm8741: Allow master clock
	switching
Date: Fri, 05 Jun 2015 20:56:10 +0200
Message-ID: <5571F0CA.4040405@gmx.de>
References: <1433505944-3961-1-git-send-email-ce3a@gmx.de>
 <20150605152219.GA32730@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 89968266911
 for <alsa-devel@alsa-project.org>; Fri,  5 Jun 2015 20:56:15 +0200 (CEST)
In-Reply-To: <20150605152219.GA32730@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, broonie@kernel.org, dan.carpenter@oracle.com
List-Id: alsa-devel@alsa-project.org

On 2015-06-05 at 05:22PM, Charles Keepax wrote:
>
> I think rather than removing the constraints entirely here,
> perhaps just don't set any constraints if there is no SYSCLK yet.
> That way we get the benefits of the constraints for single clock
> systems (such as user-space being able to arrange appropriate
> software resampling) but those like yours can configure the clock
> later.
>

Good point, I will add it to v2.

>> +	if (!wm8741->sysclk) {
>> +		dev_err(codec->dev,
>> +			"No MCLK configured, call set_sysclk() on hw_params\n");
>> +		return -EINVAL;
>> +	}
>
> Then you can keep this error check here and fail if we reach
> hw_params and still don't have a SYSCLK. You will probably need
> to provide a way to clear the SYSCLK though set_dai_sysclk as
> well.

Is snd_soc_dai_set_sysclk( , , 0, ) the right way to clear the SYSCLK?

Thanks,
Sergej
