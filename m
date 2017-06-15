From: Julia Lawall <julia.lawall@lip6.fr>
Subject: [asoc:topic/rcar 36/37]
 sound/soc/sh/rcar/ssi.c:285:5-14: WARNING: Unsigned expression compared
 with zero: main_rate < 0 (fwd)
Date: Thu, 15 Jun 2017 22:41:34 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1706152240270.3015@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by alsa0.perex.cz (Postfix) with ESMTP id 31485266A65
 for <alsa-devel@alsa-project.org>; Thu, 15 Jun 2017 22:41:36 +0200 (CEST)
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

Please check on line 285.

julia

---------- Forwarded message ----------
Date: Fri, 16 Jun 2017 04:21:36 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: kbuild@01.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: [asoc:topic/rcar 36/37] sound/soc/sh/rcar/ssi.c:285:5-14: WARNING:
    Unsigned expression compared with zero: main_rate < 0


tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/rcar
head:   8cc03722403a5153054993388857e4e565dcdfb1
commit: ef4cf5d6a143e04e149ad81fc491fe10855544fe [36/37] ASoC: rsnd: add rsnd_ssi_clk_query()
:::::: branch date: 3 hours ago
:::::: commit date: 3 hours ago

>> sound/soc/sh/rcar/ssi.c:285:5-14: WARNING: Unsigned expression compared with zero: main_rate < 0

git remote add asoc https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
git remote update asoc
git checkout ef4cf5d6a143e04e149ad81fc491fe10855544fe
vim +285 sound/soc/sh/rcar/ssi.c

e7d850dd1 Kuninori Morimoto 2015-10-26  269  	if (ssi_parent_mod && !rsnd_ssi_is_parent(mod, io))
e7d850dd1 Kuninori Morimoto 2015-10-26  270  		return 0;
e7d850dd1 Kuninori Morimoto 2015-10-26  271
b4c83b171 Kuninori Morimoto 2015-12-17  272  	if (rsnd_ssi_is_multi_slave(mod, io))
b4c83b171 Kuninori Morimoto 2015-12-17  273  		return 0;
b4c83b171 Kuninori Morimoto 2015-12-17  274
e7d850dd1 Kuninori Morimoto 2015-10-26  275  	if (ssi->usrcnt > 1) {
e7d850dd1 Kuninori Morimoto 2015-10-26  276  		if (ssi->rate != rate) {
e7d850dd1 Kuninori Morimoto 2015-10-26  277  			dev_err(dev, "SSI parent/child should use same rate\n");
e7d850dd1 Kuninori Morimoto 2015-10-26  278  			return -EINVAL;
e7d850dd1 Kuninori Morimoto 2015-10-26  279  		}
e7d850dd1 Kuninori Morimoto 2015-10-26  280
e7d850dd1 Kuninori Morimoto 2015-10-26  281  		return 0;
e7d850dd1 Kuninori Morimoto 2015-10-26  282  	}
e7d850dd1 Kuninori Morimoto 2015-10-26  283
ef4cf5d6a Kuninori Morimoto 2017-06-15  284  	main_rate = rsnd_ssi_clk_query(priv, rate, chan, &idx);
ef4cf5d6a Kuninori Morimoto 2017-06-15 @285  	if (main_rate < 0) {
ef4cf5d6a Kuninori Morimoto 2017-06-15  286  		dev_err(dev, "unsupported clock rate\n");
ef4cf5d6a Kuninori Morimoto 2017-06-15  287  		return -EIO;
ef4cf5d6a Kuninori Morimoto 2017-06-15  288  	}
ae5c32230 Kuninori Morimoto 2013-07-21  289
b76e218ae Kuninori Morimoto 2015-09-10  290  	ret = rsnd_adg_ssi_clk_try_start(mod, main_rate);
ef4cf5d6a Kuninori Morimoto 2017-06-15  291  	if (ret < 0)
ef4cf5d6a Kuninori Morimoto 2017-06-15  292  		return ret;
ae5c32230 Kuninori Morimoto 2013-07-21  293

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
