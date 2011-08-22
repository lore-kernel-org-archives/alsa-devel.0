From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/4] sound/soc/ep93xx/ep93xx-i2s.c: add
	missing kfree
Date: Mon, 22 Aug 2011 23:29:53 +0100
Message-ID: <20110822222953.GC30609@opensource.wolfsonmicro.com>
References: <1313820761-12042-2-git-send-email-julia@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8CD962433D
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Aug 2011 00:29:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1313820761-12042-2-git-send-email-julia@diku.dk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Julia Lawall <julia@diku.dk>
Cc: alsa-devel@alsa-project.org, Ryan Mallon <rmallon@gmail.com>, Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, H Hartley Sweeten <hsweeten@visionengravers.com>, Alexander Sverdlin <subaparts@yandex.ru>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Aug 20, 2011 at 08:12:39AM +0200, Julia Lawall wrote:
> From: Julia Lawall <julia@diku.dk>
> 
> Introduce a new label that includes kfree and jump to that one.

Applied, thanks.
