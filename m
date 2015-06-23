From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: writing an alsa driver
Date: Tue, 23 Jun 2015 10:51:49 +0100
Message-ID: <1435053109.7747.30.camel@loki>
References: <20150528125325.GA418@asus> <1432819294.2726.33.camel@loki>
 <20150528191721.GA608@asus> <1432892521.2732.14.camel@loki>
 <20150529131753.GA339@asus> <1433156768.2642.21.camel@loki>
 <20150608084951.GA7512@dellaz> <loom.20150613T153708-781@post.gmane.org>
 <20150615164623.GA693@asus> <1434387868.2434.50.camel@loki>
 <20150623090932.GA6856@dellaz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id A70952654CC
 for <alsa-devel@alsa-project.org>; Tue, 23 Jun 2015 11:53:21 +0200 (CEST)
In-Reply-To: <20150623090932.GA6856@dellaz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Michele Curti <michele.curti@gmail.com>
Cc: Luka Karinja <luka.karinja@gmail.com>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, "Koul, Vinod" <vinod.koul@intel.com>, "Nikula,
 Jarkko" <jarkko.nikula@intel.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2015-06-23 at 11:09 +0200, Michele Curti wrote:
> On Mon, Jun 15, 2015 at 06:04:28PM +0100, Liam Girdwood wrote:
> > Michele, can you change your machine driver to use the Vinods BYT DSP
> > PCM driver (base it on bytcr_rt5640.c). Please test probing/booting with
> > the current FW release from Vinod too. That way you should be ready to
> > integrate the new FW when it is released. Please also CC Vinod on any
> > issues you have getting the FW to boot using the new driver/FW.
> >
> 
> Hi,
> an update, thanks to Vinod now the driver compiles enabling only the (new)
> CONFIG_SND_SOC_INTEL_BYTCR_RT5645_MACH option.
> 
> The sound card shows up:
> [zio@asus ~]$ aplay -l
> **** List of PLAYBACK Hardware Devices ****
> card 0: baytrailcraudio [baytrailcraudio], device 0: Baytrail Audio (*) []
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
> 
> There are a lot of errors about missing backend dai:
> [    7.195570]  Baytrail Audio Port: ASoC: no backend DAIs enabled for Baytrail Audio Port

This usually means that no DAPM route has been configured to route the
audio from the PCM FE to the BE DAI link. Can you check your mixer
settings with alsamixer and make sure a route exists. The DSP is in
between the FE and BE so it's the DSP mixers that would need to be
configured.

Btw, there is some debugFS files to help display the routing status for
each widget so this can be used to check your DAPM DSP driver graph.

Liam
