From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: Re: [PATCH v2] davinci-mcasp: Add support for
 multichannel playback
Date: Wed, 6 Mar 2013 10:54:52 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ED3D3ED@DBDE01.ent.ti.com>
References: <1361983125-32717-1-git-send-email-michal.bachraty@streamunlimited.com>
 <B5906170F1614E41A8A28DE3B8D121433ED3C660@DBDE01.ent.ti.com>
 <513616F7.2020201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id C34B0265383
 for <alsa-devel@alsa-project.org>; Wed,  6 Mar 2013 11:54:58 +0100 (CET)
In-Reply-To: <513616F7.2020201@gmail.com>
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
To: Daniel Mack <zonque@gmail.com>
Cc: "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, Michal Bachraty <michal.bachraty@streamunlimited.com>
List-Id: alsa-devel@alsa-project.org

Hi Daniel,

On Tue, Mar 05, 2013 at 21:31:59, Daniel Mack wrote:
[...]
> 
> As Michal described, we used a board with a multichannel Codec on it,
> which connects 3 of its I2S inputs to the AM33xx's AXR data lines.
> 
> Software wise, we tested with 'aplay -cX', and that seems to work just fine.
> 

Since you are using a multichannel codec things are a lot simplified for you :)
Someone might want to hook up multiple codecs to get multi-channel behavior.
There will be only 1 CPU DAI but there can be upto 16 CODEC DAIs operating in
sync. I haven't really followed the recent ASoC changes so I don't know whether
something like this can be handled right now.

Mark, Liam,

Any suggestions?

[...]
> >>  	return 0;
> >> @@ -936,13 +978,13 @@ static struct snd_soc_dai_driver davinci_mcasp_dai[] = {
> >>  		.name		= "davinci-mcasp.0",
> >>  		.playback	= {
> >>  			.channels_min	= 2,
> >> -			.channels_max 	= 2,
> >> +			.channels_max	= 8,
> > 
> > Why are you setting this to 8?
> 
> Well, the ASoC core will look at this field when parsing the dai links,
> and will build a sound card that has min(codec_dai->channels_max,
> cpu_dai->channels_max) channels. Hence, this number has to reflect the
> maximum possible output channels for this DAI. In v3, it's actually set
> to 512. Or was that not your question?

32 slots on a max of 16 serializers gives the max as 512 and hence I wanted
to know why 8 was selected.

Regards,
Vaibhav
