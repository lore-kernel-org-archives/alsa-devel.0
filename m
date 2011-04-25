From: Simon Horman <simon@horms.net>
Subject: Re: [PATCH 1/3 v2] ASoC: sh: fsi: add
	fsi_is_clk_master function
Date: Tue, 26 Apr 2011 07:42:37 +0900
Message-ID: <20110425224236.GH16405@verge.net.au>
References: <w3poc40ie2r.wl%kuninori.morimoto.gx@renesas.com>
	<w3pmxjkie1b.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from kirsty.vergenet.net (kirsty.vergenet.net [202.4.237.240])
	by alsa0.perex.cz (Postfix) with ESMTP id D342C10380E
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Apr 2011 00:42:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <w3pmxjkie1b.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: yoshii <takashi.yoshii.zj@renesas.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Magnus <magnus.damm@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 21, 2011 at 10:33:36AM +0900, Kuninori Morimoto wrote:
> If FSI port is clock master, it use set_rate function
> which is callback from platform,
> and it is not necessary to call it if FSI port is clock slave.
> Current FSI driver called this callback if platform provide it.
> This patch modify it.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Hi Morimoto-san,

Thanks for the improved description.

Reviewed-by: Simon Horman <simon@horms.net>
