From: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Subject: Re: AC97 atmel
Date: Thu, 11 Jun 2009 15:41:24 +0200
Message-ID: <4A310984.7050008@atmel.com>
References: <4A30C6C6.9090205@atmel.com> <20090611130117.GE26509@sirena.org.uk>
	<20090611151125.07557a92@hcegtvedt.norway.atmel.com>
	<20090611132330.GA1555@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atmel-es2.atmel.fr (mail.atmel.fr [81.80.104.162])
	by alsa0.perex.cz (Postfix) with ESMTP id 67AC4103812
	for <alsa-devel@alsa-project.org>;
	Thu, 11 Jun 2009 15:41:38 +0200 (CEST)
In-Reply-To: <20090611132330.GA1555@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
List-Id: alsa-devel@alsa-project.org

Mark Brown a =E9crit :
> =

> Hrm, looking at the Kconfig in 2.6.30 the dw_dmac code has a hard
> dependency on AVR32 which is probably what's causing the trouble - I
> guess a patch will also be needed for that to enable AT91 support.
> =

Yes indeed! On AT91 we don't have a specific dma which is called pdc.
So basically I have put all the dma functions into if(cpu_is_ap7000()).
But I am not sure this is the proper way of doing it...
