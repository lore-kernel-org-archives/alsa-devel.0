From: kbuild test robot <lkp@intel.com>
Subject: [asoc:for-4.20 519/528]
 sound/soc/stm/stm32_sai_sub.c:393:26-32: ERROR: application of sizeof to
 pointer
Date: Tue, 23 Oct 2018 20:20:18 +0800
Message-ID: <201810232000.cMb4g8gx%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 22C9A2678CA
 for <alsa-devel@alsa-project.org>; Tue, 23 Oct 2018 14:20:28 +0200 (CEST)
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
head:   6be0f96d799f487f05eb412d362d5a1747d665c2
commit: 8307b2afd386ccce369821daa2196068c47fe8cd [519/528] ASoC: stm32: sai: set sai as mclk clock provider


coccinelle warnings: (new ones prefixed by >>)

>> sound/soc/stm/stm32_sai_sub.c:393:26-32: ERROR: application of sizeof to pointer
--
>> sound/soc/stm/stm32_sai_sub.c:343:5-8: WARNING: Unsigned expression compared with zero: div < 0

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
