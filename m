From: "Patel, Chintan M" <chintan.m.patel@intel.com>
Subject: Re: [PATCH] ASoC: Intel: Skylake: Decrease loglevel
 for	topology loading
Date: Thu, 14 Sep 2017 18:53:39 +0000
Message-ID: <074180B186AC2945B61C466FE6C478304ADB15B2@ORSMSX103.amr.corp.intel.com>
References: <1505246098-10366-1-git-send-email-chintan.m.patel@intel.com>
 <s5htw07lk4s.wl-tiwai@suse.de>
 <074180B186AC2945B61C466FE6C478304ADB093B@ORSMSX103.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id EA2F0266986
 for <alsa-devel@alsa-project.org>; Thu, 14 Sep 2017 20:53:41 +0200 (CEST)
In-Reply-To: <074180B186AC2945B61C466FE6C478304ADB093B@ORSMSX103.amr.corp.intel.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: 'Takashi Iwai' <tiwai@suse.de>
Cc: "'alsa-devel@alsa-project.org'" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Please ignore this patch.
I have submitted another patch.

Sorry for noise, was submitting first time here 

-----Original Message-----
From: Patel, Chintan M 
Sent: Tuesday, September 12, 2017 2:47 PM
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
Subject: RE: [alsa-devel] [PATCH] ASoC: Intel: Skylake: Decrease loglevel for topology loading

Hmm ... you are right. KERN_INFO make sense. 
Will re-submit it.


-----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de]
Sent: Tuesday, September 12, 2017 1:47 PM
To: Patel, Chintan M <chintan.m.patel@intel.com>
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] [PATCH] ASoC: Intel: Skylake: Decrease loglevel for topology loading

On Tue, 12 Sep 2017 21:54:58 +0200,
Chintan Patel wrote:
> 
> In case of failure in loading customize topology firmware, dfw_sst.bin 
> gets loaded. However, current log provides this message as error even 
> after successfully falling back to default topology "dfw_sst.bin".
> 
> Hence to convey proper message, changing log level and message.

Is KERN_WARN the right level?  I feel KERN_INFO suffices, since this is no error but the right behavior, after all.

Or is this an unexpected scenario that should be fixed in user side?
In that case, KERN_WARN would be OK.


thanks,

Takashi

> Signed-off-by: Chintan Patel <chintan.m.patel@intel.com>
> ---
>  sound/soc/intel/skylake/skl-topology.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/skylake/skl-topology.c
> b/sound/soc/intel/skylake/skl-topology.c
> index 22f768ca3c73..14dafa9f5b35 100644
> --- a/sound/soc/intel/skylake/skl-topology.c
> +++ b/sound/soc/intel/skylake/skl-topology.c
> @@ -3404,7 +3404,7 @@ int skl_tplg_init(struct snd_soc_platform 
> *platform, struct hdac_ext_bus *ebus)
>  
>  	ret = request_firmware(&fw, skl->tplg_name, bus->dev);
>  	if (ret < 0) {
> -		dev_err(bus->dev, "tplg fw %s load failed with %d\n",
> +		dev_warn(bus->dev, "tplg fw %s load failed with %d, falling back to 
> +dfw_sst.bin",
>  				skl->tplg_name, ret);
>  		ret = request_firmware(&fw, "dfw_sst.bin", bus->dev);
>  		if (ret < 0) {
> --
> 1.9.1
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
