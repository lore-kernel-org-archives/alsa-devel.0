From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2] ASoC: Intel: Skylake: Decrease loglevel
 for topology loading
Date: Mon, 16 Oct 2017 11:35:10 +0530
Message-ID: <20171016060510.GF30097@localhost>
References: <1507826678-25509-1-git-send-email-chintan.m.patel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id A979E266DCF
 for <alsa-devel@alsa-project.org>; Mon, 16 Oct 2017 08:00:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1507826678-25509-1-git-send-email-chintan.m.patel@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Chintan Patel <chintan.m.patel@intel.com>
Cc: alsa-devel@alsa-project.org, Dharageswari R <dharageswari.r@intel.com>, Takashi Sakamoto <takashi.sakamoto@miraclelinux.com>, linux-kernel@vger.kernel.org, "guneshwor.o.singh@intel.com" <guneshwor.o.singh@intel.com>, Takashi Iwai <tiwai@suse.com>, Ramesh Babu <ramesh.babu@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Shreyas NC <shreyas.nc@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 12, 2017 at 09:44:37AM -0700, Chintan Patel wrote:
> In case of failure in loading customize topology firmware, dfw_sst.bin
> gets loaded. However, current log provides this message as error even
> after successfully falling back to default topology "dfw_sst.bin".
> 
> Hence to convey proper message, changing log level and message.

Acked-By: Vinod Koul <vinod.koul@intel.com>

> Signed-off-by: Chintan Patel <chintan.m.patel@intel.com>
> ---
> Changes in v2:
> Addressing review comments from Takashi Iwai by changing
> loglevel as info
> 
> sound/soc/intel/skylake/skl-topology.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
> index 22f768ca3c73..12f383fd7c39 100644
> --- a/sound/soc/intel/skylake/skl-topology.c
> +++ b/sound/soc/intel/skylake/skl-topology.c
> @@ -3404,7 +3404,7 @@ int skl_tplg_init(struct snd_soc_platform *platform, struct hdac_ext_bus *ebus)
>  
>  	ret = request_firmware(&fw, skl->tplg_name, bus->dev);
>  	if (ret < 0) {
> -		dev_err(bus->dev, "tplg fw %s load failed with %d\n",
> +		dev_info(bus->dev, "tplg fw %s load failed with %d, falling back to dfw_sst.bin",
>  				skl->tplg_name, ret);
>  		ret = request_firmware(&fw, "dfw_sst.bin", bus->dev);
>  		if (ret < 0) {
> -- 
> 1.9.1
> 

-- 
~Vinod
