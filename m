From: =?ISO-8859-1?Q?P=E9ter_Ujfalusi?= <peter.ujfalusi@ti.com>
Subject: Re: [sound-unstable:topic/hda-spdif-fix 99/124] ERROR:
 "snd_dmaengine_pcm_open" [sound/soc/omap/snd-soc-omap.ko] undefined!
Date: Mon, 22 Oct 2012 11:10:21 +0200
Message-ID: <50850D7D.8050402@ti.com>
References: <5083733a.T3zEi6cLE4psrO1W%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id A26262651AF
 for <alsa-devel@alsa-project.org>; Mon, 22 Oct 2012 11:10:24 +0200 (CEST)
In-Reply-To: <5083733a.T3zEi6cLE4psrO1W%fengguang.wu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi,

On 10/21/2012 05:59 AM, Fengguang Wu wrote:
> Hi Peter,
> =

> FYI, kernel build failed on
> =

> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-unstabl=
e.git topic/hda-spdif-fix
> head:   afc51e492b36bd61b46f4d70dd646678d96f5f97
> commit: e7736cdea223f3a5b867c359fb35cf08250dd771 [99/124] dmaengine: Add =
flags parameter to dmaengine_prep_dma_cyclic()
> config: arm-omap2plus_defconfig # make ARCH=3Darm omap2plus_defconfig
> =

> All error/warnings:
> =

> ERROR: "snd_hwparams_to_dma_slave_config" [sound/soc/omap/snd-soc-omap.ko=
] undefined!
> ERROR: "snd_dmaengine_pcm_pointer" [sound/soc/omap/snd-soc-omap.ko] undef=
ined!
> ERROR: "snd_dmaengine_pcm_open" [sound/soc/omap/snd-soc-omap.ko] undefine=
d!
> ERROR: "snd_dmaengine_pcm_close" [sound/soc/omap/snd-soc-omap.ko] undefin=
ed!
> ERROR: "snd_dmaengine_pcm_get_chan" [sound/soc/omap/snd-soc-omap.ko] unde=
fined!
> ERROR: "snd_dmaengine_pcm_trigger" [sound/soc/omap/snd-soc-omap.ko] undef=
ined!

This has been fixed by the following commit (already in mainline):
961a7ae ASoC: dmaengine: Correct Makefile when sound is built as module

-- =

P=E9ter
