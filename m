From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 05/14] ALSA: hdac: Add MISCBDCGE support
Date: Sat, 12 Dec 2015 17:13:47 +0530
Message-ID: <20151212114347.GG1854@localhost>
References: <1449816267-11910-6-git-send-email-vinod.koul@intel.com>
 <201512120531.wHapk8nX%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id E4AC92606E6
 for <alsa-devel@alsa-project.org>; Sat, 12 Dec 2015 12:40:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <201512120531.wHapk8nX%fengguang.wu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: kbuild test robot <lkp@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, Jayachandran B <jayachandran.b@intel.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

On Sat, Dec 12, 2015 at 05:14:48AM +0800, kbuild test robot wrote:
> Hi Jayachandran,
> 
> [auto build test WARNING on asoc/for-next]
> [also build test WARNING on next-20151211]
> [cannot apply to sound/for-next v4.4-rc4]
> 
> url:    https://github.com/0day-ci/linux/commits/Vinod-Koul/ASoC-Intel-Skylake-Update-to-SKL-driver/20151211-145345
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
> config: mn10300-allmodconfig (attached as .config)
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=mn10300 
> 
> All warnings (new ones prefixed by >>):
> 
>    sound/hda/ext/hdac_ext_controller.c: In function 'update_pci_dword':
> >> sound/hda/ext/hdac_ext_controller.c:317:7: warning: 'data' is used uninitialized in this function [-Wuninitialized]
>      data &= ~mask;

Thanks, will fix it in v2


-- 
~Vinod
