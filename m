From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 4/4] ASoC: Intel: Skylake: Add support
 to read firmware registers
Date: Mon, 3 Jul 2017 08:57:12 +0530
Message-ID: <20170703032712.GU19154@localhost>
References: <20170629065604.30105-5-guneshwor.o.singh@intel.com>
 <201707022035.TVqTM8gw%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <201707022035.TVqTM8gw%fengguang.wu@intel.com>
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
Cc: Sodhi@alsa-project.org, alsa-devel@alsa-project.org, Babu@alsa-project.org, Patches Audio <patches.audio@intel.com>, Pardha Saradhi <pardha.saradhi.kesapragada@intel.com>, Jayachandran <jayachandran.b@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Ramesh <ramesh.babu@intel.com>, Mousumi Jana <mousumix.jana@intel.com>, liam.r.girdwood@linux.intel.com, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, kbuild-all@01.org, "Sodhi, VunnyX" <vunnyx.sodhi@intel.com>, B@alsa-project.org, Kesapragada@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Jul 02, 2017 at 08:12:07PM +0800, kbuild test robot wrote:
> Hi VunnyX,
> 
> [auto build test WARNING on asoc/for-next]
> [also build test WARNING on v4.12-rc7 next-20170630]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Guneshwor-Singh/Add-debugfs-support-for-skylake-driver/20170630-234553
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
> config: x86_64-randconfig-ws0-07021539 (attached as .config)
> compiler: gcc-4.8 (Debian 4.8.4-1) 4.8.4
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from sound/soc/intel/skylake/skl-debug.c:23:0:
> >> sound/soc/intel/skylake/../common/sst-dsp-priv.h:63:42: warning: 'struct sst_pdata' declared inside parameter list [enabled by default]
>      int (*init)(struct sst_dsp *sst, struct sst_pdata *pdata);
>                                              ^
> >> sound/soc/intel/skylake/../common/sst-dsp-priv.h:63:42: warning: its scope is only this definition or declaration, which is probably not what you want [enabled by default]

this is due to missing define, so adding the right header should fix this
warning, will send a patch for this

Thanks for reporting

> 
> vim +63 sound/soc/intel/skylake/../common/sst-dsp-priv.h
> 
> a4b12990 sound/soc/intel/sst-dsp-priv.h Mark Brown 2014-03-12  47  	u32 (*read)(void __iomem *addr, u32 offset);
> a4b12990 sound/soc/intel/sst-dsp-priv.h Mark Brown 2014-03-12  48  	void (*write64)(void __iomem *addr, u32 offset, u64 value);
> a4b12990 sound/soc/intel/sst-dsp-priv.h Mark Brown 2014-03-12  49  	u64 (*read64)(void __iomem *addr, u32 offset);
> a4b12990 sound/soc/intel/sst-dsp-priv.h Mark Brown 2014-03-12  50  
> a4b12990 sound/soc/intel/sst-dsp-priv.h Mark Brown 2014-03-12  51  	/* DSP I/DRAM IO */
> a4b12990 sound/soc/intel/sst-dsp-priv.h Mark Brown 2014-03-12  52  	void (*ram_read)(struct sst_dsp *sst, void  *dest, void __iomem *src,
> a4b12990 sound/soc/intel/sst-dsp-priv.h Mark Brown 2014-03-12  53  		size_t bytes);
> a4b12990 sound/soc/intel/sst-dsp-priv.h Mark Brown 2014-03-12  54  	void (*ram_write)(struct sst_dsp *sst, void __iomem *dest, void *src,
> a4b12990 sound/soc/intel/sst-dsp-priv.h Mark Brown 2014-03-12  55  		size_t bytes);
> a4b12990 sound/soc/intel/sst-dsp-priv.h Mark Brown 2014-03-12  56  
> a4b12990 sound/soc/intel/sst-dsp-priv.h Mark Brown 2014-03-12  57  	void (*dump)(struct sst_dsp *);
> a4b12990 sound/soc/intel/sst-dsp-priv.h Mark Brown 2014-03-12  58  
> a4b12990 sound/soc/intel/sst-dsp-priv.h Mark Brown 2014-03-12  59  	/* IRQ handlers */
> a4b12990 sound/soc/intel/sst-dsp-priv.h Mark Brown 2014-03-12  60  	irqreturn_t (*irq_handler)(int irq, void *context);
> a4b12990 sound/soc/intel/sst-dsp-priv.h Mark Brown 2014-03-12  61  
> a4b12990 sound/soc/intel/sst-dsp-priv.h Mark Brown 2014-03-12  62  	/* SST init and free */
> a4b12990 sound/soc/intel/sst-dsp-priv.h Mark Brown 2014-03-12 @63  	int (*init)(struct sst_dsp *sst, struct sst_pdata *pdata);
> a4b12990 sound/soc/intel/sst-dsp-priv.h Mark Brown 2014-03-12  64  	void (*free)(struct sst_dsp *sst);
> a4b12990 sound/soc/intel/sst-dsp-priv.h Mark Brown 2014-03-12  65  
> a4b12990 sound/soc/intel/sst-dsp-priv.h Mark Brown 2014-03-12  66  	/* FW module parser/loader */
> a4b12990 sound/soc/intel/sst-dsp-priv.h Mark Brown 2014-03-12  67  	int (*parse_fw)(struct sst_fw *sst_fw);
> a4b12990 sound/soc/intel/sst-dsp-priv.h Mark Brown 2014-03-12  68  };
> a4b12990 sound/soc/intel/sst-dsp-priv.h Mark Brown 2014-03-12  69  
> a4b12990 sound/soc/intel/sst-dsp-priv.h Mark Brown 2014-03-12  70  /*
> a4b12990 sound/soc/intel/sst-dsp-priv.h Mark Brown 2014-03-12  71   * Audio DSP memory offsets and addresses.
> 
> :::::: The code at line 63 was first introduced by commit
> :::::: a4b12990b68079290ab62799035afe175b4bdc23 Merge remote-tracking branches 'asoc/topic/ml26124', 'asoc/topic/of', 'asoc/topic/omap', 'asoc/topic/pxa' and 'asoc/topic/rcar' into asoc-next
> 
> :::::: TO: Mark Brown <broonie@linaro.org>
> :::::: CC: Mark Brown <broonie@linaro.org>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation



-- 
~Vinod
