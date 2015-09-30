From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 08/10] ASoC: img: Add driver for SPDIF
 input controller
Date: Wed, 30 Sep 2015 23:53:30 +0800
Message-ID: <201509302313.wAQ6yuJF%fengguang.wu@intel.com>
References: <1443625696-29296-9-git-send-email-Damien.Horsley@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 5EBED26608A
 for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2015 17:54:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1443625696-29296-9-git-send-email-Damien.Horsley@imgtec.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, kbuild-all@01.org, Kumar Gala <galak@codeaurora.org>, "Damien.Horsley" <Damien.Horsley@imgtec.com>
List-Id: alsa-devel@alsa-project.org

Hi Damien.Horsley,

[auto build test results on v4.3-rc3 -- if it's inappropriate base, please ignore]

reproduce:
  # apt-get install sparse
  make ARCH=x86_64 allmodconfig
  make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> sound/soc/img/img-spdif-in.c:650:16: sparse: incorrect type in assignment (different base types)
   sound/soc/img/img-spdif-in.c:650:16:    expected unsigned int [unsigned] format
   sound/soc/img/img-spdif-in.c:650:16:    got restricted snd_pcm_format_t
>> sound/soc/img/img-spdif-in.c:652:23: sparse: restricted snd_pcm_format_t degrades to integer

vim +650 sound/soc/img/img-spdif-in.c

   644	{
   645		struct img_spdif_in *spdif = snd_soc_dai_get_drvdata(dai);
   646		unsigned int rate, channels, format;
   647	
   648		rate = params_rate(params);
   649		channels = params_channels(params);
 > 650		format = params_format(params);
   651	
 > 652		if (format != SNDRV_PCM_FORMAT_S32_LE)
   653			return -EINVAL;
   654	
   655		if (channels != 2)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
