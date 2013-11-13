From: Timur Tabi <timur@tabi.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl-ssi: fix SDMA starvation
Date: Wed, 13 Nov 2013 07:10:49 -0600
Message-ID: <52837A59.5070508@tabi.org>
References: <1384255056-25673-1-git-send-email-mpa@pengutronix.de> <52822529.5090502@tabi.org> <20131112132441.GG30263@pengutronix.de> <CAOZdJXUWv3_ZV6p9VQ+zYqwUDVQC6BMb-VhVoVtEh1yC23VuTg@mail.gmail.com> <20131113121630.GH30263@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20131113121630.GH30263@pengutronix.de>
Sender: stable-owner@vger.kernel.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Juergen Beisert <jbe@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, stable@vger.kernel.org, Mark Brown <broonie@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

Markus Pargmann wrote:
>> >Can you change the code so that the interrupts are enabled only on
>> >i.MX?  On PowerPC, the interrupts are used only for debugging.

> Why is this necessary? The interrupts were enabled for all
> architectures before.

My concern is with these lines:

	write_ssi_mask(&ssi->sier, 0, CCSR_SSI_SIER_TDMAE);
...
	write_ssi_mask(&ssi->sier, CCSR_SSI_SIER_TDMAE, 0);

This toggles the TDMAE interrupt on PowerPC, which I believe is VITAL to 
making it work.  The SSI and the DMA controller talk to each other 
automatically, and if I'm reading the documentation correctly, that 
communication depends on TDMAE and RDMAE.
