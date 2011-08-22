From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: soc-core: use GFP_KERNEL flag for
 kmalloc in snd_soc_cnew
Date: Mon, 22 Aug 2011 23:29:37 +0100
Message-ID: <20110822222935.GA30609@opensource.wolfsonmicro.com>
References: <1313809425.4691.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6FD7924337
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Aug 2011 00:29:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1313809425.4691.3.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Aug 20, 2011 at 11:03:44AM +0800, Axel Lin wrote:
> GFP_ATOMIC is not needed here, use GFP_KERNEL instead.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Applied, thanks.
