From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: writing an alsa driver
Date: Thu, 04 Jun 2015 11:33:37 +0100
Message-ID: <1433414017.19747.36.camel@loki>
References: <20150527085440.GA4445@dellaz> <1432752116.8235.25.camel@loki>
 <20150527201320.GA309@asus> <1432812668.2726.18.camel@loki>
 <20150528125325.GA418@asus> <1432819294.2726.33.camel@loki>
 <20150528191721.GA608@asus> <1432892521.2732.14.camel@loki>
 <20150529131753.GA339@asus> <1433156768.2642.21.camel@loki>
 <20150604085933.GA8494@dellaz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id BB5452606A9
 for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2015 12:33:48 +0200 (CEST)
In-Reply-To: <20150604085933.GA8494@dellaz>
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
Cc: Takashi Iwai <tiwai@suse.de>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, "Nikula, Jarkko" <jarkko.nikula@intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2015-06-04 at 10:59 +0200, Michele Curti wrote:
> I'm back now from a period of limited internet access, I tried to
> change the
> irqindex_host_ipc to 0 (like the others platforms)
> 
> diff --git a/sound/soc/intel/common/sst-acpi.c
> b/sound/soc/intel/common/sst-acpi.c
> index 42f293f..7cc64e3 100644
> --- a/sound/soc/intel/common/sst-acpi.c
> +++ b/sound/soc/intel/common/sst-acpi.c
> @@ -258,7 +258,7 @@ static struct sst_acpi_desc sst_acpi_baytrail_desc
> = {
>         .resindex_lpe_base = 0,
>         .resindex_pcicfg_base = 1,
>         .resindex_fw_base = 2,
> -       .irqindex_host_ipc = 5,
> +       .irqindex_host_ipc = 0,
>         .sst_id = SST_DEV_ID_BYT,
>         .resindex_dma_base = -1,
>  };
> 
> and the sound card showed up.  So I tried to play a bit with alsamixer
> and got
> some cracking noise.
> 
> Tried to play some songs but a song of 4 minutes finished in about a
> dozen of
> seconds..  Maybe the clocks are not correctly configured..
> 
> After a while I smelt a smell of burnt components and the chassis near
> the
> speakers was hot like hell.  Shutdown the laptop.
> 
> Now I'm not sure the hardware is damaged, after a couple of hours I
> tried to
> reboot and got a (strange) beep during boot, so maybe I was lucky..
> 
> Anyway, now I removed the change.

The speakers are probably being over powered so best to make sure with
alsamixer that all the gains are low or muted and all unused
inputs/outputs are muted or off before playing any audio. You can then
gradually increase the volume to the desired level. 

Liam
