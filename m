From: Timur Tabi <timur@freescale.com>
Subject: Re: Cirrus Logic CS42L52 Low power codec
Date: Mon, 18 Feb 2008 11:07:28 -0600
Message-ID: <47B9BB50.8080408@freescale.com>
References: <1203344273.4063.6.camel@localhost.localdomain>	<20080218143655.GE21314@rakim.wolfsonmicro.main>	<1203345949.4063.8.camel@localhost.localdomain>	<20080218152259.GA7939@rakim.wolfsonmicro.main>
	<1203352473.4063.22.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 948921038FD
	for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2008 18:07:32 +0100 (CET)
In-Reply-To: <1203352473.4063.22.camel@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Brian Austin wrote:

> Since the codecs are not tied to the machine, the user must then add to the Kconfig of the 
> ARCH to select which codec they want to use?

Yes.  For most ASoC V1 platforms, the use selects a Kconfig for his platform, 
and *that* Kconfig selects the codec.  Example:

config SND_SOC_MPC8610_HPCD
         bool "ALSA SoC support for the Freescale MPC8610 HPCD board"
         depends on SND_SOC_MPC8610
         select SND_SOC_CS4270
	^^^^^^^^^^^^^^^^^^^^^

> If the codec isn't tied to the machine, why can't we select from a list of supported codecs?
> Just trying to get a better understanding of how this works.

The codec is not tied to the machine, but the machine is tied to the codec.

That is, in ASoC V1, the machine driver must know about the codec driver at 
compile time.

-- 
Timur Tabi
Linux kernel developer at Freescale
