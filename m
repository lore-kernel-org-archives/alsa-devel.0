From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: issue of shdma-base library
Date: Tue, 9 Oct 2012 15:46:46 +0900
Message-ID: <20121009064643.GR8237@opensource.wolfsonmicro.com>
References: <506A7E48.3060701@jinso.co.jp>
 <Pine.LNX.4.64.1210031414080.26201@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5366C2615CF
 for <alsa-devel@alsa-project.org>; Tue,  9 Oct 2012 08:46:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1210031414080.26201@axis700.grange>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Shimoda Yoshihiro <yoshihiro.shimoda.uh@renesas.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Morimoto Kuninori <kuninori.morimoto.gx@renesas.com>, "Do Q.Thang" <dq-thang@jinso.co.jp>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 03, 2012 at 02:33:50PM +0200, Guennadi Liakhovetski wrote:
> Subject: [PATCH] ASoC: fsi: don't reschedule DMA from an atomic context
> 
> shdma doesn't support transfer re-scheduling or triggering from callbacks 
> or from atomic context. The fsi driver issues DMA transfers from a tasklet 
> context, which is a bug. To fix it convert tasklet to a work.

Applied, thanks.
