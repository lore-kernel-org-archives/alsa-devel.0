From: Timur Tabi <timur@tabi.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl-ssi: fix SDMA starvation
Date: Tue, 12 Nov 2013 14:17:34 -0600
Message-ID: <CAOZdJXUWv3_ZV6p9VQ+zYqwUDVQC6BMb-VhVoVtEh1yC23VuTg@mail.gmail.com>
References: <1384255056-25673-1-git-send-email-mpa@pengutronix.de>
	<52822529.5090502@tabi.org>
	<20131112132441.GG30263@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20131112132441.GG30263@pengutronix.de>
Sender: stable-owner@vger.kernel.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Timur Tabi <timur@tabi.org>, alsa-devel mailing list <alsa-devel@alsa-project.org>, Juergen Beisert <jbe@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, stable@vger.kernel.org, Mark Brown <broonie@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 12, 2013 at 7:24 AM, Markus Pargmann <mpa@pengutronix.de> wrote:
>
> No, I don't have access on PowerPC hardware, so I didn't test it on
> PowerPC.

Can you change the code so that the interrupts are enabled only on
i.MX?  On PowerPC, the interrupts are used only for debugging.
