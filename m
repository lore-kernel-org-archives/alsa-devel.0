From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: soc-jack: Fix checking return value
 of request_any_context_irq
Date: Mon, 15 Aug 2011 22:29:07 +0900
Message-ID: <20110815132905.GG3927@opensource.wolfsonmicro.com>
References: <1313234101.23974.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4223A2462E
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Aug 2011 15:29:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1313234101.23974.1.camel@phoenix>
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

On Sat, Aug 13, 2011 at 07:15:01PM +0800, Axel Lin wrote:
> request_any_context_irq() returns a negative value on failure.
> On success, it returns either IRQC_IS_HARDIRQ or IRQC_IS_NESTED.

Applied, thanks.
