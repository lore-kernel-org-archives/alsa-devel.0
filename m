From: Michal Bachraty <michal.bachraty@streamunlimited.com>
Subject: Re: [PATCH v2] davinci-mcasp: Add support for
	multichannel playback
Date: Wed, 06 Mar 2013 15:27:35 +0100
Message-ID: <1438223.VuoA12RjNE@ganymedes>
References: <1361983125-32717-1-git-send-email-michal.bachraty@streamunlimited.com>
 <513616F7.2020201@gmail.com>
 <B5906170F1614E41A8A28DE3B8D121433ED3D3ED@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.inode.at (mx06.lb01.inode.at [62.99.145.6])
 by alsa0.perex.cz (Postfix) with ESMTP id EA57B265CAB
 for <alsa-devel@alsa-project.org>; Wed,  6 Mar 2013 15:27:35 +0100 (CET)
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433ED3D3ED@DBDE01.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "Bedia,
 Vaibhav" <vaibhav.bedia@ti.com>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Vaibhav,
 
> > >>  	return 0;
> > >> 
> > >> @@ -936,13 +978,13 @@ static struct snd_soc_dai_driver
> > >> davinci_mcasp_dai[] = {> >> 
> > >>  		.name		= "davinci-mcasp.0",
> > >>  		.playback	= {
> > >>  		
> > >>  			.channels_min	= 2,
> > >> 
> > >> -			.channels_max 	= 2,
> > >> +			.channels_max	= 8,
> > > 
> > > Why are you setting this to 8?
> > 
> > Well, the ASoC core will look at this field when parsing the dai links,
> > and will build a sound card that has min(codec_dai->channels_max,
> > cpu_dai->channels_max) channels. Hence, this number has to reflect the
> > maximum possible output channels for this DAI. In v3, it's actually set
> > to 512. Or was that not your question?
> 
> 32 slots on a max of 16 serializers gives the max as 512 and hence I wanted
> to know why 8 was selected.

That number was changed in patch v3 to 512.  8 was selected only for Am335 and 
2TDM slots. That number was not general and therefore it was changed.  It is 
no need for discusion for that number, because it was changed to proper value 
in v3 of this patch. If not, let us know.

Michal.
