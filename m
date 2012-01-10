From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Return proper error if
	i2c_add_driver fails
Date: Tue, 10 Jan 2012 18:53:40 +0000
Message-ID: <20120110185340.GH7164@opensource.wolfsonmicro.com>
References: <1326185690.28549.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 11FFE103AD0
	for <alsa-devel@alsa-project.org>; Tue, 10 Jan 2012 19:53:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1326185690.28549.1.camel@phoenix>
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
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 10, 2012 at 04:54:50PM +0800, Axel Lin wrote:

>  #endif
> -	return 0;
> +	return ret;

No, if we've got multiple bus types we do ignore the error in case one
of the buses failed (and if we were doing this then we'd need to clean
up the thing that successfully registered).   If we've not got multiple
bus types then the ifdefs shouldn't be there and we should just have a
trivial call to the registration function.
