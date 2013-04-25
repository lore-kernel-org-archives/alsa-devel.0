From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2 2/4] ASoC: imx-sgtl5000: Let the code
 clock be a mandatory binding
Date: Thu, 25 Apr 2013 22:35:24 +0800
Message-ID: <20130425143522.GA7504@S2101-09.ap.freescale.net>
References: <1366815286-31820-1-git-send-email-festevam@gmail.com>
 <1366815286-31820-2-git-send-email-festevam@gmail.com>
 <20130425051654.GB1389@S2101-09.ap.freescale.net>
 <20130425110127.GR5019@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 by alsa0.perex.cz (Postfix) with ESMTP id CBB87265E17
 for <alsa-devel@alsa-project.org>; Thu, 25 Apr 2013 16:36:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130425110127.GR5019@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Fabio Estevam <festevam@gmail.com>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 25, 2013 at 12:01:27PM +0100, Mark Brown wrote:
> On Thu, Apr 25, 2013 at 01:16:55PM +0800, Shawn Guo wrote:
> > On Wed, Apr 24, 2013 at 11:54:44AM -0300, Fabio Estevam wrote:
> 
> > > - Rebased against Shawn's tree and remove mx53qsb clock fix, as it was already
> > > applied on Shawn's tree
> 
> > It seems that you expect the patch to go via my tree?  In that case, I
> > need Mark's ACK.
> 
> Well, it's a bit late for ARM changes to go in so I guess it'll be
> sorted out after the merge window anyway and can be applied to the
> ASoC tree after that?

Even worse.  The dependant patches in my tree are 3.11 material.

Shawn
