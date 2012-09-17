From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 02/34] ASoC: mx27vis: retrieve gpio numbers
 from platform_data
Date: Mon, 17 Sep 2012 07:07:42 -0400
Message-ID: <20120917110741.GD5401@opensource.wolfsonmicro.com>
References: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
 <1347860103-4141-3-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 94E482625C6
 for <alsa-devel@alsa-project.org>; Mon, 17 Sep 2012 13:07:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1347860103-4141-3-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Sascha Hauer <s.hauer@pengutronix.de>, Rob Herring <rob.herring@calxeda.com>, Javier Martin <javier.martin@vista-silicon.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 17, 2012 at 01:34:31PM +0800, Shawn Guo wrote:

I've applied this since Javier says it fixes a bug but I'm not terribly
enthused about it.

>  arch/arm/mach-imx/mach-imx27_visstrim_m10.c |   42 ++++++++++++++++++++++++++-
>  include/linux/platform_data/asoc-mx27vis.h  |   11 +++++++
>  sound/soc/fsl/mx27vis-aic32x4.c             |   42 +++++++++++++--------------

Audio drivers put their platform data in include/sound.

>  3 files changed, 72 insertions(+), 23 deletions(-)

This also seems like we're just going to be going for bloat, given that
this is a general change we should be (finally) getting round to having
a generic GPIO based CODEC driver.
