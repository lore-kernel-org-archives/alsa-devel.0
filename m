From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH] ASoC: fsl-ssi: fix SDMA starvation
Date: Tue, 12 Nov 2013 06:55:05 -0600
Message-ID: <52822529.5090502@tabi.org>
References: <1384255056-25673-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1384255056-25673-1-git-send-email-mpa@pengutronix.de>
Sender: stable-owner@vger.kernel.org
To: Markus Pargmann <mpa@pengutronix.de>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Juergen Beisert <jbe@pengutronix.de>, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Markus Pargmann wrote:
>
> To ensure the first edge happens after enabling the TX side of the SSI unit and
> to trigger the SDMA unit successfully enable the CCSR_SSI_SIER_TDMAE on
> demand only. To be sure, this patch does the same for the CCSR_SSI_SIER_RDMAE
> (RX side) bit.

This patch impacts PowerPC as well.  Have you tested it on that platform?
