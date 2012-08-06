From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: imx-ssi: Fix mono playback
Date: Mon, 6 Aug 2012 20:54:38 +0100
Message-ID: <20120806195438.GD16199@opensource.wolfsonmicro.com>
References: <1344281785-22478-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3C840265DDB
 for <alsa-devel@alsa-project.org>; Mon,  6 Aug 2012 21:24:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1344281785-22478-1-git-send-email-fabio.estevam@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: alsa-devel@alsa-project.org, kernel@pengutronix.de, gcembed@gmail.com
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 06, 2012 at 04:36:25PM -0300, Fabio Estevam wrote:
> Currently mono playback is played on a faster rate.
> 
> Adjust channels_min to 2 channels in order to play it back correctly.

This doesn't actually fix mono playback so much as remove support for
it...
