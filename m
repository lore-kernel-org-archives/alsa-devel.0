From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Fix snd_soc_instantiate_card error
	path
Date: Tue, 07 Dec 2010 12:38:42 +0000
Message-ID: <1291725522.3275.16.camel@odin>
References: <1291712762.4776.11.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 1FB98103828
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2010 13:38:46 +0100 (CET)
Received: by wyi11 with SMTP id 11so13318706wyi.38
	for <alsa-devel@alsa-project.org>; Tue, 07 Dec 2010 04:38:45 -0800 (PST)
In-Reply-To: <1291712762.4776.11.camel@mola>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-12-07 at 17:06 +0800, Axel Lin wrote:
> >From 0443551476ee6fabe45a0fbc7460dca8e0f6a965 Mon Sep 17 00:00:00 2001
> From: Axel Lin <axel.lin@gmail.com>
> Date: Tue, 7 Dec 2010 16:12:29 +0800
> Subject: [PATCH] ASoC: Fix snd_soc_instantiate_card error path
> 
> Properly free the resources in the case of snd_card_register failure
> and soc_register_ac97_dai_link failure.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

> ---
> 
> This patch is against linux-next tree.
> 
> In the case of soc_register_ac97_dai_link failure,
> I think we need below fix for Linus's tree:
> Add 
> while (--i >= 0)
> 	soc_unregister_ac97_dai_link(&card->rtd[i]);
> just before goto probe_dai_err;
> Should I also send a patch against Linus's tree?
> 

Yes please.

Thanks

Liam
