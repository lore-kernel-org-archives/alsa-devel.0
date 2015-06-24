From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: writing an alsa driver
Date: Wed, 24 Jun 2015 15:51:57 +0530
Message-ID: <20150624102157.GL19530@localhost>
References: <1432819294.2726.33.camel@loki> <20150528191721.GA608@asus>
 <1432892521.2732.14.camel@loki> <20150529131753.GA339@asus>
 <1433156768.2642.21.camel@loki> <20150608084951.GA7512@dellaz>
 <loom.20150613T153708-781@post.gmane.org>
 <20150615164623.GA693@asus> <1434387868.2434.50.camel@loki>
 <20150623090932.GA6856@dellaz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 8ACF0260536
 for <alsa-devel@alsa-project.org>; Wed, 24 Jun 2015 12:20:23 +0200 (CEST)
Content-Disposition: inline
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
Cc: Luka Karinja <luka.karinja@gmail.com>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>, "Nikula, Jarkko" <jarkko.nikula@intel.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 23, 2015 at 11:09:33AM +0200, Michele Curti wrote:
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
So in this driver we use DPCM, which means that you have to route Front End
to a BackEnd and then only you can open a device. Without linking to BE it
will fail

For Playback you can try:

#DSP routing
amixer -c0 sset 'codec_out0 mix 0 pcm0_in' on
amixer -c0 sset 'media0_out mix 0 media1_in' on
amixer -c0 sset 'media1_in Gain 0' 80% 
amixer -c0 sset 'media1_in Gain 0 Ramp Delay' 50
amixer -c0 sset 'media1_in Gain 0' off
amixer -c0 sset 'pcm0_in Gain 0' 80% 
amixer -c0 sset 'pcm0_in Gain 0 Ramp Delay' 50
amixer -c0 sset 'pcm0_in Gain 0' off
amixer -c0 sset 'codec_out0 Gain 0' 80%
amixer -c0 sset 'codec_out0 Gain 0 Ramp Delay' 50
amixer -c0 sset 'codec_out0 Gain 0' off

#Codec routin, if you have different one please modfiy
amixer -c0 sset "DAC MIXL INF1" on
amixer -c0 sset "DAC MIXR INF1" on
amixer -c0 sset "Stereo DAC MIXL DAC L1" on
amixer -c0 sset "Stereo DAC MIXR DAC R1" on
amixer -c0 sset "SPK MIXL DAC L1" on
amixer -c0 sset "SPK MIXR DAC R1" on
amixer -c0 sset "SPOL MIX SPKVOL L" on
amixer -c0 sset "SPOR MIX SPKVOL R" on
amixer -c0 sset "SPOL MIX DAC L1" on
amixer -c0 sset "SPOR MIX DAC R1" on
amixer -c0 sset "Speaker L" on
amixer -c0 sset "Speaker R" on
amixer -c0 sset "Headphone" off
amixer -c0 sset "Ext Spk" on

I have used this in T100.

-- 
~Vinod
