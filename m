From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: writing an alsa driver
Date: Mon, 15 Jun 2015 18:04:28 +0100
Message-ID: <1434387868.2434.50.camel@loki>
References: <20150527201320.GA309@asus> <1432812668.2726.18.camel@loki>
 <20150528125325.GA418@asus> <1432819294.2726.33.camel@loki>
 <20150528191721.GA608@asus> <1432892521.2732.14.camel@loki>
 <20150529131753.GA339@asus> <1433156768.2642.21.camel@loki>
 <20150608084951.GA7512@dellaz> <loom.20150613T153708-781@post.gmane.org>
 <20150615164623.GA693@asus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id D811626527F
 for <alsa-devel@alsa-project.org>; Mon, 15 Jun 2015 19:04:50 +0200 (CEST)
In-Reply-To: <20150615164623.GA693@asus>
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

+ Vinod,

On Mon, 2015-06-15 at 18:46 +0200, Michele Curti wrote:
> On Sat, Jun 13, 2015 at 01:47:13PM +0000, Luka Karinja wrote:
> > Hey guys i have a T100TAF which also has z3735f & rt5648 and 
> > watching your development.
> > 
> > On the T100TA wich has the Z3740 and rt5645 a new /var/lib/alsa/asound.state
> > was needed to get the sound working.
> > It was making cracking sounds without it (saw in your previous post)
> > found here:
> > https://raw.githubusercontent.com/AdamWill/baytrail-m/master/alsa/t100_B.state
> > 
> > Eagerly following the development
> 
> Eheh :)
> 
> So far no news, sadly.
> 

We are also a little suspicious that this laptop is using SSP1 for the
I2S audio connection to the codec. The bad news is that the FW used by
this BYT ADSP driver does not support the SSP1 port. It's hard coded to
use SSP0 (Jarrko, please correct the port numbering if it's wrong).
There are going to be no further releases of this FW.

However, the other upstream BYT ADSP driver from Vinod's team is going
to support the other SSP ports. It currently only supports SSP0, but I
believe that a new FW will be released soon that will support SSP1.
Vinod do you know the new FW release date ?

Michele, can you change your machine driver to use the Vinods BYT DSP
PCM driver (base it on bytcr_rt5640.c). Please test probing/booting with
the current FW release from Vinod too. That way you should be ready to
integrate the new FW when it is released. Please also CC Vinod on any
issues you have getting the FW to boot using the new driver/FW.

Thanks

Liam
