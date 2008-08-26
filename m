From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add WM8903 CODEC driver
Date: Tue, 26 Aug 2008 14:43:55 +0100
Message-ID: <20080826134355.GA7393@rakim.wolfsonmicro.main>
References: <1219752327-5704-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20080826152856.01187982@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C7A47246E6
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Aug 2008 15:43:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080826152856.01187982@hyperion.delvare>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 26, 2008 at 03:28:56PM +0200, Jean Delvare wrote:
> On Tue, 26 Aug 2008 13:05:27 +0100, Mark Brown wrote:

> > +static struct i2c_client *wm8903_i2c_device;

> I know that I am the one who came up with this idea, but on second
> thought, wm8903_i2c_device will always be equal to
> wm8903_socdev->codec->control_data, so we can easily do without it.

That'll teach me to listen to subsystem maintainers :)  I'll send a
patch either later today or tomorrow.

> > +	ret = i2c_add_driver(&wm8903_i2c_driver);
> > +	if (ret != 0) {
> > +		dev_err(&pdev->dev, "can't add i2c driver");

> Missing \n at end of string (looks like many other drivers have this
> problem - I found 11 other cases under sound/soc, I can send a patch
> fixing these if you want.)

That'd be great if you could.

> > +		board_info.addr = setup->i2c_address;
> > +
> > +		adapter = i2c_get_adapter(setup->i2c_bus);
> > +		if (!adapter) {
> > +			dev_err(&pdev->dev, "Can't get I2C bus %d\n",
> > +				setup->i2c_bus);
> > +			goto err_adapter;

> You are jumping to the error path but ret has value 0. This means that
> the function returns success when you really mean failure, and trouble
> is likely to arise after that.

Yeah, I'll fix this too - thanks.
