From: Timur Tabi <timur@tabi.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl_ssi: free irq before irq_dispose_mapping()
Date: Mon, 01 Dec 2014 14:11:36 -0600
Message-ID: <547CCB78.5090007@tabi.org>
References: <1417402251-6596-1-git-send-email-jiada_wang@mentor.com> <2547588.Qc4F2IfZke@wuerfel> <547CC89F.1030205@tabi.org> <3401240.VsRpsiV8WN@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3401240.VsRpsiV8WN@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@lists.ozlabs.org, Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org, Jiada Wang <jiada_wang@mentor.com>, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, nicoleotsuka@gmail.com, tiwai@suse.de, Li.Xiubo@freescale.com, Markus Pargmann <mpa@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

On 12/01/2014 02:01 PM, Arnd Bergmann wrote:
>> >Does this mean that fsl_ssi.c should not be calling
>> >irq_of_parse_and_map?  How else should it get the IRQ?
> platform_get_irq()

Ok, but that function also calls irq_create_of_mapping().  So it still 
appears that the only way to get the IRQ is to map it, but then we can't 
use devm_request_irq().
