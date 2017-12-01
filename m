From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 2/4] ASoC: hdac_hdmi: Refresh sysfs during
 hdmi device probe
Date: Fri, 1 Dec 2017 10:25:42 +0530
Message-ID: <20171201045541.GJ32417@localhost>
References: <20171128111021.11830-1-guneshwor.o.singh@intel.com>
 <20171128111021.11830-3-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id ED06B267B70
 for <alsa-devel@alsa-project.org>; Fri,  1 Dec 2017 05:52:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20171128111021.11830-3-guneshwor.o.singh@intel.com>
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
Cc: ALSA ML <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Puneeth Prabhu <puneethx.prabhu@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Patches Audio <patches.audio@intel.com>, Mark Brown <broonie@kernel.org>, "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 28, 2017 at 04:40:19PM +0530, Guneshwor Singh wrote:

> diff --git a/sound/soc/codecs/hdac_hdmi.c b/sound/soc/codecs/hdac_hdmi.c
> index f3b4f4dfae6a..7e689cbc75ae 100644
> --- a/sound/soc/codecs/hdac_hdmi.c
> +++ b/sound/soc/codecs/hdac_hdmi.c
> @@ -2046,6 +2046,7 @@ static int hdac_hdmi_dev_probe(struct hdac_ext_device *edev)
>  			"Failed in parse and map nid with err: %d\n", ret);
>  		return ret;
>  	}
> +	snd_hdac_refresh_widget_sysfs(codec);

Guneshwor pointed that this was changed recently by Takashi, so this needs
to add second arg and resent.

-- 
~Vinod
