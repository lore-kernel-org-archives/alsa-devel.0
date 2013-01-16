From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: SND_SOC_DAIFMT_NB_NF become 0 as
	default settings
Date: Wed, 16 Jan 2013 20:28:34 +0900
Message-ID: <20130116112832.GC25480@opensource.wolfsonmicro.com>
References: <877gne6kvh.wl%kuninori.morimoto.gx@renesas.com>
 <20130116010417.GA15503@opensource.wolfsonmicro.com>
 <87y5ft69rn.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 94A232625EA
 for <alsa-devel@alsa-project.org>; Wed, 16 Jan 2013 12:37:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <87y5ft69rn.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 15, 2013 at 08:18:23PM -0800, Kuninori Morimoto wrote:
> Current soc-dai.h defines SND_SOC_DAIFMT_NB_NF as (1 << 8),
> but normal bit clock / normal frame should be
> default settings (= 0).
> This patch fixup SND_SOC_DAIFMT_NB_NF as (0 << 8).

Applied, thanks.
