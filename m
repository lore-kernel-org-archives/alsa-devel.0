From: Oder Chiou <oder_chiou@realtek.com>
Subject: Re: [PATCH] ASoC: rt5677: Use specific r/w function
	for DSP mode
Date: Wed, 29 Oct 2014 01:44:57 +0000
Message-ID: <7EB0DE829A537248AF2ED30C97D12694F30527@RTITMBSV03.realtek.com.tw>
References: <1414378351-2329-1-git-send-email-oder_chiou@realtek.com>
 <20141028222915.GG18557@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id DC468260454
 for <alsa-devel@alsa-project.org>; Wed, 29 Oct 2014 02:45:01 +0100 (CET)
In-Reply-To: <20141028222915.GG18557@sirena.org.uk>
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "benzh@google.com" <benzh@google.com>, "anatol@google.com" <anatol@google.com>, Bard Liao <bardliao@realtek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Wednesday, October 29, 2014 6:29 AM
> To: Oder Chiou
> Cc: lgirdwood@gmail.com; alsa-devel@alsa-project.org; Bard Liao; Flove;
> anatol@google.com; benzh@google.com
> Subject: Re: [PATCH] ASoC: rt5677: Use specific r/w function for DSP mode
> 
> On Mon, Oct 27, 2014 at 10:52:31AM +0800, Oder Chiou wrote:
> 
> > +	/* Write register */
> > +	r[0] = reg & 0xff;
> > +	xfer[0].addr = client->addr;
> > +	xfer[0].flags = 0;
> > +	xfer[0].len = 1;
> > +	xfer[0].buf = &r[0];
> > +
> > +	/* Read data */
> > +	xfer[1].addr = client->addr;
> > +	xfer[1].flags = I2C_M_RD;
> > +	xfer[1].len = 2;
> > +	xfer[1].buf = data;
> > +
> > +	ret = i2c_transfer(client->adapter, xfer, 2);
> > +	if (ret != 2) {
> > +		dev_err(&client->dev, "i2c_transfer() returned %d\n", ret);
> > +		return -EIO;
> > +	}
> 
> This looks like standard regmap stuff - what's different?

They are not different with regmap stuff, but they are called by
rt5677_dsp_mode_i2c_write_addr(), rt5677_dsp_mode_i2c_read_addr(),
rt5677_read() and rt5677_write().

The customize access function is implemented by rt5677_read() and
rt5677_write() that are assigned to regmap_config "rt5677_regmap" for using
between codec mode or DSP mode.
