From: Timur Tabi <timur@tabi.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl_ssi: free irq before irq_dispose_mapping()
Date: Mon, 01 Dec 2014 14:42:46 -0600
Message-ID: <547CD2C6.2060107@tabi.org>
References: <1417402251-6596-1-git-send-email-jiada_wang@mentor.com>	<2547588.Qc4F2IfZke@wuerfel>	<547CC89F.1030205@tabi.org>	<3401240.VsRpsiV8WN@wuerfel>	<547CCB78.5090007@tabi.org>	<547CCFF7.2000205@metafoo.de> <CAOMZO5B7MxLSaETUW0QyajdHMMX2nLg=t=5dVCNRePb6UzizRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOMZO5B7MxLSaETUW0QyajdHMMX2nLg=t=5dVCNRePb6UzizRQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>
Cc: Arnd Bergmann <arnd@arndb.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Jiada Wang <jiada_wang@mentor.com>, Xiubo Li <Li.Xiubo@freescale.com>, linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Markus Pargmann <mpa@pengutronix.de>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

On 12/01/2014 02:40 PM, Fabio Estevam wrote:
>> >Hm... that's new. But it's not really a driver issue anymore if it is done
>> >in the core. So I guess for now just use platform_get_irq() and ignore the
>> >other issue.

> With the suggested changes below, the removal of the driver works fine on a mx6:

Would the mapping continue to exist after the driver is unloaded?  Can 
you try multiple loads/unloads and see if interrupts still work?
