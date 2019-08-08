From: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH] ASoC: soc-core: remove error due to probe deferral
Date: Thu, 08 Aug 2019 15:16:53 +0200
Message-ID: <cd3fd8b9ce6e4f9820197c70dfc42b67@agner.ch>
References: <20190808123655.31520-1-stefan@agner.ch>
 <20190808124437.GD3795@sirena.co.uk> <s5hlfw3izhl.wl-tiwai@suse.de>
 <20190808130217.GE3795@sirena.co.uk> <s5hftmbiyuc.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hftmbiyuc.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz, Stefan Agner <stefan.agner@toradex.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 2019-08-08 15:14, Takashi Iwai wrote:
> On Thu, 08 Aug 2019 15:02:17 +0200,
> Mark Brown wrote:
>>
>> On Thu, Aug 08, 2019 at 03:00:06PM +0200, Takashi Iwai wrote:
>> > Mark Brown wrote:
>>
>> > > No, they absolutely should tell the user why they are deferring so the
>> > > user has some information to go on when they're trying to figure out why
>> > > their device isn't instantiating.
>>
>> > But it's no real error that *must* be printed on the console, either.
>> > Maybe downgrading the printk level?
>>
>> Yes, downgrading can be OK though it does bloat the code.
> 
> I guess we can use dev_printk() with the conditional level choice.
> 

How about use dev_info always? We get a dev_err message from
soc_init_dai_link in error cases...

		ret = soc_init_dai_link(card, dai_link);
		if (ret && ret != -EPROBE_DEFER) {
			dev_info(card->dev, "ASoC: failed to init link %s: %d\n",
				 dai_link->name, ret);
		}
		if (ret) {
			soc_cleanup_platform(card);
			mutex_unlock(&client_mutex);
			return ret;
		}

--
Stefan
