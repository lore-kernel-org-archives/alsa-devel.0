From: kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH v3] ASoC: AMD: Enable/Disable auxiliary
 clock via common clock framework
Date: Fri, 23 Mar 2018 23:45:41 +0800
Message-ID: <201803232316.d2zESpL4%fengguang.wu@intel.com>
References: <1521605103-13574-1-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by alsa0.perex.cz (Postfix) with ESMTP id 81E47266A73
 for <alsa-devel@alsa-project.org>; Fri, 23 Mar 2018 16:46:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1521605103-13574-1-git-send-email-akshu.agrawal@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, lgirdwood@gmail.com, djkurtz@chromium.org, akshu.agrawal@amd.com, broonie@kernel.org, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

Hi Akshu,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on asoc/for-next]
[also build test WARNING on next-20180323]
[cannot apply to v4.16-rc6]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Akshu-Agrawal/ASoC-AMD-Enable-Disable-auxiliary-clock-via-common-clock-framework/20180323-220927
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   sound/soc/amd/acp-da7219-max98357a.c:61:12: sparse: symbol 'da7219_dai_clk' was not declared. Should it be static?
>> sound/soc/amd/acp-da7219-max98357a.c:312:22: sparse: symbol 'acpd7219_clks_ops' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
