From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/12] sound/alsa/soc/codec: fix memory leak
 and resource relaim in error path
Date: Thu, 15 Jul 2010 09:59:32 +0100
Message-ID: <20100715085932.GA23529@rakim.wolfsonmicro.main>
References: <1279162147.29294.2.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 99F1C1038E9
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Jul 2010 10:59:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1279162147.29294.2.camel@mola>
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
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 15, 2010 at 10:49:07AM +0800, Axel Lin wrote:

> [PATCH 1/12] ad1836: fix a memory leak if another ad1836 is registered
> [PATCH 2/12] ak4642: fix a memory leak if failed to initialise AK4642
> [PATCH 3/12] da7210: fix a memory leak if failed to initialise da7210 audio codec
> [PATCH 4/12] wm8523: fix resource reclaim in wm8523_register error path
> [PATCH 5/12] wm8711: fix a memory leak if another WM8711 is registered
> [PATCH 6/12] wm8904: fix resource reclaim in wm8904_register error path
> [PATCH 7/12] wm8940: fix resource reclaim in wm8940_register error path
> [PATCH 8/12] wm8955: fix resource reclaim in wm8955_register error path
> [PATCH 9/12] wm8961: fix resource reclaim in wm8961_register error path
> [PATCH 10/12] wm8974: fix a memory leak if another WM8974 is registered
> [PATCH 11/12] wm8978: fix a memory leak if another WM8978 is registered
> [PATCH 12/12] wm9081: fix resource reclaim in wm9081_register error path

If you're going to be submiting large batches of small patches like this
it would be really helpful if you could make sure you format the subject
lines for your patches so that they match the standards for the area of
the kernel you're updating.  This makes them much easier to apply.
