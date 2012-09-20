From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 02/34] ASoC: mx27vis: retrieve gpio numbers
 from platform_data
Date: Wed, 19 Sep 2012 21:26:05 -0400
Message-ID: <20120920012605.GD17666@opensource.wolfsonmicro.com>
References: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
 <1347860103-4141-3-git-send-email-shawn.guo@linaro.org>
 <20120917110741.GD5401@opensource.wolfsonmicro.com>
 <20120920011456.GC2450@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AD91F26525E
 for <alsa-devel@alsa-project.org>; Thu, 20 Sep 2012 04:04:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20120920011456.GC2450@S2101-09.ap.freescale.net>
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

On Thu, Sep 20, 2012 at 09:14:59AM +0800, Shawn Guo wrote:
> On Mon, Sep 17, 2012 at 07:07:42AM -0400, Mark Brown wrote:

> > I've applied this since Javier says it fixes a bug but I'm not terribly
> > enthused about it.

> Ok.  But now we have a cross-tree dependency.  Please ensure your
> for-3.7 branch is stable, so that I can ask arm-soc folks to pull
> it as dependency of my series.  Or you need to create a topic branch
> for this patch.

What's the dependency here?
