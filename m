From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] ASoC: ak4613: call dummy write for
 PW_MGMT1/3 when Playback
Date: Tue, 14 Nov 2017 17:27:42 +0900
Message-ID: <bc955a77-fcdf-bfc7-1a87-5fec5f88ac63@sakamocchi.jp>
References: <87a7zpwfae.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id 9AF03266CFB
 for <alsa-devel@alsa-project.org>; Tue, 14 Nov 2017 09:27:45 +0100 (CET)
In-Reply-To: <87a7zpwfae.wl%kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, "Yokoyama (Renesas)" <hiroyuki.yokoyama.vx@renesas.com>
List-Id: alsa-devel@alsa-project.org

On Nov 14 2017 15:31, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Power Down Release Command (PMVR, PMDAC, RSTN, PMDA1-PMDA6)
> which are located on PW_MGMT1 / PW_MGMT3 register must be
> write again after at least 5 LRCK cycle or later from the first
> command. Otherwise, Playback volume will be 0dB.
> This patch adds dummy write when Playback Start timing.
> ...
> +
> +	delay = 6000000 / priv->rate;
> +	priv->component = &codec->component;
> +	schedule_delayed_work(&priv->dummy_write_work,
> +			      usecs_to_jiffies(delay));

In my understanding, kernel's service of delayed work relies on kernel's 
timer service. Resolution of the service is quite coarse in this 
purpose, at least for several phases of word select clock. In the worst 
case when task scheduling is too delay, many audio samples are not 
presented by the DAC in the beginning of playback. I can easily imagine 
that users get confused.

For this purpose, hrtimer kernel service is better. However, in design 
of ALSA PCM core, .trigger callback can be done in any IRQ context, 
basically. This means that we can't call task scheduler in the callback 
as long as issuing the command in the callback. This is a reason that 
you use workqueue for this purpose.


In your patch description, 5 word select phases after 'the first 
command'. According to "Digital Attenuator" section per page 44 of 
AK4613 English datasheet (AsahiKASEI 2015, MS1052-E-05)[1], your 'the 
first command' seems to be the previous command issueing of 'power-down 
release command'. In my understanding, in ak4613 codec driver, issueing 
of the previous command is done in 'ak4613_set_bias_level()'. If there's 
a guarantee for DAPM stuffs to call this function on any non-IRQ 
context, it's better to call the subsequent commands in the function 
with interval of sleep functionality with finer resolution (e.g. 
usleep_range()) but I don't know exactly that any components has 
guarantee to receive word select clock when the function is called.


[1] http://www.akm.com/akm/en/file/datasheet/AK4613VQ.pdf

Regards

Takashi Sakamoto
