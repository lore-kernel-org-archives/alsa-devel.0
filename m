From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: ak4642: fixup cache register table
Date: Thu, 13 Oct 2011 11:58:53 +0100
Message-ID: <20111013105852.GF5193@opensource.wolfsonmicro.com>
References: <1318335653.3573.1.camel@phoenix>
	<87ty7dl0uh.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3898A10385F
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Oct 2011 12:58:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <87ty7dl0uh.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Axel Lin <axel.lin@gmail.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 13, 2011 at 02:03:54AM -0700, Kuninori Morimoto wrote:
> ak4642 register was 8bit, but cache table was defined as 16bit.
> ak4642 doesn't work correctry without this patch.

Applied, thanks.
