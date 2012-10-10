From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: dmaengine: Correct Makefile when
 sound is built as module
Date: Wed, 10 Oct 2012 10:48:35 +0900
Message-ID: <20121010014820.GB17288@opensource.wolfsonmicro.com>
References: <1349083766-17076-1-git-send-email-peter.ujfalusi@ti.com>
 <20121009065836.GT8237@opensource.wolfsonmicro.com>
 <5073E93F.7090507@ti.com>
 <20121009090857.GD8237@opensource.wolfsonmicro.com>
 <5074239F.9050302@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 223A4264FF5
 for <alsa-devel@alsa-project.org>; Wed, 10 Oct 2012 03:56:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <5074239F.9050302@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 09, 2012 at 03:16:15PM +0200, P=E9ter Ujfalusi wrote:
> On 10/09/2012 11:08 AM, Mark Brown wrote:

> > What makes you believe that this is due to the code not being part of
> > the core module?

> the linker tells me.

No it doesn't.

> Without this patch with mainline kernel from today (I used tegra to see i=
f it
> happens there as well):

> [sound/soc/tegra/snd-soc-tegra-pcm.ko] undefined!
> ERROR: "snd_dmaengine_pcm_pointer" [sound/soc/tegra/snd-soc-tegra-pcm.ko]
> undefined!

> I guess it was due to the Kconfig/Makefile related to soc-dmaengine:

All the above is telling you is that if you make this change the error
goes away.  It doesn't explain what the problem is or why this change
fixes it.

> config SND_SOC_DMAENGINE_PCM
> 	bool

> snd-soc-dmaengine-pcm-objs :=3D soc-dmaengine-pcm.o
> obj-$(CONFIG_SND_SOC_DMAENGINE_PCM) +=3D snd-soc-dmaengine-pcm.o

> My guess is that in this way the soc-dmaengine-pcm.o would want itself to=
 be
> built in to the kernel but since the sound is in modules there is no plac=
e to
> link this part of the code.
> If I change the Kconfig from bool to tristate it will build

Indeed, so this is getting warmer.  The problem is that the way Kconfig
is set up is causing CONFIG_SND_SOC_DMAENGINE_PCM to come out as
something that doesn't get built as it's a bool selected by a module and
as you say one fix here is to make the dmaengine code a module by itself.

> snd-soc-dmaengine-pcm.ko but since the soc-dmaengine-pcm.c does not have
> module_init it is not really going to load.
> I might be wrong.

No, why would module_init() have anything to do with this?  Is there
something that needs to be run at startup for soc-dmaengine?
