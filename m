From: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Subject: Re: [PATCH 3/3] Add ALSA driver for Atmel AC97
	controller
Date: Wed, 04 Feb 2009 13:51:48 +0100
Message-ID: <49898F64.2000107@atmel.com>
References: <1233748114-6353-1-git-send-email-hans-christian.egtvedt@atmel.com>	<1233748114-6353-2-git-send-email-hans-christian.egtvedt@atmel.com>	<1233748114-6353-3-git-send-email-hans-christian.egtvedt@atmel.com>	<1233748114-6353-4-git-send-email-hans-christian.egtvedt@atmel.com>	<20090204120045.GB29849@sirena.org.uk>
	<20090204131505.380492af@hcegtvedt>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atmel-es2.atmel.fr (mail.atmel.fr [81.80.104.162])
	by alsa0.perex.cz (Postfix) with ESMTP id 144AF243B2
	for <alsa-devel@alsa-project.org>; Wed,  4 Feb 2009 13:51:55 +0100 (CET)
In-Reply-To: <20090204131505.380492af@hcegtvedt>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

Hi,
Hans-Christian Egtvedt a =E9crit :
> Yes, it should be possible to share the AC97C driver between AT91 and
> AVR32. Although this AC97C driver uses the DesignWare DMAC controller
> (drivers/dma/dw_dmac.c).
> =

> I do not remember which DMA interface AT91 devices uses.
> =

> Should the driver go into sound/drivers then? And renamed to
> atmel-ac97c.{c,h} for example.
> =

Actually there are some differences, AT91 does not use a DMA, we use a =

specific IP(PDC) to transer the data...

Maybe we could share the same code we some #define in it?

Regards,
Sedji
