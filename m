From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 2/2] ALSA: soc - cs4270: fix ADC/DAC rate
	matching
Date: Mon, 21 Jul 2008 09:54:47 -0500
Message-ID: <4884A337.30309@freescale.com>
References: <20080704154313.GA11635@polina.dev.rtsoft.ru>
	<20080704154404.GB27136@polina.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id C576124373
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Jul 2008 16:54:57 +0200 (CEST)
In-Reply-To: <20080704154404.GB27136@polina.dev.rtsoft.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Anton Vorontsov wrote:

> +	if (!cs4270->master_substream)
> +		cs4270->master_substream = substream;

This should be done in a _startup function, not here.

-- 
Timur Tabi
Linux kernel developer at Freescale
