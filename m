From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCH] ASoC: simple-card: Add DAPM routes parse from device
 tree
Date: Thu, 2 Jan 2014 03:59:35 +0000
Message-ID: <a899f6babcfe4d6eaf559ba9b4ba8a81@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1387774621-23968-1-git-send-email-Li.Xiubo@freescale.com>
 <20131231123857.GS31886@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20131231123857.GS31886@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "rob@landley.net" <rob@landley.net>, "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>, "Fabio.Estevam@freescale.com" <Fabio.Estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


> Subject: Re: [PATCH] ASoC: simple-card: Add DAPM routes parse from device tree
> 
> On Mon, Dec 23, 2013 at 12:57:01PM +0800, Xiubo Li wrote:
> > Parses a simple DAPM route table from device tree.
> 
> I've applied this on the basis that it's using a generic feature and
> won't do any harm but given that no off-CODEC widgets are defined I do
> have to wonder when it'll actually be useful.

Yes, it will be useful for the Vybird and LS-1 boards and also many others.

And for the simple-card there still needs the off-CODEC widgets registering,
I'll send the followed patches later.


Thanks,

--
Best Regards,
Xiubo
