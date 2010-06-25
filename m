From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: ak4642: Add ak4642_fill_cache
	function
Date: Fri, 25 Jun 2010 12:43:08 +0100
Message-ID: <20100625114307.GC21217@opensource.wolfsonmicro.com>
References: <w3pvd97k0nb.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 00E821039D4
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Jun 2010 13:43:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <w3pvd97k0nb.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 25, 2010 at 04:54:32PM +0900, Kuninori Morimoto wrote:
> ak4642 driver is used for ak4642/ak4643.
> So, reading real register value is better than using constant value.

Better yet would be to just select the appropriate set of register
defaults based on the device being used at system startup - that way the
driver gets the benefits of the default table (eg, reducing the number
of writes done at system startup and resume) and doesn't need to delay
boot to read the full register map.
