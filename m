From: Harald Welte <laforge@openmoko.org>
Subject: Re: [PATCH] s3c24xx-pcm: fix hw_params dma handling
Date: Tue, 24 Jul 2007 17:41:12 +0800
Message-ID: <20070724094112.GR7335@prithivi.gnumonks.org>
References: <854pjufade.fsf@Orfeo.duckcorp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 50B7924346
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Jul 2007 11:41:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <854pjufade.fsf@Orfeo.duckcorp.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: alsa-devel@alsa-project.org, gg@opensource.wolfsonmicro.com, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 24, 2007 at 10:56:29AM +0200, Arnaud Patard wrote:
 
> While testing the recently merged driver for the neo1973, I found out
> that it was not working due to dma allocation failure. The problem is
> that there's only one dma channel available on s3c2410 and there may be
> more than one call to pcm_ops->hw_params(), resulting in dma request
> failures. This patch from Harald Welte fix this.
> 
Thanks for picking up that one, Arnaud!  I didn't submit this myself
since it was just a 'quick fix' and I don't understand enough about ALSA
to be sure that this really is the proper fix...

-- 
- Harald Welte <laforge@openmoko.org>          	        http://openmoko.org/
============================================================================
Software for the world's first truly open Free Software mobile phone
