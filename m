From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: WM8903: Implement DMIC support
Date: Fri, 14 Oct 2011 13:16:14 +0100
Message-ID: <20111014121614.GF2966@opensource.wolfsonmicro.com>
References: <1303181891-25064-1-git-send-email-swarren@nvidia.com>
	<1318588461.2686.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9CB85103836
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Oct 2011 14:16:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1318588461.2686.9.camel@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Julian Scheel <julian@jusst.de>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 14, 2011 at 12:34:21PM +0200, Julian Scheel wrote:

> actually the wm8903 codec needs GPIO1 and GPIO2 to be configured
> properly to be able to use DMIC actually. I would propose to
> automatically configure these to DMIC-mode whenever ADCINPUT is set to
> DMIC. Would you agree with this procedure?
> I would prepare a patch which changes all relevant registers then.

I'd go the other way and disable the DMIC support if the GPIOs aren't
configured appropriately in the platform data.  Since the DMIC is
selectable at runtime by random applications in most systems if it
forced the GPIOs into DMIC mode it could break functionality on systems
that don't actually have the DMIC wired up.  We've got code for this in
WM8962 for example.
