From: Bard Liao <bardliao@realtek.com>
Subject: Re: [PATCH] ASoC: add rt298 codec driver
Date: Mon, 13 Jul 2015 13:21:53 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D701089DE1@RTITMBSV03.realtek.com.tw>
References: <1435287589-8160-1-git-send-email-bardliao@realtek.com>
 <20150709110922.GK11162@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id ACEA62605E8
 for <alsa-devel@alsa-project.org>; Mon, 13 Jul 2015 15:22:00 +0200 (CEST)
In-Reply-To: <20150709110922.GK11162@sirena.org.uk>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "ramesh.babu@intel.com" <ramesh.babu@intel.com>, John Lin <john.lin@realtek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Thursday, July 09, 2015 7:09 PM
> To: Bard Liao
> Cc: lgirdwood@gmail.com; alsa-devel@alsa-project.org; lars@metafoo.de;
> Flove; Oder Chiou; John Lin; ramesh.babu@intel.com
> Subject: Re: [PATCH] ASoC: add rt298 codec driver
> 
> On Fri, Jun 26, 2015 at 10:59:49AM +0800, Bard Liao wrote:
> > It is the initial version of ALC298 codec driver.
> 
> I'll apply this but a few things here which you should look at:
> 
> > +static int rt298_probe(struct snd_soc_codec *codec) {
> > +	struct rt298_priv *rt298 = snd_soc_codec_get_drvdata(codec);
> > +
> > +	rt298->codec = codec;
> > +
> > +	if (rt298->i2c->irq) {
> > +		regmap_update_bits(rt298->regmap,
> > +					RT298_IRQ_CTRL, 0x2, 0x2);
> > +
> > +		INIT_DELAYED_WORK(&rt298->jack_detect_work,
> > +					rt298_jack_detect_work);
> > +		schedule_delayed_work(&rt298->jack_detect_work,
> > +					msecs_to_jiffies(1250));
> 
> That seems like an awfully long time to wait to do the first jack detection.
> What's this for?

Originally, that is for waiting dapm initialization. Now we check
rt298->codec at the beginning of rt298_jack_detect. I don't know
if it is still necessary.

> 
> > +static int rt298_i2c_probe(struct i2c_client *i2c,
> > +			   const struct i2c_device_id *id) {
> > +	struct rt298_platform_data *pdata = dev_get_platdata(&i2c->dev);
> > +	struct rt298_priv *rt298;
> > +	struct device *dev = &i2c->dev;
> > +	const struct acpi_device_id *acpiid;
> > +	int i, ret;
> > +
> > +	pr_info("%s\n", __func__);
> 
> This isn't adding anything, you should remove it.

Do you mean remove "pr_info("%s\n", __func__);" ?

> 
> ------Please consider the environment before printing this e-mail.
