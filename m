From: "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>
Subject: Re: [asoc:for-4.21 60/62]
 sound/soc/amd/raven/pci-acp3x.c:59:8: error: implicit declaration of
 function 'pci_enable_msi'
Date: Wed, 14 Nov 2018 15:14:45 +0000
Message-ID: <57cc12a7-430b-ec42-e431-77ed1e4fd628@amd.com>
References: <201811141104.JJ3qOyK0%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM05-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr720042.outbound.protection.outlook.com [40.107.72.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 46767267A61
 for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2018 16:14:49 +0100 (CET)
In-Reply-To: <201811141104.JJ3qOyK0%fengguang.wu@intel.com>
Content-Language: en-US
Content-ID: <0174683A4C183C4CB96E26E838C7C470@namprd12.prod.outlook.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, "kbuild-all@01.org" <kbuild-all@01.org>, Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>
List-Id: alsa-devel@alsa-project.org



On 14/11/18 9:01 AM, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-4.21
> head:   9d4b17efa51f3bb0918021090c09b0013039df00
> commit: 818ba93b0e9ed4a08cba575dd49c1391ef4b7776 [60/62] ASoC: amd: enable acp3x drivers build
> config: openrisc-allmodconfig (attached as .config)
> compiler: or1k-linux-gcc (GCC) 6.0.0 20160327 (experimental)
> reproduce:
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          git checkout 818ba93b0e9ed4a08cba575dd49c1391ef4b7776
>          # save the attached .config to linux build tree
>          make.cross ARCH=openrisc
> 
> All errors (new ones prefixed by >>):
> 
>     sound/soc/amd/raven/pci-acp3x.c: In function 'snd_acp3x_probe':
>>> sound/soc/amd/raven/pci-acp3x.c:59:8: error: implicit declaration of function 'pci_enable_msi' [-Werror=implicit-function-declaration]
>       ret = pci_enable_msi(pci);
>             ^~~~~~~~~~~~~~
>>> sound/soc/amd/raven/pci-acp3x.c:124:2: error: implicit declaration of function 'pci_disable_msi' [-Werror=implicit-function-declaration]
>       pci_disable_msi(pci);
>       ^~~~~~~~~~~~~~~
>     sound/soc/amd/raven/pci-acp3x.c: At top level:
>     sound/soc/amd/raven/pci-acp3x.c:161:1: warning: data definition has no type or storage class
>      module_pci_driver(acp3x_driver);
>      ^~~~~~~~~~~~~~~~~
>     sound/soc/amd/raven/pci-acp3x.c:161:1: error: type defaults to 'int' in declaration of 'module_pci_driver' [-Werror=implicit-int]
>     sound/soc/amd/raven/pci-acp3x.c:161:1: warning: parameter names (without types) in function declaration
>     sound/soc/amd/raven/pci-acp3x.c:154:26: warning: 'acp3x_driver' defined but not used [-Wunused-variable]
>      static struct pci_driver acp3x_driver  = {
>                               ^~~~~~~~~~~~
>     cc1: some warnings being treated as errors

Will fix the build errors.
-Vijendar


> 
> vim +/pci_enable_msi +59 sound/soc/amd/raven/pci-acp3x.c
> 
> e30d9128 Maruthi Srinivas Bayyavarapu 2018-11-12   30
> e30d9128 Maruthi Srinivas Bayyavarapu 2018-11-12   31  static int snd_acp3x_probe(struct pci_dev *pci,
> e30d9128 Maruthi Srinivas Bayyavarapu 2018-11-12   32  			   const struct pci_device_id *pci_id)
> e30d9128 Maruthi Srinivas Bayyavarapu 2018-11-12   33  {
> e30d9128 Maruthi Srinivas Bayyavarapu 2018-11-12   34  	int ret;
> 7894a7e7 Vijendar Mukunda             2018-11-12   35  	u32 addr, val;
> e30d9128 Maruthi Srinivas Bayyavarapu 2018-11-12   36  	struct acp3x_dev_data *adata;
> 7894a7e7 Vijendar Mukunda             2018-11-12   37  	struct platform_device_info pdevinfo;
> 7894a7e7 Vijendar Mukunda             2018-11-12   38  	unsigned int irqflags;
> e30d9128 Maruthi Srinivas Bayyavarapu 2018-11-12   39
> e30d9128 Maruthi Srinivas Bayyavarapu 2018-11-12   40  	if (pci_enable_device(pci)) {
> e30d9128 Maruthi Srinivas Bayyavarapu 2018-11-12   41  		dev_err(&pci->dev, "pci_enable_device failed\n");
> e30d9128 Maruthi Srinivas Bayyavarapu 2018-11-12   42  		return -ENODEV;
> e30d9128 Maruthi Srinivas Bayyavarapu 2018-11-12   43  	}
> e30d9128 Maruthi Srinivas Bayyavarapu 2018-11-12   44
> e30d9128 Maruthi Srinivas Bayyavarapu 2018-11-12   45  	ret = pci_request_regions(pci, "AMD ACP3x audio");
> e30d9128 Maruthi Srinivas Bayyavarapu 2018-11-12   46  	if (ret < 0) {
> e30d9128 Maruthi Srinivas Bayyavarapu 2018-11-12   47  		dev_err(&pci->dev, "pci_request_regions failed\n");
> e30d9128 Maruthi Srinivas Bayyavarapu 2018-11-12   48  		goto disable_pci;
> e30d9128 Maruthi Srinivas Bayyavarapu 2018-11-12   49  	}
> e30d9128 Maruthi Srinivas Bayyavarapu 2018-11-12   50
> e30d9128 Maruthi Srinivas Bayyavarapu 2018-11-12   51  	adata = devm_kzalloc(&pci->dev, sizeof(struct acp3x_dev_data),
> e30d9128 Maruthi Srinivas Bayyavarapu 2018-11-12   52  			     GFP_KERNEL);
> e30d9128 Maruthi Srinivas Bayyavarapu 2018-11-12   53  	if (!adata) {
> e30d9128 Maruthi Srinivas Bayyavarapu 2018-11-12   54  		ret = -ENOMEM;
> e30d9128 Maruthi Srinivas Bayyavarapu 2018-11-12   55  		goto release_regions;
> e30d9128 Maruthi Srinivas Bayyavarapu 2018-11-12   56  	}
> e30d9128 Maruthi Srinivas Bayyavarapu 2018-11-12   57
> 7894a7e7 Vijendar Mukunda             2018-11-12   58  	/* check for msi interrupt support */
> 7894a7e7 Vijendar Mukunda             2018-11-12  @59  	ret = pci_enable_msi(pci);
> 7894a7e7 Vijendar Mukunda             2018-11-12   60  	if (ret)
> 7894a7e7 Vijendar Mukunda             2018-11-12   61  		/* msi is not enabled */
> 7894a7e7 Vijendar Mukunda             2018-11-12   62  		irqflags = IRQF_SHARED;
> 7894a7e7 Vijendar Mukunda             2018-11-12   63  	else
> 7894a7e7 Vijendar Mukunda             2018-11-12   64  		/* msi is enabled */
> 7894a7e7 Vijendar Mukunda             2018-11-12   65  		irqflags = 0;
> 7894a7e7 Vijendar Mukunda             2018-11-12   66
> e30d9128 Maruthi Srinivas Bayyavarapu 2018-11-12   67  	addr = pci_resource_start(pci, 0);
> e30d9128 Maruthi Srinivas Bayyavarapu 2018-11-12   68  	adata->acp3x_base = ioremap(addr, pci_resource_len(pci, 0));
> e30d9128 Maruthi Srinivas Bayyavarapu 2018-11-12   69  	if (!adata->acp3x_base) {
> e30d9128 Maruthi Srinivas Bayyavarapu 2018-11-12   70  		ret = -ENOMEM;
> e30d9128 Maruthi Srinivas Bayyavarapu 2018-11-12   71  		goto release_regions;
> e30d9128 Maruthi Srinivas Bayyavarapu 2018-11-12   72  	}
> e30d9128 Maruthi Srinivas Bayyavarapu 2018-11-12   73  	pci_set_master(pci);
> e30d9128 Maruthi Srinivas Bayyavarapu 2018-11-12   74  	pci_set_drvdata(pci, adata);
> 7894a7e7 Vijendar Mukunda             2018-11-12   75
> 7894a7e7 Vijendar Mukunda             2018-11-12   76  	val = rv_readl(adata->acp3x_base + mmACP_I2S_PIN_CONFIG);
> 7894a7e7 Vijendar Mukunda             2018-11-12   77  	switch (val) {
> 7894a7e7 Vijendar Mukunda             2018-11-12   78  	case I2S_MODE:
> 7894a7e7 Vijendar Mukunda             2018-11-12   79  		adata->res = devm_kzalloc(&pci->dev,
> 7894a7e7 Vijendar Mukunda             2018-11-12   80  					  sizeof(struct resource) * 2,
> 7894a7e7 Vijendar Mukunda             2018-11-12   81  					  GFP_KERNEL);
> 7894a7e7 Vijendar Mukunda             2018-11-12   82  		if (!adata->res) {
> 7894a7e7 Vijendar Mukunda             2018-11-12   83  			ret = -ENOMEM;
> 7894a7e7 Vijendar Mukunda             2018-11-12   84  			goto unmap_mmio;
> 7894a7e7 Vijendar Mukunda             2018-11-12   85  		}
> 7894a7e7 Vijendar Mukunda             2018-11-12   86
> 7894a7e7 Vijendar Mukunda             2018-11-12   87  		adata->res[0].name = "acp3x_i2s_iomem";
> 7894a7e7 Vijendar Mukunda             2018-11-12   88  		adata->res[0].flags = IORESOURCE_MEM;
> 7894a7e7 Vijendar Mukunda             2018-11-12   89  		adata->res[0].start = addr;
> 7894a7e7 Vijendar Mukunda             2018-11-12   90  		adata->res[0].end = addr + (ACP3x_REG_END - ACP3x_REG_START);
> 7894a7e7 Vijendar Mukunda             2018-11-12   91
> 7894a7e7 Vijendar Mukunda             2018-11-12   92  		adata->res[1].name = "acp3x_i2s_irq";
> 7894a7e7 Vijendar Mukunda             2018-11-12   93  		adata->res[1].flags = IORESOURCE_IRQ;
> 7894a7e7 Vijendar Mukunda             2018-11-12   94  		adata->res[1].start = pci->irq;
> 7894a7e7 Vijendar Mukunda             2018-11-12   95  		adata->res[1].end = pci->irq;
> 7894a7e7 Vijendar Mukunda             2018-11-12   96
> 7894a7e7 Vijendar Mukunda             2018-11-12   97  		adata->acp3x_audio_mode = ACP3x_I2S_MODE;
> 7894a7e7 Vijendar Mukunda             2018-11-12   98
> 7894a7e7 Vijendar Mukunda             2018-11-12   99  		memset(&pdevinfo, 0, sizeof(pdevinfo));
> 7894a7e7 Vijendar Mukunda             2018-11-12  100  		pdevinfo.name = "acp3x_rv_i2s";
> 7894a7e7 Vijendar Mukunda             2018-11-12  101  		pdevinfo.id = 0;
> 7894a7e7 Vijendar Mukunda             2018-11-12  102  		pdevinfo.parent = &pci->dev;
> 7894a7e7 Vijendar Mukunda             2018-11-12  103  		pdevinfo.num_res = 2;
> 7894a7e7 Vijendar Mukunda             2018-11-12  104  		pdevinfo.res = adata->res;
> 7894a7e7 Vijendar Mukunda             2018-11-12  105  		pdevinfo.data = &irqflags;
> 7894a7e7 Vijendar Mukunda             2018-11-12  106  		pdevinfo.size_data = sizeof(irqflags);
> 7894a7e7 Vijendar Mukunda             2018-11-12  107
> 7894a7e7 Vijendar Mukunda             2018-11-12  108  		adata->pdev = platform_device_register_full(&pdevinfo);
> 7894a7e7 Vijendar Mukunda             2018-11-12  109  		if (!adata->pdev) {
> 7894a7e7 Vijendar Mukunda             2018-11-12  110  			dev_err(&pci->dev, "cannot register %s device\n",
> 7894a7e7 Vijendar Mukunda             2018-11-12  111  				pdevinfo.name);
> 7894a7e7 Vijendar Mukunda             2018-11-12  112  			ret = -ENODEV;
> 7894a7e7 Vijendar Mukunda             2018-11-12  113  			goto unmap_mmio;
> 7894a7e7 Vijendar Mukunda             2018-11-12  114  		}
> 7894a7e7 Vijendar Mukunda             2018-11-12  115  		break;
> 7894a7e7 Vijendar Mukunda             2018-11-12  116  	default:
> 7894a7e7 Vijendar Mukunda             2018-11-12  117  		dev_err(&pci->dev, "Inavlid ACP audio mode : %d\n", val);
> 7894a7e7 Vijendar Mukunda             2018-11-12  118  		ret = -ENODEV;
> 7894a7e7 Vijendar Mukunda             2018-11-12  119  		goto unmap_mmio;
> 7894a7e7 Vijendar Mukunda             2018-11-12  120  	}
> e30d9128 Maruthi Srinivas Bayyavarapu 2018-11-12  121  	return 0;
> e30d9128 Maruthi Srinivas Bayyavarapu 2018-11-12  122
> 7894a7e7 Vijendar Mukunda             2018-11-12  123  unmap_mmio:
> 7894a7e7 Vijendar Mukunda             2018-11-12 @124  	pci_disable_msi(pci);
> 7894a7e7 Vijendar Mukunda             2018-11-12  125  	iounmap(adata->acp3x_base);
> e30d9128 Maruthi Srinivas Bayyavarapu 2018-11-12  126  release_regions:
> e30d9128 Maruthi Srinivas Bayyavarapu 2018-11-12  127  	pci_release_regions(pci);
> e30d9128 Maruthi Srinivas Bayyavarapu 2018-11-12  128  disable_pci:
> e30d9128 Maruthi Srinivas Bayyavarapu 2018-11-12  129  	pci_disable_device(pci);
> e30d9128 Maruthi Srinivas Bayyavarapu 2018-11-12  130
> e30d9128 Maruthi Srinivas Bayyavarapu 2018-11-12  131  	return ret;
> e30d9128 Maruthi Srinivas Bayyavarapu 2018-11-12  132  }
> e30d9128 Maruthi Srinivas Bayyavarapu 2018-11-12  133
> 
> :::::: The code at line 59 was first introduced by commit
> :::::: 7894a7e7ea3de6c1fd5b2b43f3a73106c94ef584 ASoC: amd: create ACP3x PCM platform device
> 
> :::::: TO: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> :::::: CC: Mark Brown <broonie@kernel.org>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
