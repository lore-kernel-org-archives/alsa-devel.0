From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] ASoC: Davinci: pcm: add support for
 sram-support-less platforms
Date: Sat, 22 Sep 2012 11:33:14 -0400
Message-ID: <20120922153313.GN4495@opensource.wolfsonmicro.com>
References: <1346417459-30042-1-git-send-email-gururaja.hebbar@ti.com>
 <1346417459-30042-3-git-send-email-gururaja.hebbar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 727A026165F
 for <alsa-devel@alsa-project.org>; Sat, 22 Sep 2012 17:33:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1346417459-30042-3-git-send-email-gururaja.hebbar@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Cc: alsa-devel@alsa-project.org, sudhakar.raj@ti.com, tony@atomide.com, nsekhar@ti.com, davinci-linux-open-source@linux.davincidsp.com, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 31, 2012 at 06:20:58PM +0530, Hebbar, Gururaja wrote:

> +config SND_DAVINCI_HAVE_SRAM
> +	bool
> +	default y if ARCH_DAVINCI=y
> +	default n if ARCH_OMAP=y
> +

I've been sitting on this mostly since it seems like a step back from
multi-platform kernels (which is where we're trying to get to) and I've
been trying to decide what the best approach is.  I'm thinking that we
do want a generic API for allocating this stuff, it's a fairly generic
feature (there's TCMs as well).  

Adding ifdefs like this does just doesn't seem good.
