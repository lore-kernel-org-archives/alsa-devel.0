From: Simon Horman <simon@horms.net>
Subject: Re: [PATCH 2/3 v2] ASoC: sh: fsi: add dev_pm_ops ::
	suspend/resume
Date: Tue, 26 Apr 2011 07:44:13 +0900
Message-ID: <20110425224412.GI16405@verge.net.au>
References: <w3poc40ie2r.wl%kuninori.morimoto.gx@renesas.com>
	<w3pliz4ie10.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from kirsty.vergenet.net (kirsty.vergenet.net [202.4.237.240])
	by alsa0.perex.cz (Postfix) with ESMTP id A8C3510380E
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Apr 2011 00:44:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <w3pliz4ie10.wl%kuninori.morimoto.gx@renesas.com>
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

On Thu, Apr 21, 2011 at 10:33:47AM +0900, Kuninori Morimoto wrote:
> Current FSI driver sets important settings when probing.
> And it are not set again as long as driver is not bind again.
> This mean FSI driver will lost it from register
> if suspend/resume are happen.
> This patch save important settings for suspend/resume.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks Morimoto-san,

this looks correct to me.

Reviewed-by: Simon Horman <horms@verge.net.au>
