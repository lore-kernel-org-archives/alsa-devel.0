From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/2] ASoC: Intel: board: Add Geminilake
	platform support
Date: Tue, 18 Jul 2017 13:41:06 +0530
Message-ID: <20170718081105.GR3053@localhost>
References: <1500304529-25804-1-git-send-email-pradeep.d.tewani@intel.com>
 <1500304529-25804-2-git-send-email-pradeep.d.tewani@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 5AA09266C40
 for <alsa-devel@alsa-project.org>; Tue, 18 Jul 2017 10:08:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1500304529-25804-2-git-send-email-pradeep.d.tewani@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pradeep Tewani <pradeep.d.tewani@intel.com>
Cc: tiwai@suse.de, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 17, 2017 at 08:45:28PM +0530, Pradeep Tewani wrote:

> +static struct snd_soc_card geminilake_rt298 = {
> +	.name = "geminilake-rt298",
> +	.owner = THIS_MODULE,

Do we need this, i though core set it up?

>  static int broxton_audio_probe(struct platform_device *pdev)
>  {
>  	struct bxt_rt286_private *ctx;
> +	struct snd_soc_card *card =
> +			(struct snd_soc_card *)pdev->id_entry->driver_data;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(broxton_rt298_dais); i++) {
> +		if (!strcmp(card->dai_link[i].codec_name, "i2c-INT343A:00")) {
> +			if (!strcmp(card->name, "broxton-rt298")) {

can we use strncmp pls

-- 
~Vinod
