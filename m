From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 2/4] ASoC: pxa-ssp: PXA2xx/3xx SSP ports
	start from 1, not 0
Date: Tue, 3 Feb 2009 18:56:08 +0000
Message-ID: <20090203185607.GL23827@sirena.org.uk>
References: <1233677983-23710-1-git-send-email-philipp.zabel@gmail.com>
	<1233677983-23710-3-git-send-email-philipp.zabel@gmail.com>
	<20090203164715.GH23827@sirena.org.uk>
	<74d0deb30902030913u581debd1pa31eda017a49524c@mail.gmail.com>
	<20090203173513.GK23827@sirena.org.uk>
	<74d0deb30902031049g500814baje09f163a9e79805b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 71EB5103861
	for <alsa-devel@alsa-project.org>; Tue,  3 Feb 2009 19:56:09 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <74d0deb30902031049g500814baje09f163a9e79805b@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pHilipp Zabel <philipp.zabel@gmail.com>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 03, 2009 at 07:49:43PM +0100, pHilipp Zabel wrote:

> Hm, hm.. Ripping ssp_init/exit's innards out of them (minus the
> ssp/irq_request parts), like this, seems to work:

Yes, that looks good.  IIRC that was the direction the SSP API was
supposed to be heading in anyway.  Please submit properly (with
changelog and so on) - I'll test tomorrow with PXA3xx but I'd be
surprised if there were any issues.
