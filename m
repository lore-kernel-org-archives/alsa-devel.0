From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [PATCH v2 2/2] ASoC: da7219: Convert driver to use
 generic device/fwnode functions
Date: Mon, 23 May 2016 22:53:07 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337D463EEB5@SW-EX-MBX01.diasemi.com>
References: <cover.1463477116.git.Adam.Thomson.Opensource@diasemi.com>
 <eea79e2c26dafa785451931387cfce716bd150d4.1463477116.git.Adam.Thomson.Opensource@diasemi.com>
 <1463664451.31269.3.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta3.messagelabs.com (mail1.bemta3.messagelabs.com
 [195.245.230.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 110B926043A
 for <alsa-devel@alsa-project.org>; Tue, 24 May 2016 00:53:11 +0200 (CEST)
In-Reply-To: <1463664451.31269.3.camel@linux.intel.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Opensource [Adam
 Thomson]" <Adam.Thomson.Opensource@diasemi.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J.Wysocki" <rafael.j.wysocki@intel.com>, Len
 Brown <lenb@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Support Opensource <Support.Opensource@diasemi.com>, Hanjun Guo <hanjun.guo@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, Suravee <Suravee.Suthikulpanit@amd.com>, Bjorn Helgaas <bhelgaas@google.com>, Andrew Morton <akpm@linux-foundation.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, "devel@acpica.org" <devel@acpica.org>
List-Id: alsa-devel@alsa-project.org

On May 19, 2015 14:28, Andy Shevchenko wrote:

> > -static struct da7219_aad_pdata *da7219_aad_of_to_pdata(struct
> > snd_soc_codec *codec)
> > +static struct da7219_aad_pdata *da7219_aad_fw_to_pdata(struct
> > snd_soc_codec *codec)
> >  {
> > -	struct device_node *np = codec->dev->of_node;
> > -	struct device_node *aad_np = of_find_node_by_name(np,
> > "da7219_aad");
> > +	struct device *dev = codec->dev;
> > +	struct i2c_client *i2c = to_i2c_client(dev);
> > +	struct fwnode_handle *aad_np =
> > +		device_get_named_child_node(dev, "da7219_aad");
> 
> I would suggest to do an assignment below...
> 
> >  	struct da7219_aad_pdata *aad_pdata;
> > -	const char *of_str;
> > -	u32 of_val32;
> > +	const char *fw_str;
> > +	u32 fw_val32;
> >
> 
> 
> ...right here.
> Same amount of LOC, but less difficult to see from where aad_np comes.
> 
> >  	if (!aad_np)
> >  		return NULL;
> >

To be fair the allocation of 'aad_np' is only a few lines above so this really
doesn't seem to make much difference in my opinion. It really shouldn't be hard
for someone to spot where it's allocated.

> > @@ -769,9 +768,9 @@ int da7219_aad_init(struct snd_soc_codec *codec)
> >  	da7219->aad = da7219_aad;
> >  	da7219_aad->codec = codec;
> >
> > -	/* Handle any DT/platform data */
> > -	if ((codec->dev->of_node) && (da7219->pdata))
> > -		da7219->pdata->aad_pdata =
> > da7219_aad_of_to_pdata(codec);
> > +	/* Handle any DT/ACPI/platform data */
> > +     if ((da7219->pdata) && (!da7219->pdata->aad_pdata))
> 
> Redundant parens, twice.

Not essential, but looks cleaner to me. Unless there's a real demand to change,
I'd like to leave this as is.
