From: Thomas Preston <thomas.preston@codethink.co.uk>
Subject: Re: [alsa-devel] [PATCH v2 3/3] ASoC: TDA7802: Add turn-on diagnostic
 routine
Date: Tue, 30 Jul 2019 16:25:56 +0100
Message-ID: <45156592-a90f-b4f8-4d30-9631c03f1280@codethink.co.uk>
References: <20190730120937.16271-1-thomas.preston@codethink.co.uk>
 <20190730120937.16271-4-thomas.preston@codethink.co.uk>
 <20190730141935.GF4264@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190730141935.GF4264@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.cirrus.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Kirill Marinushkin <kmarinushkin@birdec.tech>, Cheng-Yi Chiang <cychiang@chromium.org>, Marco Felsch <m.felsch@pengutronix.de>, Takashi Iwai <tiwai@suse.com>, Annaliese McDermond <nh6z@nh6z.net>, Liam Girdwood <lgirdwood@gmail.com>, Paul Cercueil <paul@crapouillou.net>, Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
List-Id: alsa-devel@alsa-project.org

On 30/07/2019 15:19, Mark Brown wrote:
> On Tue, Jul 30, 2019 at 01:09:37PM +0100, Thomas Preston wrote:
> 
>> +	struct dentry *debugfs;
>> +	struct mutex diagnostic_mutex;
>> +};
> 
> It is unclear what this mutex usefully protects, it only gets taken when
> writing to the debugfs file to trigger this diagnostic mode but doesn't
> do anything to control interactions with any other code path in the
> driver.
> 

If another process reads the debugfs node "diagnostic" while the turn-on 
diagnostic mode is running, this mutex prevents the second process
restarting the diagnostics.

This is redundant if debugfs reads are atomic, but I don't think they are.


>> +static int run_turn_on_diagnostic(struct tda7802_priv *tda7802, u8 *status)
>> +{
>> +	struct device *dev = &tda7802->i2c->dev;
>> +	int err_status, err;
>> +	unsigned int val;
>> +	u8 state[NUM_IB];
> 
>> +	/* We must wait 20ms for device to settle, otherwise diagnostics will
>> +	 * not start and regmap poll will timeout.
>> +	 */
>> +	msleep(DIAGNOSTIC_SETTLE_MS);
> 
> The comment and define might go out of sync...
> 

Thanks, I will remove the 20ms but keep the comment here.

>> +	err = regmap_bulk_read(tda7802->regmap, TDA7802_DB1, status, 4);
>> +	if (err < 0) {
>> +		dev_err(dev, "Could not read channel status, %d\n", err);
>> +		goto diagnostic_restore;
>> +	}
> 
> ...but here we use a magic number for the array size :(
> 

Thanks, will update.

>> +static int tda7802_diagnostic_show(struct seq_file *f, void *p)
>> +{
>> +	char *buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
> 
> We neither use nor free buf?
> 
>> +static int tda7802_probe(struct snd_soc_component *component)
>> +{
>> +	struct tda7802_priv *tda7802 = snd_soc_component_get_drvdata(component);
>> +	struct device *dev = &tda7802->i2c->dev;
>> +	int err;
> 
> Why is this done at the component level?
> 

Argh my bad, a previous iteration required the buf and component. I missed
this, sorry for the noise.

Thanks for feedback, I'll go back and tend to all of this.
