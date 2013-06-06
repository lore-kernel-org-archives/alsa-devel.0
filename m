From: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH 1/2] ASoC: WM8962: Create default platform
	data structure
Date: Thu, 6 Jun 2013 11:21:26 +0800
Message-ID: <20130606032125.GA18783@MrMyself>
References: <cover.1370433363.git.b42378@freescale.com>
 <4e85e3a9b5dfdc04899958424eb53a9cfd0f4ace.1370433363.git.b42378@freescale.com>
 <20130605122511.GB31367@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 by alsa0.perex.cz (Postfix) with ESMTP id E144C265503
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2013 05:27:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130605122511.GB31367@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, rob.herring@calxeda.com, grant.likely@linaro.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 05, 2013 at 01:25:11PM +0100, Mark Brown wrote:
> On Wed, Jun 05, 2013 at 08:12:55PM +0800, Nicolin Chen wrote:
> 
> >  struct wm8962_priv {
> > +	struct wm8962_pdata *pdata;
> 
> More idiomatic style for this is to just embed a copy of the platform
> data struct in the private data then copy any driver model platform data
> on top of it.  This simplifies usage as now the driver can assume that
> there is platform data available at all times.

Hmm..sorry I don't fully get it. Does that mean I should do something like:
struct wm8962_priv {
	struct wm8962_pdata pdata;

instead of pointer? so no devm_kzalloc() for it any more?
