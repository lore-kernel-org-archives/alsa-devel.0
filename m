From: Vinod <vkoul@kernel.org>
Subject: Re: [alsa-devel] [PATCH v3 3/5] ASoC: qcom: add sdm845 sound card
 support
Date: Mon, 9 Jul 2018 20:15:33 +0530
Message-ID: <20180709144533.GE22377@vkoul-mobl>
References: <1530870195-13576-1-git-send-email-rohitkr@codeaurora.org>
 <1530870195-13576-4-git-send-email-rohitkr@codeaurora.org>
 <20180709074835.GB22377@vkoul-mobl>
 <c1766ce9-060f-32d8-46fa-b0a6ac42538b@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c1766ce9-060f-32d8-46fa-b0a6ac42538b@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rohit Kumar <rohitkr@codeaurora.org>
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, plai@codeaurora.org, bgoswami@codeaurora.org, perex@perex.cz, srinivas.kandagatla@linaro.org, tiwai@suse.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 09-07-18, 16:16, Rohit Kumar wrote:

> > > +static int sdm845_bind(struct device *dev)
> > > +{
> > > +	struct snd_soc_card *card;
> > > +	struct sdm845_snd_data *data;
> > > +	int ret;
> > > +
> > > +	card = kzalloc(sizeof(*card), GFP_KERNEL);
> > > +	if (!card)
> > > +		return -ENOMEM;
> > > +
> > > +	/* Allocate the private data */
> > > +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> > > +	if (!data)
> > > +		return -ENOMEM;
> > > +
> > > +	ret = component_bind_all(dev, card);
> > > +	if (ret) {
> > > +		dev_err(dev, "Audio components bind failed: %d\n", ret);
> > > +		goto bind_fail;
> > > +	}
> > > +
> > > +	dev_set_drvdata(dev, card);
> > > +	card->dev = dev;
> > > +	ret = qcom_snd_parse_of(card);
> > > +	if (ret) {
> > > +		dev_err(dev, "Error parsing OF data\n");
> > > +		goto parse_dt_fail;
> > > +	}
> > > +
> > > +	data->card = card;
> > > +	snd_soc_card_set_drvdata(card, data);
> > > +
> > > +	sdm845_add_be_ops(card);
> > > +
> > > +	sdm845_init_supplies(dev);
> > > +
> > > +	ret = snd_soc_register_card(card);
> > > +	if (ret) {
> > > +		dev_err(dev, "Sound card registration failed\n");
> > > +		goto register_card_fail;
> > > +	}
> > > +	return ret;
> > > +
> > > +register_card_fail:
> > > +	sdm845_deinit_supplies(dev);
> > > +	kfree(card->dai_link);
> > > +parse_dt_fail:
> > > +	component_unbind_all(dev, card);
> > > +bind_fail:
> > > +	kfree(data);
> > > +	kfree(card);
> > > +	return ret;
> > > +}
> > I would make a case for this to be moved into common too :)
> 
> There are few platform specific APIs and structs here like struct
> sdm845_snd_data,
> sdm845_add_be_ops() which needs to be initialized and assigned before
> soundcard
> registration. Moving this complete API to common will restrict it. Please
> suggest.

Yes indeed, they can be split and done outside while the common stuff
use a 'core' object and use that to initialize. If you need to do some
driver step, you can invoke a callback.

-- 
~Vinod
