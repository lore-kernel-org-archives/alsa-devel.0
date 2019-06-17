From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [alsa-devel] [PATCH] ASoC: SOF: disallow building without
 CONFIG_PCI again
Date: Mon, 17 Jun 2019 15:57:50 +0200
Message-ID: <CAK8P3a381XbG8BGOPo3tN6+q2EzFU+9R9Q=q-uv=Mbf931bt=g@mail.gmail.com>
References: <20190617124632.1176809-1-arnd@arndb.de> <6103cc84-6af3-7b82-4cac-aea500934dd1@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6103cc84-6af3-7b82-4cac-aea500934dd1@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Kai Vehmanen <kai.vehmanen@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Zhu Yingjiang <yingjiang.zhu@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 17, 2019 at 3:52 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
> On 6/17/19 2:45 PM, Arnd Bergmann wrote:
> > Compile-testing without PCI just causes warnings:
> >
> > sound/soc/sof/sof-pci-dev.c:330:13: error: 'sof_pci_remove' defined but not used [-Werror=unused-function]
> >   static void sof_pci_remove(struct pci_dev *pci)
> >               ^~~~~~~~~~~~~~
> > sound/soc/sof/sof-pci-dev.c:230:12: error: 'sof_pci_probe' defined but not used [-Werror=unused-function]
> >   static int sof_pci_probe(struct pci_dev *pci,
> >              ^~~~~~~~~~~~~
> >
> > I tried to fix this in a way that would still allow compile
> > tests, but it got too ugly, so this just reverts the patch
> > that allowed it in the first place.
> >
> > Most architectures do allow enabling PCI, so the value of the
> > COMPILE_TEST alternative was not very high to start with.
>
> I think COMPILE_TEST has value in that it exposed issues in the PCI
> headers, and in general COMPILE_TEST exposes code that can be
> simplified/refactored. That said I don't have the time to suggest an
> alternative at the moment so it's fine with me if you want to revert. If
> you don't mind sharing your config it'd help me work on this when I get
> a chance.

I agree that fixing this in the pci headers would be best. Ideally we would
be able to compile-test PCI drivers without any #ifdef in the sources,
while ending up with an empty .o file as the compiler can discard all
local functions starting with an unused pci_driver.

I saw the error in a randconfig build, uploaded the .config to
https://pastebin.com/zBeyM41R now.

        Arnd
