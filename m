From: kbuild test robot <fengguang.wu@intel.com>
Subject: [sound:topic/asus-e100h-4.10 18/26]
 drivers/clk/x86/clk-pmc-atom.c:44:16: error: field 'hw' has incomplete type
Date: Fri, 24 Feb 2017 04:20:52 +0800
Message-ID: <201702240436.iXaqlPMm%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="PNTmBPCT7hxwcZjr"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id B5FB1266FA2
 for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2017 21:21:55 +0100 (CET)
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
To: Irina Tirdea <irina.tirdea@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Stephen Boyd <sboyd@codeaurora.org>, kbuild-all@01.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git topic/asus-e100h-4.10
head:   c86c0067e6111324a39f523c250c8b1089b1d822
commit: 19a80107e5cf1d2d02b678bb086f305a05e4f692 [18/26] clk: x86: Add Atom PMC platform clocks
config: i386-randconfig-i1-02231015 (attached as .config)
compiler: gcc-4.8 (Debian 4.8.4-1) 4.8.4
reproduce:
        git checkout 19a80107e5cf1d2d02b678bb086f305a05e4f692
        # save the attached .config to linux build tree
        make ARCH=i386 

All error/warnings (new ones prefixed by >>):

>> drivers/clk/x86/clk-pmc-atom.c:44:16: error: field 'hw' has incomplete type
     struct clk_hw hw;
                   ^
   In file included from include/asm-generic/bug.h:13:0,
                    from arch/x86/include/asm/bug.h:35,
                    from include/linux/bug.h:4,
                    from include/linux/io.h:23,
                    from include/linux/clk-provider.h:14,
                    from drivers/clk/x86/clk-pmc-atom.c:17:
   drivers/clk/x86/clk-pmc-atom.c: In function 'plt_clk_set_parent':
   include/linux/kernel.h:850:48: warning: initialization from incompatible pointer type [enabled by default]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clk/x86/clk-pmc-atom.c:51:25: note: in expansion of macro 'container_of'
    #define to_clk_plt(_hw) container_of(_hw, struct clk_plt, hw)
                            ^
   drivers/clk/x86/clk-pmc-atom.c:113:24: note: in expansion of macro 'to_clk_plt'
     struct clk_plt *clk = to_clk_plt(hw);
                           ^
   include/linux/kernel.h:850:48: warning: (near initialization for 'clk') [enabled by default]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clk/x86/clk-pmc-atom.c:51:25: note: in expansion of macro 'container_of'
    #define to_clk_plt(_hw) container_of(_hw, struct clk_plt, hw)
                            ^
   drivers/clk/x86/clk-pmc-atom.c:113:24: note: in expansion of macro 'to_clk_plt'
     struct clk_plt *clk = to_clk_plt(hw);
                           ^
   drivers/clk/x86/clk-pmc-atom.c: In function 'plt_clk_get_parent':
   include/linux/kernel.h:850:48: warning: initialization from incompatible pointer type [enabled by default]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clk/x86/clk-pmc-atom.c:51:25: note: in expansion of macro 'container_of'
    #define to_clk_plt(_hw) container_of(_hw, struct clk_plt, hw)
                            ^
   drivers/clk/x86/clk-pmc-atom.c:122:24: note: in expansion of macro 'to_clk_plt'
     struct clk_plt *clk = to_clk_plt(hw);
                           ^
   include/linux/kernel.h:850:48: warning: (near initialization for 'clk') [enabled by default]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clk/x86/clk-pmc-atom.c:51:25: note: in expansion of macro 'container_of'
    #define to_clk_plt(_hw) container_of(_hw, struct clk_plt, hw)
                            ^
   drivers/clk/x86/clk-pmc-atom.c:122:24: note: in expansion of macro 'to_clk_plt'
     struct clk_plt *clk = to_clk_plt(hw);
                           ^
   drivers/clk/x86/clk-pmc-atom.c: In function 'plt_clk_enable':
   include/linux/kernel.h:850:48: warning: initialization from incompatible pointer type [enabled by default]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clk/x86/clk-pmc-atom.c:51:25: note: in expansion of macro 'container_of'
    #define to_clk_plt(_hw) container_of(_hw, struct clk_plt, hw)
                            ^
   drivers/clk/x86/clk-pmc-atom.c:132:24: note: in expansion of macro 'to_clk_plt'
     struct clk_plt *clk = to_clk_plt(hw);
                           ^
   include/linux/kernel.h:850:48: warning: (near initialization for 'clk') [enabled by default]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clk/x86/clk-pmc-atom.c:51:25: note: in expansion of macro 'container_of'
    #define to_clk_plt(_hw) container_of(_hw, struct clk_plt, hw)
                            ^
   drivers/clk/x86/clk-pmc-atom.c:132:24: note: in expansion of macro 'to_clk_plt'
     struct clk_plt *clk = to_clk_plt(hw);
                           ^
   drivers/clk/x86/clk-pmc-atom.c: In function 'plt_clk_disable':
   include/linux/kernel.h:850:48: warning: initialization from incompatible pointer type [enabled by default]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clk/x86/clk-pmc-atom.c:51:25: note: in expansion of macro 'container_of'
    #define to_clk_plt(_hw) container_of(_hw, struct clk_plt, hw)
                            ^
   drivers/clk/x86/clk-pmc-atom.c:141:24: note: in expansion of macro 'to_clk_plt'
     struct clk_plt *clk = to_clk_plt(hw);
                           ^
   include/linux/kernel.h:850:48: warning: (near initialization for 'clk') [enabled by default]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clk/x86/clk-pmc-atom.c:51:25: note: in expansion of macro 'container_of'
    #define to_clk_plt(_hw) container_of(_hw, struct clk_plt, hw)
                            ^
   drivers/clk/x86/clk-pmc-atom.c:141:24: note: in expansion of macro 'to_clk_plt'
     struct clk_plt *clk = to_clk_plt(hw);
                           ^
   drivers/clk/x86/clk-pmc-atom.c: In function 'plt_clk_is_enabled':
   include/linux/kernel.h:850:48: warning: initialization from incompatible pointer type [enabled by default]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clk/x86/clk-pmc-atom.c:51:25: note: in expansion of macro 'container_of'
    #define to_clk_plt(_hw) container_of(_hw, struct clk_plt, hw)
                            ^
   drivers/clk/x86/clk-pmc-atom.c:148:24: note: in expansion of macro 'to_clk_plt'
     struct clk_plt *clk = to_clk_plt(hw);
                           ^
   include/linux/kernel.h:850:48: warning: (near initialization for 'clk') [enabled by default]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clk/x86/clk-pmc-atom.c:51:25: note: in expansion of macro 'container_of'
    #define to_clk_plt(_hw) container_of(_hw, struct clk_plt, hw)
                            ^
   drivers/clk/x86/clk-pmc-atom.c:148:24: note: in expansion of macro 'to_clk_plt'
     struct clk_plt *clk = to_clk_plt(hw);
                           ^
   drivers/clk/x86/clk-pmc-atom.c: At top level:
