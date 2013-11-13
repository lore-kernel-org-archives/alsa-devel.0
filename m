From: Timur Tabi <timur@tabi.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl-ssi: fix SDMA starvation
Date: Wed, 13 Nov 2013 07:11:32 -0600
Message-ID: <52837A84.4010900@tabi.org>
References: <1384255056-25673-1-git-send-email-mpa@pengutronix.de> <20131112132441.GG30263@pengutronix.de> <CAOZdJXUWv3_ZV6p9VQ+zYqwUDVQC6BMb-VhVoVtEh1yC23VuTg@mail.gmail.com> <201311130931.16238.jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <201311130931.16238.jbe@pengutronix.de>
Sender: stable-owner@vger.kernel.org
To: =?ISO-8859-1?Q?J=FCrgen_Beisert?= <jbe@pengutronix.de>
Cc: Markus Pargmann <mpa@pengutronix.de>, alsa-devel mailing list <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, stable@vger.kernel.org, Mark Brown <broonie@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

J=FCrgen Beisert wrote:
> -#define SIER_FLAGS (CCSR_SSI_SIER_TFRC_EN | CCSR_SSI_SIER_TDMAE | \
> +#define SIER_FLAGS (CCSR_SSI_SIER_TFRC_EN | \
>   		    CCSR_SSI_SIER_TIE | CCSR_SSI_SIER_TUE0_EN | \
>   		    CCSR_SSI_SIER_TUE1_EN | CCSR_SSI_SIER_RFRC_EN | \
> -		    CCSR_SSI_SIER_RDMAE | CCSR_SSI_SIER_RIE | \
> +		    CCSR_SSI_SIER_RIE | \
>   		    CCSR_SSI_SIER_ROE0_EN | CCSR_SSI_SIER_ROE1_EN)
>
>   /**

NACK, this will break PowerPC.
