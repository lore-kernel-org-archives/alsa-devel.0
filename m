From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl_ssi: free irq before irq_dispose_mapping()
Date: Mon, 1 Dec 2014 19:03:27 -0200
Message-ID: <CAOMZO5Cz60D5V2uKM4ivWp9s44XXqVsuEJhpmSWoBuq+yUvNMw@mail.gmail.com>
References: <1417402251-6596-1-git-send-email-jiada_wang@mentor.com>
	<2547588.Qc4F2IfZke@wuerfel>
	<547CC89F.1030205@tabi.org>
	<3401240.VsRpsiV8WN@wuerfel>
	<547CCB78.5090007@tabi.org>
	<547CCFF7.2000205@metafoo.de>
	<CAOMZO5B7MxLSaETUW0QyajdHMMX2nLg=t=5dVCNRePb6UzizRQ@mail.gmail.com>
	<547CD2C6.2060107@tabi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <547CD2C6.2060107@tabi.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Timur Tabi <timur@tabi.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Arnd Bergmann <arnd@arndb.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Jiada Wang <jiada_wang@mentor.com>, Xiubo Li <Li.Xiubo@freescale.com>, linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Markus Pargmann <mpa@pengutronix.de>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 1, 2014 at 6:42 PM, Timur Tabi <timur@tabi.org> wrote:

> Would the mapping continue to exist after the driver is unloaded?  Can you
> try multiple loads/unloads and see if interrupts still work?

I tried multiple loads/unloads and audio works fine with those changes.

About the ssi irq we have:

- With the ssi driver loaded:
root@freescale /home$ cat /proc/interrupts | grep ssi
 79:          0          0          0          0       GIC  79  202c000.ssi

- After removing the ssi driver:
root@freescale /home$ rmmod   snd-soc-fsl-ssi
root@freescale /home$ cat /proc/interrupts | grep ssi
root@freescale /home$

,so it seems to behave properly.
