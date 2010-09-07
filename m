From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/5] fbdev: sh_mobile_hdmi: add new label
 for sound error path
Date: Tue, 7 Sep 2010 10:59:08 +0100
Message-ID: <20100907095908.GB7886@rakim.wolfsonmicro.main>
References: <w3pvd6i6ois.wl%kuninori.morimoto.gx@renesas.com>
	<w3ppqwq6ofp.wl%kuninori.morimoto.gx@renesas.com>
	<Pine.LNX.4.64.1009070912140.1345@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5FD5F24491
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Sep 2010 11:59:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1009070912140.1345@axis700.grange>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 07, 2010 at 09:13:57AM +0200, Guennadi Liakhovetski wrote:
> On Tue, 7 Sep 2010, Kuninori Morimoto wrote:

> > Reported-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

> You have not addressed all of my comments to your sh_mobile_hdmi.c patch 

Please do this Morimoto-san - if you wish to leave things for addressing
on a subsequent patch series then just note that in your covering mail
or similar.

> and you have not explained, why you do not address them. On the whole, I 
> am still in favour of reverting that original patch and redoing it.

It would seem like we'd make more progress if the two of you could both
work on incrementally fixing the problems with the current code rather
than blocking its inclusion totally.
