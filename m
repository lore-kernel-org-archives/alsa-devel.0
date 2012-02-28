From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH v2 00/10] OMAP/ASoC: Move and merge McBSP driver under
 ASoC
Date: Tue, 28 Feb 2012 21:32:16 +0200
Message-ID: <4F4D2BC0.5010501@bitmer.com>
References: <1330414820-4641-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1330414820-4641-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Grazvydas Ignotas <notasas@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 02/28/2012 09:40 AM, Peter Ujfalusi wrote:
> Hello,
> 
> Changes since v1 (RFC series):
> - removed pm_runtime_get/put_sync calls since core takes care of this.
>   Fixes the initial issue with OMAP3 Pandora setup reported by Grazvydas Ignotas
> - Dropped my version of snd_soc_add_dai_controls from the series since Liam
>   implementation adds the same functionality.
> - Added Tested-by tags from Janusz (OMAP1), and Grazvydas (OMAP3 pandora)
> - Added Ack from Tony for the arch/arm/ patches
> - I have not added Ack from Mark, and Jarkko although they said it looks OK, but
>   not given explicit ack for the series.
> 
I'm sending a minor comment to 1/10 but here's ack to whole series

Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
