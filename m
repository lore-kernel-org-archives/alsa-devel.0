From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/9] ASoC: sh: fsi: make sure
 fsi_stream_push/pop access by spin lock
Date: Tue, 24 May 2011 18:39:14 +0800
Message-ID: <20110524103913.GA4661@opensource.wolfsonmicro.com>
References: <w3pipt17i99.wl%kuninori.morimoto.gx@renesas.com>
	<w3pd3j97i7u.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E49F9103850
	for <alsa-devel@alsa-project.org>;
	Tue, 24 May 2011 12:39:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <w3pd3j97i7u.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: yoshii <takashi.yoshii.zj@renesas.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, May 23, 2011 at 08:46:13PM +0900, Kuninori Morimoto wrote:
> fsi_stream_push/pop might be called in same time.
> This patch protect it.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This one looks like a bug fix which should be done in 2.6.40 also?  If
that is the case could you please also provide a version of this patch
against 2.6.40.
