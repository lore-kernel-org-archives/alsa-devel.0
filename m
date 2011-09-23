From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Remove unneeded mutex_init in
	wl1273_probe()
Date: Fri, 23 Sep 2011 11:54:32 +0100
Message-ID: <20110923105432.GF3165@opensource.wolfsonmicro.com>
References: <1316754658.3012.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B02F424159
	for <alsa-devel@alsa-project.org>;
	Fri, 23 Sep 2011 12:54:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1316754658.3012.3.camel@phoenix>
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
Cc: Matti Aaltonen <matti.j.aaltonen@nokia.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 23, 2011 at 01:10:57PM +0800, Axel Lin wrote:
> Since f0fba2ad "ASoC: multi-component - ASoC Multi-Component Support",
> snd_soc_register_codec() now does all the codec list and mutex init.
> Thus don't need to call mutex_init(&codec->mutex) in wl1273_probe() any more.

Applied, thanks.
