From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ALSA: hda - Fix memory leak on
	snd_hdac_device_init error
Date: Thu, 9 Nov 2017 10:14:19 +0530
Message-ID: <20171109044419.GD3187@localhost>
References: <20171109032751.20573-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id E9446266F1C
 for <alsa-devel@alsa-project.org>; Thu,  9 Nov 2017 05:41:09 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20171109032751.20573-1-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Guneshwor Singh <guneshwor.o.singh@intel.com>
Cc: ALSA ML <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Patches Audio <patches.audio@intel.com>, Mark Brown <broonie@kernel.org>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 09, 2017 at 08:57:51AM +0530, Guneshwor Singh wrote:
> From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
> 
> Free codec vendor name on snd_hdac_device_init error.
> 
> Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
> Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
> ---
>  sound/hda/hdac_device.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sound/hda/hdac_device.c b/sound/hda/hdac_device.c
> index 19deb306facb..467b949544e2 100644
> --- a/sound/hda/hdac_device.c
> +++ b/sound/hda/hdac_device.c
> @@ -111,6 +111,8 @@ int snd_hdac_device_init(struct hdac_device *codec, struct hdac_bus *bus,
>  	return 0;
>  
>   error:
> +	kfree(codec->vendor_name);

Sorry I dont think this is right.

The vendor name is freed in the snd_hdac_device_exit()

We drop the reference here and release method would be called to
free up the resources.

>  	put_device(&codec->dev);
>  	return err;
>  }
> -- 
> 2.15.0
> 

-- 
~Vinod
