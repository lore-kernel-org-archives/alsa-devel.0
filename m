From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] Fix debugfs_create_dir's error checking
	method for sound/soc/
Date: Fri, 17 Oct 2008 14:23:42 +0100
Message-ID: <20081017132340.GF2546@sirena.org.uk>
References: <48F88D77.2080106@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 50DDF24355
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Oct 2008 15:24:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48F88D77.2080106@cn.fujitsu.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Zhaolei <zhaolei@cn.fujitsu.com>
Cc: alsa-devel@alsa-project.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 17, 2008 at 09:04:55PM +0800, Zhaolei wrote:

> debugfs_create_dir() returns NULL if an error occurs, returns -ENODEV
> when debugfs is not enabled in the kernel.

...

>  	asoc_debugfs = debugfs_create_dir("asoc", NULL);
> -	if (!IS_ERR(asoc_debugfs))
> +	if (!IS_ERR(asoc_debugfs) && asoc_debugfs)
>  		debugfs_create_u32("dapm_pop_time", 0744, asoc_debugfs,
>  				   &pop_time);

Hrmpf.  This looks like something that should be fixed in debugfs -
using both error reporting strategies is rather unhelpful and we're
actually loosing information in the case where debugfs is built.  I'll
send a patch and see what people thing.

Still in the meantime,

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
