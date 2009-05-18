From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: Re: [PATCH 3/3] ASoC: SDP3430: Connect twl4030 voice
 DAI to McBSP3
Date: Mon, 18 May 2009 11:23:34 -0500
Message-ID: <2C7D3DF36ADFFC479B44490D912B616705F69E83BE@dlee07.ent.ti.com>
References: <2C7D3DF36ADFFC479B44490D912B616705F69E8125@dlee07.ent.ti.com>
	<200905181304.56360.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id A199410381F
	for <alsa-devel@alsa-project.org>;
	Mon, 18 May 2009 18:23:45 +0200 (CEST)
In-Reply-To: <200905181304.56360.peter.ujfalusi@nokia.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> >  	/* Add SDP3430 specific widgets */
> > @@ -150,6 +194,11 @@ static int sdp3430_twl4030_init(struct 
> > snd_soc_codec
> > *codec) /* Set up SDP3430 specific audio path audio_map */
> >  	snd_soc_dapm_add_routes(codec, audio_map, 
> ARRAY_SIZE(audio_map));
> >
> > +	/* Enable audio interface */
> > +	reg = codec->read(codec, TWL4030_REG_AUDIO_IF);
> > +	reg |= TWL4030_AIF_EN;
> > +	codec->write(codec, TWL4030_REG_AUDIO_IF, reg);
> > +
> 
> Well, this does not do anything (bad or good)... The Audio 
> interface is permanently enabled by default (by the default 
> register array in the twl4030.c).
> I have plans to do it dynamically, but it needs some more 
> thinking, since the digital loopback on the audio path needs 
> also the audio interface to be enabled.
> 
> Is there a reason to do this at all?

I thought in enabling the audio interface in machine driver
and clean AUDIO_IF reg in register cache, but that would require
to enable it in all other machine drivers. However, I didn't
consider the digital loopback scenario.

So, I'll remove this from machine driver and resend it.
