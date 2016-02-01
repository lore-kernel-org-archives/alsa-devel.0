From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 2/2] regmap: cache: Fall back to register by register read
 for cache defaults
Date: Mon, 1 Feb 2016 21:58:13 -0200
Message-ID: <CAOMZO5CEn_NCRkd5hoPfo-e62f+3DX2h82Q_MBPOLiBPEGS81Q@mail.gmail.com>
References: <1454362695-10682-1-git-send-email-broonie@kernel.org>
	<1454362695-10682-2-git-send-email-broonie@kernel.org>
	<20160201214139.GI4455@sirena.org.uk>
	<CAOMZO5BSbFo7xMEHY9s5YNitKFq8gJ83W6oDnS8PYBBDu2+ykQ@mail.gmail.com>
	<20160201221346.GJ4455@sirena.org.uk>
	<56AFE233.10701@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56AFE233.10701@maciej.szmigiero.name>
Sender: linux-kernel-owner@vger.kernel.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Mark Brown <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Nicolin Chen <nicoleotsuka@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 1, 2016 at 8:54 PM, Maciej S. Szmigiero
<mail@maciej.szmigiero.name> wrote:

> I was able to make SSI work again after modifying second patch
> with cache_bypass around read and skipping of unreadable regs:

Thanks Mark and Maciej, this fixes the SSI probe:

Tested-by: Fabio Estevam <fabio.estevam@nxp.com>
