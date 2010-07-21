From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: TWL4030: Add configurable delay
 after digimic enable
Date: Wed, 21 Jul 2010 11:58:56 +0100
Message-ID: <1279709936.3072.6.camel@odin>
References: <1279630149-3337-1-git-send-email-peter.ujfalusi@nokia.com>
	<20100720125513.GB30148@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id B1D932456C
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Jul 2010 12:58:58 +0200 (CEST)
Received: by wwb22 with SMTP id 22so625310wwb.20
	for <alsa-devel@alsa-project.org>; Wed, 21 Jul 2010 03:58:58 -0700 (PDT)
In-Reply-To: <20100720125513.GB30148@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-07-20 at 13:55 +0100, Mark Brown wrote:
> On Tue, Jul 20, 2010 at 03:49:09PM +0300, Peter Ujfalusi wrote:
> > When digital microphones are connected to twl, delay is
> > needed after enabling the digimic interface of the codec.
> > Add new parameter for the setup data, which can be used
> > to pass the apropriate delay in ms after the digimic
> > interface has been enabled.
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Applied.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
