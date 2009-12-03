From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: sh_fsi: avoid using global
	variable
Date: Thu, 3 Dec 2009 10:59:09 +0000
Message-ID: <20091203105909.GD13165@rakim.wolfsonmicro.main>
References: <umy21zz0j.wl%morimoto.kuninori@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0E8481038A1
	for <alsa-devel@alsa-project.org>; Thu,  3 Dec 2009 11:59:10 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <umy21zz0j.wl%morimoto.kuninori@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 02, 2009 at 03:11:08PM +0900, Kuninori Morimoto wrote:
> Current FSI driver use global variable to access device data.
> But this style will be broken
> if SuperH come with multiple FSI blocks in future.
> To solve this problem, this patch use cpu_dai->private_data.

Applied, thanks.
