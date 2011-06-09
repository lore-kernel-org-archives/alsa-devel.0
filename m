From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: snd_soc_new_{mixer, mux,
 pga} make sure to use right DAPM context
Date: Thu, 9 Jun 2011 15:08:03 +0100
Message-ID: <20110609140802.GF12865@opensource.wolfsonmicro.com>
References: <1307618556-32068-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1695C103B52
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Jun 2011 16:08:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1307618556-32068-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: stable@kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 09, 2011 at 01:22:36PM +0200, Lars-Peter Clausen wrote:
> Currently it is possible that snd_soc_new_{mixer,mux,pga} is called with a
> DAPM context not matching the widgets context. This can lead to a wrong
> prefix_len calculation, which will result in undefined behaviour. To avoid
> this always use the DAPM context from the widget itself.

Applied, thanks.
