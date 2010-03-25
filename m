From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/4 v2] ASoC: fsi: Add FIFO size calculate
Date: Thu, 25 Mar 2010 16:04:27 +0000
Message-ID: <20100325160426.GA3025@rakim.wolfsonmicro.main>
References: <ubpecvh9k.wl%morimoto.kuninori@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8C97E24418
	for <alsa-devel@alsa-project.org>; Thu, 25 Mar 2010 17:04:30 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <ubpecvh9k.wl%morimoto.kuninori@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 25, 2010 at 07:15:51PM +0900, Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
> ---
> v1 -> v2
> 
> o move calculate area to fsi_fifo_init
> o modify fifo calculation way
> o Add tiny document for fifo calculation

This patch is fine but it doesn't apply against for-2.6.35.  Could you
please check and resubmit?  I suspect a collision with the previously
applied patches.
