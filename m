From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [patch 8/9] SMDK6410: Add support for WM8731 on	an
	add-on board
Date: Wed, 4 Mar 2009 20:06:11 +0000
Message-ID: <20090304200609.GE7680@sirena.org.uk>
References: <20090304004925.530566010@fluff.org.uk>
	<20090304005139.317005352@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 4A992103880
	for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2009 21:06:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090304005139.317005352@fluff.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ben Dooks <ben-alsa@fluff.org>
Cc: Ben Dooks <benb@simtec.co.uk>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 04, 2009 at 12:49:33AM +0000, Ben Dooks wrote:
> Add support for an WM8731 connected to an SMDK6410 instead
> of the onboard codec.

> Signed-off-by: Ben Dooks <benb@simtec.co.uk>

Is there any plan to make this board generally available?  IIRC it was a
flying wire board rather than a plugin for the baseband connector on the
SMDK6410.  I'd prefer not to start merging flying wire systems since the
numbers tend to multiply (I do rather a lot myself!).

> +static void wm_shutdown(struct snd_pcm_substream *substream)
> +{
> +	printk(KERN_INFO "%s: substream %p\n", __func__, substream);
> +}

This and several of the other printks in the driver are a bit chatty...
pr_dbg()?

> +	//fmt = SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS;

C++ comment.

> +struct wm8731_setup_data wm_setup = {
> +	.i2c_bus	= 0,
> +	.i2c_address	= 0x1a,
> +};

This won't build with current git - the WM8731 has been refactored to
probe using the standard I2C registration stuff.  See the driver in
atmel/sam9g20_wm8731.c for an example, essentially all that needs doing
is to remove the struct here.
