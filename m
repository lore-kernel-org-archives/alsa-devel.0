From: Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v2 3/3] ASoC: stm32: Add full duplex support
 to i2s (fwd)
Date: Thu, 11 May 2017 10:13:53 +0800 (SGT)
Message-ID: <alpine.DEB.2.20.1705111012050.3585@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: olivier moysan <olivier.moysan-qxv4g6HH51o@public.gmane.org>
Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, alexandre.torgue-qxv4g6HH51o@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnaud.pouliquen-qxv4g6HH51o@public.gmane.org, benjamin.gaignard-qxv4g6HH51o@public.gmane.org, kbuild-all-JC7UmRfGjtg@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Please check whether the lock taken on line 585 should be freed on line
598.  The report also mentions line 652, although that is not shown.

julia

---------- Forwarded message ----------
Date: Thu, 11 May 2017 09:49:21 +0800
From: kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: kbuild-JC7UmRfGjtg@public.gmane.org
Cc: Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v2 3/3] ASoC: stm32: Add full duplex support to
     i2s

Hi olivier,

[auto build test WARNING on asoc/for-next]
[also build test WARNING on next-20170510]
[cannot apply to v4.11]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/olivier-moysan/Add-I2S-driver/20170511-075335
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
:::::: branch date: 2 hours ago
:::::: commit date: 2 hours ago

>> sound/soc/stm/stm32_i2s.c:598:3-9: preceding lock on line 585
>> sound/soc/stm/stm32_i2s.c:598:3-9: preceding lock on line 585
   sound/soc/stm/stm32_i2s.c:652:3-9: preceding lock on line 585

git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 9f5663c4aa8961bf2a547683af787e606503376e
vim +598 sound/soc/stm/stm32_i2s.c

1ebd36ae olivier moysan 2017-05-10  579  {
1ebd36ae olivier moysan 2017-05-10  580  	struct stm32_i2s_data *i2s = snd_soc_dai_get_drvdata(cpu_dai);
1ebd36ae olivier moysan 2017-05-10  581  	bool playback_flg = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
9f5663c4 olivier moysan 2017-05-10  582  	u32 cfg1_mask, ier;
1ebd36ae olivier moysan 2017-05-10  583  	int ret;
1ebd36ae olivier moysan 2017-05-10  584
9f5663c4 olivier moysan 2017-05-10 @585  	spin_lock(&i2s->lock_fd);
9f5663c4 olivier moysan 2017-05-10  586
1ebd36ae olivier moysan 2017-05-10  587  	switch (cmd) {
1ebd36ae olivier moysan 2017-05-10  588  	case SNDRV_PCM_TRIGGER_START:
1ebd36ae olivier moysan 2017-05-10  589  	case SNDRV_PCM_TRIGGER_RESUME:
1ebd36ae olivier moysan 2017-05-10  590  	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
1ebd36ae olivier moysan 2017-05-10  591  		/* Enable i2s */
1ebd36ae olivier moysan 2017-05-10  592  		dev_dbg(cpu_dai->dev, "start I2S\n");
1ebd36ae olivier moysan 2017-05-10  593
1ebd36ae olivier moysan 2017-05-10  594  		ret = regmap_update_bits(i2s->regmap, STM32_I2S_CR1_REG,
1ebd36ae olivier moysan 2017-05-10  595  					 I2S_CR1_SPE, I2S_CR1_SPE);
1ebd36ae olivier moysan 2017-05-10  596  		if (ret < 0) {
1ebd36ae olivier moysan 2017-05-10  597  			dev_err(cpu_dai->dev, "Error %d enabling I2S\n", ret);
1ebd36ae olivier moysan 2017-05-10 @598  			return ret;
1ebd36ae olivier moysan 2017-05-10  599  		}
1ebd36ae olivier moysan 2017-05-10  600
1ebd36ae olivier moysan 2017-05-10  601  		ret = regmap_update_bits(i2s->regmap, STM32_I2S_CR1_REG,

:::::: The code at line 598 was first introduced by commit
:::::: 1ebd36ae636af5c130a9df4d9a921e4ed984a6e9 ASoC: stm32: Add I2S driver

:::::: TO: olivier moysan <olivier.moysan-qxv4g6HH51o@public.gmane.org>
:::::: CC: 0day robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
