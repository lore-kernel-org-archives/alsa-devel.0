From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: Re: [PATCH] hda: add support for jack detection on
	IDT/Sigmatel
Date: Wed, 15 Oct 2008 11:45:23 -0400
Message-ID: <48F61013.7060804@embeddedalley.com>
References: <48F60190.5060601@embeddedalley.com>
	<20081015154402.GE14068@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (unknown [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id 74B13103810
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Oct 2008 17:45:48 +0200 (CEST)
In-Reply-To: <20081015154402.GE14068@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Wed, Oct 15, 2008 at 10:43:28AM -0400, Matthew Ranostay wrote:
> 
>> @@ -3639,6 +3640,12 @@ static int stac92xx_init(struct hda_codec *codec)
>>  		stac92xx_auto_set_pinctl(codec, spec->autocfg.line_out_pins[0],
>>  					 AC_PINCTL_OUT_EN);
>>  		stac92xx_auto_init_hp_out(codec);
>> +		/* jack detection */
>> +		err = snd_jack_new(codec->bus->card,
>> +			"Headphone Jack Detection",
>> +			SND_JACK_HEADPHONE, &codec->jack);
>> +		if (err < 0)
> 
> That should probably just be "Headphone Jack".
> 
>> +			return err;
> 
> ...
> 
>> +	if (codec->jack)
>> +		snd_jack_report(codec->jack,
>> +			presence ? SND_JACK_HEADPHONE : 0);
>> +
> 
> Since you appear to fail init if you can't create the jack there should
> be no need to check for the jack being initialised here.  For ease of
> use I'll just submit a patch folding that check into snd_jack_report(),
> though.
> 

Good catch.

Thanks,

Matt Ranostay
