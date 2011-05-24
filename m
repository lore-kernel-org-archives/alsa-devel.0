From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: core - fix module reference counting
	for CPU DAIs
Date: Tue, 24 May 2011 23:25:54 +0800
Message-ID: <20110524152553.GF7945@opensource.wolfsonmicro.com>
References: <1306241863-3985-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 74433243AA
	for <alsa-devel@alsa-project.org>;
	Tue, 24 May 2011 17:25:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1306241863-3985-1-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, May 24, 2011 at 01:57:43PM +0100, Liam Girdwood wrote:
> Currently CODEC and platform drivers have their module reference count
> incremented soc_probe_dai_link() whilst CPU DAI drivers have their reference
> count incremented in soc_bind_dai_link().
> 
> CPU DAIs should have their reference count incremented in soc_probe_dai_link()
> just like the CODEC and platform drivers.

Applied, thanks.
