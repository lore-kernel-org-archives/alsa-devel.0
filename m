From: kbuild test robot <lkp@intel.com>
Subject: [asoc:for-4.20 519/526]
 sound/soc/stm/stm32_sai_sub.c:343 stm32_sai_mclk_set_rate() warn: unsigned
 'div' is never less than zero.
Date: Tue, 23 Oct 2018 06:29:32 +0800
Message-ID: <201810230630.uKs7oSH2%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id DEAFB2677D0
 for <alsa-devel@alsa-project.org>; Tue, 23 Oct 2018 00:30:06 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Olivier Moysan <olivier.moysan@st.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-4.20
head:   7f91e2af1a4a2c34fc2e8fb046c722e1a9c85399
commit: 8307b2afd386ccce369821daa2196068c47fe8cd [519/526] ASoC: stm32: sai: set sai as mclk clock provider

smatch warnings:
sound/soc/stm/stm32_sai_sub.c:343 stm32_sai_mclk_set_rate() warn: unsigned 'div' is never less than zero.

vim +/div +343 sound/soc/stm/stm32_sai_sub.c

   333	
   334	static int stm32_sai_mclk_set_rate(struct clk_hw *hw, unsigned long rate,
   335					   unsigned long parent_rate)
   336	{
   337		struct stm32_sai_mclk_data *mclk = to_mclk_data(hw);
   338		struct stm32_sai_sub_data *sai = mclk->sai_data;
   339		unsigned int div;
   340		int ret;
   341	
   342		div = stm32_sai_get_clk_div(sai, parent_rate, rate);
 > 343		if (div < 0)
   344			return div;
   345	
   346		ret = stm32_sai_set_clk_div(sai, div);
   347		if (ret)
   348			return ret;
   349	
   350		mclk->freq = rate;
   351	
   352		return 0;
   353	}
   354	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
