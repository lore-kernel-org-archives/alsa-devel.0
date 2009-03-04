From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [patch 5/9] S3C: Split s3c2412-i2s.c into core	and
	SoC specific parts
Date: Wed, 4 Mar 2009 19:52:36 +0000
Message-ID: <20090304195235.GB7680@sirena.org.uk>
References: <20090304004925.530566010@fluff.org.uk>
	<20090304005138.875883650@fluff.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 07109103880
	for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2009 20:52:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090304005138.875883650@fluff.org.uk>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 04, 2009 at 12:49:30AM +0000, Ben Dooks wrote:

I'll apply this, just a few comments in passing (I'll probably fix these
up myself).

> The S3C2412 I2S (IIS) interface is replicated on further Samsung SoC
> parts in a broadly compatible way, so split the common code out into
> a core called s3c-i2s-v2.[ch] so that the newer SoCs such as the
> S3C6410 can make use of it.

> As such, all the original s3c2412 functions are currently being left
> with their original names, and will be renamed later in the series.

This does a bit more than the patch description says - it also adds bits
of code for S3C64xx.

> +#if S3C2412_I2S_DEBUG
> +#define DBG(x...) printk(KERN_INFO x)
> +#else
> +#define DBG(x...) do { } while (0)
> +#endif

This should be pr_dbg() (the original file had that fixed).

> +#define bit_set(v, b) (((v) & (b)) ? 1 : 0)

This feels like it should be in some standard header but it isn't.  Ho
hum.

> +	default:
> +		DBG("unknwon master/slave format\n");
> +		return -EINVAL;
> +	}

Should be an unconditional error message.

> +	default:
> +		DBG("Unknown data format\n");
> +		return -EINVAL;
> +	}

Ditto.
