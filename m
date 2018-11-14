From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: Tree for Nov 14 (sound/soc/amd/raven/)
Date: Wed, 14 Nov 2018 12:38:20 -0800
Message-ID: <746f93fc-84ec-88db-4a77-b2493d36b377@infradead.org>
References: <20181114162632.615933dd@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181114162632.615933dd@canb.auug.org.au>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Maruthi.Bayyavarapu@amd.com, moderated for non-subscribers <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 11/13/18 9:26 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20181113:
> 

on i386 or x86_64:
when CONFIG_PCI is not enabled.


../sound/soc/amd/raven/pci-acp3x.c: In function 'snd_acp3x_probe':
../sound/soc/amd/raven/pci-acp3x.c:59:2: error: implicit declaration of function 'pci_enable_msi' [-Werror=implicit-function-declaration]
  ret = pci_enable_msi(pci);
  ^
../sound/soc/amd/raven/pci-acp3x.c:124:2: error: implicit declaration of function 'pci_disable_msi' [-Werror=implicit-function-declaration]
  pci_disable_msi(pci);
  ^
../sound/soc/amd/raven/pci-acp3x.c: At top level:
../sound/soc/amd/raven/pci-acp3x.c:161:1: warning: data definition has no type or storage class [enabled by default]
 module_pci_driver(acp3x_driver);
 ^
../sound/soc/amd/raven/pci-acp3x.c:161:1: error: type defaults to 'int' in declaration of 'module_pci_driver' [-Werror=implicit-int]
../sound/soc/amd/raven/pci-acp3x.c:161:1: warning: parameter names (without types) in function declaration [enabled by default]
../sound/soc/amd/raven/pci-acp3x.c:154:26: warning: 'acp3x_driver' defined but not used [-Wunused-variable]
 static struct pci_driver acp3x_driver  = {
                          ^

config SND_SOC_AMD_ACP3x
	tristate "AMD Audio Coprocessor-v3.x support"
	help
	 This option enables ACP v3.x I2S support on AMD platform

Needs "depends on PCI"??


-- 
~Randy
