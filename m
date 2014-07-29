From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [alsa-devel] [PATCH v2] ASoC: wm8962: Let CODEC driver enable
 and disable its own MCLK
Date: Tue, 29 Jul 2014 10:55:19 +0800
Message-ID: <20140729025518.GB3350@MrMyself>
References: <1406547718-21498-1-git-send-email-nicoleotsuka@gmail.com>
 <20140728122211.GS17528@sirena.org.uk>
 <CAOMZO5DgE9RjC9MG7FbGPKwsgxunntw70W6Sj8WQKFYG+j8BsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOMZO5DgE9RjC9MG7FbGPKwsgxunntw70W6Sj8WQKFYG+j8BsA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, patches@opensource.wolfsonmicro.com, b02247@freescale.com, linux-kernel <linux-kernel@vger.kernel.org>, Nicolin Chen <b42378@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 28, 2014 at 03:19:43PM -0300, Fabio Estevam wrote:
> Hi Nicolin,
> 
> On Mon, Jul 28, 2014 at 9:22 AM, Mark Brown <broonie@kernel.org> wrote:
> > On Mon, Jul 28, 2014 at 07:41:58PM +0800, Nicolin Chen wrote:
> >
> >> +     pdata->mclk = devm_clk_get(&i2c->dev, NULL);
> >> +
> >
> > This is broken for deferred probe.

Hi Mark,

Sorry. I don't get why deferred probe would be broken by this.
And I just took a test by adding this:

[...]
@@ -3545,10 +3545,11 @@ static int wm8962_set_pdata_from_of(struct i2c_client *i2c,
	}

+bool letstry = true;
static int wm8962_i2c_probe(struct i2c_client *i2c,
			const struct i2c_device_id *id)
@@ -3573,10 +3574,15 @@ static int wm8962_i2c_probe(struct i2c_client *i2c,
		ret = wm8962_set_pdata_from_of(i2c, &wm8962->pdata);
		if (ret != 0)
			return ret;
	}
+       if (letstry) {
+               letstry = false;
+               return -EPROBE_DEFER;
+       }
	/* Mark the mclk pointer to NULL if no mclk assigned */
	if (IS_ERR(wm8962->pdata.mclk))
		wm8962->pdata.mclk = NULL;
[...]

And it still works for me with a deferred probe:

[] i2c 0-001a: Driver wm8962 requests probe deferral
[]...
[]wm8962 0-001a: customer id 0 revision D
[]input: WM8962 Beep Generator as /devices/soc0/soc/2100000......
[]fsl-asoc-card sound: wm8962 <-> 202c000.ssi mapping ok

> 
> You can take a look at sgtl5000 to see how we handle deferred probe in
> devm_clk_get().

Hi Fabio,

Thank you for the hint.

But actually, unlike sgtl5000, this patch doesn't error out for
IS_ERR(mclk) case.

There might be a machine driver that has already got and enabled
the clock while getting the clock from other way or other DT node
rather than WM8962's.

Thank you.
Nicolin
