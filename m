From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: Re: [ASoC] Fix: Revert 'ASoC: imx-ssi: Remove mono support'.
Date: Mon, 3 Sep 2012 13:16:38 -0300
Message-ID: <5044D7E6.5070901@freescale.com>
References: <1346660831-9662-1-git-send-email-javier.martin@vista-silicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1346660831-9662-1-git-send-email-javier.martin@vista-silicon.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martin <javier.martin@vista-silicon.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, festevam@gmail.com, broonie@opensource.wolfsonmicro.com, gcembed@gmail.com, s.hauer@pengutronix.de
List-Id: alsa-devel@alsa-project.org

Hi Javier,

Javier Martin wrote:
> The following commit should be reverted: 0865a75d4166bddc533fd50831829ceefb94f9b0
> 
> The bug this patch is meant to solve doesn't occur in Visstrim_M10 boards.
> Furthermore, after applying this patch sound in Visstrim_M10 is played
> at slower rates.

Acked-by: Fabio Estevam <fabio.estevam@freescale.com>

Sorry for breaking this.

Ok, I managed to fix the original issue inside the mc13783 codec driver and just sent a patch.

Thanks,

Fabio Estevam
