From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: Convert tegra_spdif to use
 module_platform_driver()
Date: Mon, 28 Nov 2011 22:12:34 +0000
Message-ID: <20111128221234.GB11252@opensource.wolfsonmicro.com>
References: <1322477637.1939.3.camel@phoenix> <1322477703.1939.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 185DE2453B
	for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2011 23:12:38 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1322477703.1939.4.camel@phoenix>
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
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 28, 2011 at 06:55:03PM +0800, Axel Lin wrote:
> Use the module_platform_driver() macro which makes
> the code smaller and a bit simpler.

Applied, thanks.
