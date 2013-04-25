From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 2/2] ASoC: mxs-sgtl5000: Remove unneeded
 fields from snd_soc_dai_link
Date: Thu, 25 Apr 2013 13:24:50 +0800
Message-ID: <20130425052448.GF1389@S2101-09.ap.freescale.net>
References: <1366820595-19762-1-git-send-email-festevam@gmail.com>
 <1366820595-19762-2-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 by alsa0.perex.cz (Postfix) with ESMTP id 8BA23265D46
 for <alsa-devel@alsa-project.org>; Thu, 25 Apr 2013 07:24:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1366820595-19762-2-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, broonie@kernel.org, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 24, 2013 at 01:23:15PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> It makes no sense to hardcode the I2C bus into the codec_name field.
> 
> cpu_dai_name and platform_name are also overwritten later in 
> mxs_sgtl5000_probe_dt().
> 
> So remove the three fields, as mxs platform is dt-only platform.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Acked-by: Shawn Guo <shawn.guo@linaro.org>
