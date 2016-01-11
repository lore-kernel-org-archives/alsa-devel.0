From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 3/3] ASoC: fsl_ssi: remove register defaults
Date: Mon, 11 Jan 2016 12:05:26 -0200
Message-ID: <CAOMZO5DVKrnufV_PLD_+7FgA=ePhn1DSpzYDQPy5FZvHyGOJ-g@mail.gmail.com>
References: <5677107C.60904@maciej.szmigiero.name>
	<CAOMZO5C+32Nn6+Nv9KeVrd_Qeso-wEZZNU45G8h+e6LHdMoQYw@mail.gmail.com>
	<CAOMZO5BE7=EdmEyMOq5WH=qv_0H3AGcyyDMJFoemLRJ=O5YLNw@mail.gmail.com>
	<5693B4C1.4060400@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5693B4C1.4060400@maciej.szmigiero.name>
Sender: linux-kernel-owner@vger.kernel.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Maciej,

On Mon, Jan 11, 2016 at 11:57 AM, Maciej S. Szmigiero
<mail@maciej.szmigiero.name> wrote:
> Hi Fabio,

> This will disable register cache so it isn't right.
> Could you try REGCACHE_FLAT instead, please?

Yes, with REGCACHE_FLAT I don't get the warning.

Regards,

Fabio Estevam
