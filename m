From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [alsa-devel] [RFC][PATCH] ASoC: simple-card: Add
	asoc_simple_card_data for the simple card driver data
Date: Tue, 14 Jan 2014 07:56:32 +0000
Message-ID: <96cb876ff05c4062ab5a2c92fb7b3c41@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1389678282-1097-1-git-send-email-Li.Xiubo@freescale.com>
 <871u0bgiai.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <871u0bgiai.wl%kuninori.morimoto.gx@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: "broonie@kernel.org" <broonie@kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "moinejf@free.fr" <moinejf@free.fr>, "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


> > Whether the dt is used or not, almost all the simple card information
> > for the DAI link and sound card are initialized in the simple card driver.
> >
> > And for the platform caller, the snd_link and snd_card are of no use, so
> > move them from struct asoc_simple_card_info to struct asoc_simple_card_data.
> >
> > And now only one DAI link is supported for simple card.
> >
> > Suggested-by: Jean-Francois Moine <moinejf@free.fr>
> > Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> > ---
> 
> This patch seems have many this kind of lines
>   -	info->xxx
>   +	sdata->info->xxx
> 
> But, how about add this line to each function ?
> 
>      struct asoc_simple_card_info *info = &sdata->info;
> 
> Patch will be more readable
>

Yes, that's looks perfect.

See the next version please.

Thanks,

--
Best Regards,
Xiubo
