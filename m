From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH 3/6] ASoC: fsl_ssi: enable AC'97 asymmetric
	rates
Date: Sun, 28 Jun 2015 09:01:50 -0500
Message-ID: <558FFE4E.703@tabi.org>
References: <558FFAC4.2060608@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by alsa0.perex.cz (Postfix) with ESMTP id DBAD1264FEB
 for <alsa-devel@alsa-project.org>; Sun, 28 Jun 2015 16:01:52 +0200 (CEST)
In-Reply-To: <558FFAC4.2060608@maciej.szmigiero.name>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>, Takashi Iwai <tiwai@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

Maciej S. Szmigiero wrote:
>   	/* Are the RX and the TX clocks locked? */
>   	if (!of_find_property(np, "fsl,ssi-asynchronous", NULL)) {
> -		ssi_private->cpu_dai_drv.symmetric_rates = 1;
> +		if (!fsl_ssi_is_ac97(ssi_private))
> +			ssi_private->cpu_dai_drv.symmetric_rates = 1;
> +

Is this necessary?  Why not just add fsl,ssi-asynchronous to the AC97 
device tree node?
