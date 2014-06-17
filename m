From: Sean Cross <xobs@kosagi.com>
Subject: Re: [PATCH v2 3/3] ASoC: fsl: add imx-es8328 machine
	driver
Date: Tue, 17 Jun 2014 15:12:14 +0800
Message-ID: <539FEA4E.503@kosagi.com>
References: <1402982189-28598-1-git-send-email-xobs@kosagi.com>
 <1402982189-28598-4-git-send-email-xobs@kosagi.com>
 <539FDF92.8070401@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.g1.pair.com (mail1.g1.pair.com [66.39.3.162])
 by alsa0.perex.cz (Postfix) with ESMTP id 6341E2654EC
 for <alsa-devel@alsa-project.org>; Tue, 17 Jun 2014 09:12:43 +0200 (CEST)
In-Reply-To: <539FDF92.8070401@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Xiubo Li <Li.Xiubo@freescale.com>, Nicolin Chen <Guangyu.Chen@freescale.com>
List-Id: alsa-devel@alsa-project.org

On 06/17/14 14:26, Lars-Peter Clausen wrote:
> On 06/17/2014 07:16 AM, Sean Cross wrote:
> [...]
>> +- codec-supply : Power regulator for audio codec chip
>
> If this is the supply for the CODEC it should be part of the CODEC's
> bindings and probably be handled by the CODEC driver.
>
>
On this board, it's simply a GPIO on this board that enables or disables
power to the chip.  Since it's external to the codec, it seemed more
appropriate to put it in the machine driver file.


Sean
