From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCH v2 7/7] ASoC: binding: for new properties documenting
 and usage
Date: Sat, 8 Feb 2014 08:20:16 +0000
Message-ID: <28c66e24e8744a6789788600b6a412f5@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1390549386-4702-1-git-send-email-Li.Xiubo@freescale.com>
 <1390549386-4702-8-git-send-email-Li.Xiubo@freescale.com>
 <20140127195848.GB11841@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140127195848.GB11841@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>, "rob@landley.net" <rob@landley.net>, "perex@perex.cz" <perex@perex.cz>, "moinejf@free.fr" <moinejf@free.fr>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> > This add the following three new properties documenting and usage
> > for simple card:
> >
> > 	"simple-audio-card,name",
> > 	"simple-audio-card,widgets",
> > 	"simple-audio-card,tdm-slot".
> 
> name and widgets are basically fine modulo the comment about "Hp".
> tdm-slot needs further study, when resubmitting can you please split
> that into a second patch so that the name and widgets properties can be
> merged even if that needs more work?
>

Yes, I will.

 
> For widgets it might be good to create a separate document widgets.txt
> and refer to that - since the code in the kernel can be shared and
> extended we should share the binding document too.

I will send another patch series about this.


Thanks,

--
Best Regards,
Xiubo
