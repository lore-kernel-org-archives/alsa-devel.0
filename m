From: kbuild test robot <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH 06/10] ASoC: img: Add driver for parallel
 output controller
Date: Wed, 30 Sep 2015 23:48:00 +0800
Message-ID: <201509302334.zqf2LD5F%fengguang.wu@intel.com>
References: <1443625696-29296-7-git-send-email-Damien.Horsley@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1443625696-29296-7-git-send-email-Damien.Horsley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: kbuild-all-JC7UmRfGjtg@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "Damien.Horsley" <Damien.Horsley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hi Damien.Horsley,

[auto build test results on v4.3-rc3 -- if it's inappropriate base, please ignore]

reproduce:
  # apt-get install sparse
  make ARCH=x86_64 allmodconfig
  make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> sound/soc/img/img-parallel-out.c:198:16: sparse: incorrect type in assignment (different base types)
   sound/soc/img/img-parallel-out.c:198:16:    expected unsigned int [unsigned] format
   sound/soc/img/img-parallel-out.c:198:16:    got restricted snd_pcm_format_t

vim +198 sound/soc/img/img-parallel-out.c

   182		}
   183	
   184		spin_unlock_irqrestore(&prl->lock, flags);
   185	
   186		return ret;
   187	}
   188	
   189	static int img_prl_out_hw_params(struct snd_pcm_substream *substream,
   190		struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
   191	{
   192		struct img_prl_out *prl = snd_soc_dai_get_drvdata(dai);
   193		unsigned int rate, format, channels;
   194		u32 reg, reg_set = 0;
   195		unsigned long flags;
   196	
   197		rate = params_rate(params);
 > 198		format = params_format(params);
   199		channels = params_channels(params);
   200	
   201		switch (params_format(params)) {
   202		case SNDRV_PCM_FORMAT_S32_LE:
   203			reg_set |= IMG_PRL_OUT_CTL_PACKH_MASK;
   204			break;
   205		case SNDRV_PCM_FORMAT_S24_LE:
   206			break;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