>> drivers/clk/x86/clk-pmc-atom.c:156:21: error: variable 'plt_clk_ops' has initializer but incomplete type
    static const struct clk_ops plt_clk_ops = {
                        ^
>> drivers/clk/x86/clk-pmc-atom.c:157:2: error: unknown field 'enable' specified in initializer
     .enable = plt_clk_enable,
     ^
>> drivers/clk/x86/clk-pmc-atom.c:157:2: warning: excess elements in struct initializer [enabled by default]
   drivers/clk/x86/clk-pmc-atom.c:157:2: warning: (near initialization for 'plt_clk_ops') [enabled by default]
>> drivers/clk/x86/clk-pmc-atom.c:158:2: error: unknown field 'disable' specified in initializer
     .disable = plt_clk_disable,
     ^
   drivers/clk/x86/clk-pmc-atom.c:158:2: warning: excess elements in struct initializer [enabled by default]
   drivers/clk/x86/clk-pmc-atom.c:158:2: warning: (near initialization for 'plt_clk_ops') [enabled by default]
>> drivers/clk/x86/clk-pmc-atom.c:159:2: error: unknown field 'is_enabled' specified in initializer
     .is_enabled = plt_clk_is_enabled,
     ^
   drivers/clk/x86/clk-pmc-atom.c:159:2: warning: excess elements in struct initializer [enabled by default]
   drivers/clk/x86/clk-pmc-atom.c:159:2: warning: (near initialization for 'plt_clk_ops') [enabled by default]
>> drivers/clk/x86/clk-pmc-atom.c:160:2: error: unknown field 'get_parent' specified in initializer
     .get_parent = plt_clk_get_parent,
     ^
   drivers/clk/x86/clk-pmc-atom.c:160:2: warning: excess elements in struct initializer [enabled by default]
   drivers/clk/x86/clk-pmc-atom.c:160:2: warning: (near initialization for 'plt_clk_ops') [enabled by default]
>> drivers/clk/x86/clk-pmc-atom.c:161:2: error: unknown field 'set_parent' specified in initializer
     .set_parent = plt_clk_set_parent,
     ^
   drivers/clk/x86/clk-pmc-atom.c:161:2: warning: excess elements in struct initializer [enabled by default]
   drivers/clk/x86/clk-pmc-atom.c:161:2: warning: (near initialization for 'plt_clk_ops') [enabled by default]
>> drivers/clk/x86/clk-pmc-atom.c:162:2: error: unknown field 'determine_rate' specified in initializer
     .determine_rate = __clk_mux_determine_rate,
     ^
>> drivers/clk/x86/clk-pmc-atom.c:162:20: error: '__clk_mux_determine_rate' undeclared here (not in a function)
     .determine_rate = __clk_mux_determine_rate,
                       ^
   drivers/clk/x86/clk-pmc-atom.c:162:2: warning: excess elements in struct initializer [enabled by default]
     .determine_rate = __clk_mux_determine_rate,
     ^
   drivers/clk/x86/clk-pmc-atom.c:162:2: warning: (near initialization for 'plt_clk_ops') [enabled by default]
   drivers/clk/x86/clk-pmc-atom.c: In function 'plt_clk_register':
>> drivers/clk/x86/clk-pmc-atom.c:171:23: error: storage size of 'init' isn't known
     struct clk_init_data init;
                          ^
>> drivers/clk/x86/clk-pmc-atom.c:188:2: error: implicit declaration of function 'devm_clk_hw_register' [-Werror=implicit-function-declaration]
     ret = devm_clk_hw_register(&pdev->dev, &pclk->hw);
     ^
   drivers/clk/x86/clk-pmc-atom.c:171:23: warning: unused variable 'init' [-Wunused-variable]
     struct clk_init_data init;
                          ^
   drivers/clk/x86/clk-pmc-atom.c: In function 'plt_clk_register_fixed_rate':
>> drivers/clk/x86/clk-pmc-atom.c:221:2: error: implicit declaration of function 'clk_hw_register_fixed_rate' [-Werror=implicit-function-declaration]
     pclk->clk = clk_hw_register_fixed_rate(&pdev->dev, name, parent_name,
     ^
>> drivers/clk/x86/clk-pmc-atom.c:221:12: warning: assignment makes pointer from integer without a cast [enabled by default]
     pclk->clk = clk_hw_register_fixed_rate(&pdev->dev, name, parent_name,
               ^
>> drivers/clk/x86/clk-pmc-atom.c:228:3: error: implicit declaration of function 'clk_hw_unregister_fixed_rate' [-Werror=implicit-function-declaration]
      clk_hw_unregister_fixed_rate(pclk->clk);
      ^
   cc1: some warnings being treated as errors

vim +/hw +44 drivers/clk/x86/clk-pmc-atom.c

    38	struct clk_plt_fixed {
    39		struct clk_hw *clk;
    40		struct clk_lookup *lookup;
    41	};
    42	
    43	struct clk_plt {
  > 44		struct clk_hw hw;
    45		void __iomem *reg;
    46		struct clk_lookup *lookup;
    47		/* protect access to PMC registers */
    48		spinlock_t lock;
    49	};
    50	
  > 51	#define to_clk_plt(_hw) container_of(_hw, struct clk_plt, hw)
    52	
    53	struct clk_plt_data {
    54		struct clk_plt_fixed **parents;
    55		u8 nparents;
    56		struct clk_plt *clks[PMC_CLK_NUM];
    57	};
    58	
    59	/* Return an index in parent table */
    60	static inline int plt_reg_to_parent(int reg)
    61	{
    62		switch (reg & PMC_MASK_CLK_FREQ) {
    63		default:
    64		case PMC_CLK_FREQ_XTAL:
    65			return 0;
    66		case PMC_CLK_FREQ_PLL:
    67			return 1;
    68		}
    69	}
    70	
    71	/* Return clk index of parent */
    72	static inline int plt_parent_to_reg(int index)
    73	{
    74		switch (index) {
    75		default:
    76		case 0:
    77			return PMC_CLK_FREQ_XTAL;
    78		case 1:
    79			return PMC_CLK_FREQ_PLL;
    80		}
    81	}
    82	
    83	/* Abstract status in simpler enabled/disabled value */
    84	static inline int plt_reg_to_enabled(int reg)
    85	{
    86		switch (reg & PMC_MASK_CLK_CTL) {
    87		case PMC_CLK_CTL_GATED_ON_D3:
    88		case PMC_CLK_CTL_FORCE_ON:
    89			return 1;	/* enabled */
    90		case PMC_CLK_CTL_FORCE_OFF:
    91		case PMC_CLK_CTL_RESERVED:
    92		default:
    93			return 0;	/* disabled */
    94		}
    95	}
    96	
    97	static void plt_clk_reg_update(struct clk_plt *clk, u32 mask, u32 val)
    98	{
    99		u32 tmp;
   100		unsigned long flags;
   101	
   102		spin_lock_irqsave(&clk->lock, flags);
   103	
   104		tmp = readl(clk->reg);
   105		tmp = (tmp & ~mask) | (val & mask);
   106		writel(tmp, clk->reg);
   107	
   108		spin_unlock_irqrestore(&clk->lock, flags);
   109	}
   110	
   111	static int plt_clk_set_parent(struct clk_hw *hw, u8 index)
   112	{
   113		struct clk_plt *clk = to_clk_plt(hw);
   114	
   115		plt_clk_reg_update(clk, PMC_MASK_CLK_FREQ, plt_parent_to_reg(index));
   116	
   117		return 0;
   118	}
   119	
   120	static u8 plt_clk_get_parent(struct clk_hw *hw)
   121	{
   122		struct clk_plt *clk = to_clk_plt(hw);
   123		u32 value;
   124	
   125		value = readl(clk->reg);
   126	
   127		return plt_reg_to_parent(value);
   128	}
   129	
   130	static int plt_clk_enable(struct clk_hw *hw)
   131	{
   132		struct clk_plt *clk = to_clk_plt(hw);
   133	
   134		plt_clk_reg_update(clk, PMC_MASK_CLK_CTL, PMC_CLK_CTL_FORCE_ON);
   135	
   136		return 0;
   137	}
   138	
   139	static void plt_clk_disable(struct clk_hw *hw)
   140	{
   141		struct clk_plt *clk = to_clk_plt(hw);
   142	
   143		plt_clk_reg_update(clk, PMC_MASK_CLK_CTL, PMC_CLK_CTL_FORCE_OFF);
   144	}
   145	
   146	static int plt_clk_is_enabled(struct clk_hw *hw)
   147	{
 > 148		struct clk_plt *clk = to_clk_plt(hw);
   149		u32 value;
   150	
   151		value = readl(clk->reg);
   152	
   153		return plt_reg_to_enabled(value);
   154	}
   155	
 > 156	static const struct clk_ops plt_clk_ops = {
 > 157		.enable = plt_clk_enable,
 > 158		.disable = plt_clk_disable,
 > 159		.is_enabled = plt_clk_is_enabled,
 > 160		.get_parent = plt_clk_get_parent,
 > 161		.set_parent = plt_clk_set_parent,
 > 162		.determine_rate = __clk_mux_determine_rate,
   163	};
   164	
   165	static struct clk_plt *plt_clk_register(struct platform_device *pdev, int id,
   166						void __iomem *base,
   167						const char **parent_names,
   168						int num_parents)
   169	{
   170		struct clk_plt *pclk;
 > 171		struct clk_init_data init;
   172		int ret;
   173	
   174		pclk = devm_kzalloc(&pdev->dev, sizeof(*pclk), GFP_KERNEL);
   175		if (!pclk)
   176			return ERR_PTR(-ENOMEM);
   177	
   178		init.name =  kasprintf(GFP_KERNEL, "%s_%d", PLT_CLK_NAME_BASE, id);
   179		init.ops = &plt_clk_ops;
   180		init.flags = 0;
   181		init.parent_names = parent_names;
   182		init.num_parents = num_parents;
   183	
   184		pclk->hw.init = &init;
   185		pclk->reg = base + PMC_CLK_CTL_OFFSET + id * PMC_CLK_CTL_SIZE;
   186		spin_lock_init(&pclk->lock);
   187	
 > 188		ret = devm_clk_hw_register(&pdev->dev, &pclk->hw);
   189		if (ret) {
   190			pclk = ERR_PTR(ret);
   191			goto err_free_init;
   192		}
   193	
   194		pclk->lookup = clkdev_hw_create(&pclk->hw, init.name, NULL);
   195		if (!pclk->lookup) {
   196			pclk = ERR_PTR(-ENOMEM);
   197			goto err_free_init;
   198		}
   199	
   200	err_free_init:
   201		kfree(init.name);
   202		return pclk;
   203	}
   204	
   205	static void plt_clk_unregister(struct clk_plt *pclk)
   206	{
   207		clkdev_drop(pclk->lookup);
   208	}
   209	
   210	static struct clk_plt_fixed *plt_clk_register_fixed_rate(struct platform_device *pdev,
   211							 const char *name,
   212							 const char *parent_name,
   213							 unsigned long fixed_rate)
   214	{
   215		struct clk_plt_fixed *pclk;
   216	
   217		pclk = devm_kzalloc(&pdev->dev, sizeof(*pclk), GFP_KERNEL);
   218		if (!pclk)
   219			return ERR_PTR(-ENOMEM);
   220	
 > 221		pclk->clk = clk_hw_register_fixed_rate(&pdev->dev, name, parent_name,
   222						       0, fixed_rate);
   223		if (IS_ERR(pclk->clk))
   224			return ERR_CAST(pclk->clk);
   225	
   226		pclk->lookup = clkdev_hw_create(pclk->clk, name, NULL);
   227		if (!pclk->lookup) {
 > 228			clk_hw_unregister_fixed_rate(pclk->clk);
   229			return ERR_PTR(-ENOMEM);
   230		}
   231	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--PNTmBPCT7hxwcZjr
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--PNTmBPCT7hxwcZjr--
