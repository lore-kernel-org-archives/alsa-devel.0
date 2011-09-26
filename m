From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Drop exporting sn95031_get_mic_bias
Date: Mon, 26 Sep 2011 09:58:46 +0100
Message-ID: <20110926085845.GB2946@opensource.wolfsonmicro.com>
References: <1316859375.11157.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3CD132451D
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Sep 2011 10:58:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1316859375.11157.2.camel@phoenix>
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
Cc: Vinod Koul <vinod.koul@linux.intel.com>, Harsha Priya <priya.harsha@intel.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Sep 24, 2011 at 06:16:15PM +0800, Axel Lin wrote:
> sn95031_get_mic_bias() is not used outside this driver
> and it is a static function now.
> Thus drop exporting sn95031_get_mic_bias.

Applied, thanks.
