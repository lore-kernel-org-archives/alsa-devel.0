From: Julia Lawall <julia.lawall@lip6.fr>
Subject: [asoc:topic/twl6040 1/2]
 sound/soc/codecs/twl6040.c:1156:71-72: remove: first occurrence line 1158,
 second occurrence line 1160 (fwd)
Date: Mon, 12 Mar 2018 23:09:18 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1803122308230.3378@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by alsa0.perex.cz (Postfix) with ESMTP id 8892A266F0F
 for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2018 23:09:20 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

There are two initializations of the remove field.  Both give it the same
value, so one can just be dropped.

julia

---------- Forwarded message ----------
Date: Tue, 13 Mar 2018 05:55:05 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: kbuild@01.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: [asoc:topic/twl6040 1/2] sound/soc/codecs/twl6040.c:1156:71-72: remove:
     first occurrence line 1158, second occurrence line 1160

CC: kbuild-all@01.org
CC: alsa-devel@alsa-project.org
TO: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
CC: Mark Brown <broonie@kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/twl6040
head:   c9d066650cd5adf4ed4bf5734386699e765222b7
commit: 7480389fb0d873ed78619542bf5d2717a7ad7786 [1/2] ASoC: twl6040: replace codec to component
:::::: branch date: 5 hours ago
:::::: commit date: 4 weeks ago

>> sound/soc/codecs/twl6040.c:1156:71-72: remove: first occurrence line 1158, second occurrence line 1160

# https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/?id=7480389fb0d873ed78619542bf5d2717a7ad7786
git remote add asoc https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
git remote update asoc
git checkout 7480389fb0d873ed78619542bf5d2717a7ad7786
vim +1156 sound/soc/codecs/twl6040.c

8ecbabd9 Misael Lopez Cruz 2010-03-19  1155
7480389f Kuninori Morimoto 2018-01-29 @1156  static const struct snd_soc_component_driver soc_component_dev_twl6040 = {
f0fba2ad Liam Girdwood     2010-03-17  1157  	.probe			= twl6040_probe,
f0fba2ad Liam Girdwood     2010-03-17 @1158  	.remove			= twl6040_remove,
8146acff Tony Lindgren     2018-01-25  1159  	.read			= twl6040_read,
7480389f Kuninori Morimoto 2018-01-29 @1160  	.remove			= twl6040_remove,
f0fba2ad Liam Girdwood     2010-03-17  1161  	.set_bias_level		= twl6040_set_bias_level,
a175fce0 Peter Ujfalusi    2011-10-11  1162  	.controls		= twl6040_snd_controls,
a175fce0 Peter Ujfalusi    2011-10-11  1163  	.num_controls		= ARRAY_SIZE(twl6040_snd_controls),
a175fce0 Peter Ujfalusi    2011-10-11  1164  	.dapm_widgets		= twl6040_dapm_widgets,
a175fce0 Peter Ujfalusi    2011-10-11  1165  	.num_dapm_widgets	= ARRAY_SIZE(twl6040_dapm_widgets),
a175fce0 Peter Ujfalusi    2011-10-11  1166  	.dapm_routes		= intercon,
a175fce0 Peter Ujfalusi    2011-10-11  1167  	.num_dapm_routes	= ARRAY_SIZE(intercon),
7480389f Kuninori Morimoto 2018-01-29  1168  	.suspend_bias_off	= 1,
7480389f Kuninori Morimoto 2018-01-29  1169  	.idle_bias_on		= 1,
7480389f Kuninori Morimoto 2018-01-29  1170  	.endianness		= 1,
7480389f Kuninori Morimoto 2018-01-29  1171  	.non_legacy_dai_naming	= 1,
f0fba2ad Liam Girdwood     2010-03-17  1172  };
f0fba2ad Liam Girdwood     2010-03-17  1173

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
