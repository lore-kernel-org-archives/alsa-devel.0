From: Timur Tabi <timur@tabi.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl-ssi: fix SDMA starvation
Date: Wed, 13 Nov 2013 08:15:21 -0600
Message-ID: <52838979.7060309@tabi.org>
References: <1384255056-25673-1-git-send-email-mpa@pengutronix.de> <52822529.5090502@tabi.org> <20131112132441.GG30263@pengutronix.de> <CAOZdJXUWv3_ZV6p9VQ+zYqwUDVQC6BMb-VhVoVtEh1yC23VuTg@mail.gmail.com> <20131113121630.GH30263@pengutronix.de> <52837A59.5070508@tabi.org> <20131113133841.GI30263@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20131113133841.GI30263@pengutronix.de>
Sender: stable-owner@vger.kernel.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Juergen Beisert <jbe@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, stable@vger.kernel.org, Mark Brown <broonie@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

Markus Pargmann wrote:
> Is it necessary to keep TDMAE enabled the whole time? In the patch we
> enable it when playback starts and disable when it stops, so the
> communication between DMA and SSI shouldn't be disturbed.

I will have to test it to be sure, but there's a risk that the bit won't 
be set early enough.  I've seen weird problems like that on my board.
