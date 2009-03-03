From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 2/4] ASoC: UDA1380: DATAI is slave only
Date: Tue, 3 Mar 2009 15:58:06 +0000
Message-ID: <20090303155805.GI27155@sirena.org.uk>
References: <1236093054-1952-1-git-send-email-philipp.zabel@gmail.com>
	<1236093054-1952-2-git-send-email-philipp.zabel@gmail.com>
	<20090303155054.GA19642@rakim.wolfsonmicro.main>
	<74d0deb30903030756m270dc300q335f38d896de096f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 5811010385B
	for <alsa-devel@alsa-project.org>; Tue,  3 Mar 2009 16:58:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <74d0deb30903030756m270dc300q335f38d896de096f@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 03, 2009 at 04:56:58PM +0100, pHilipp Zabel wrote:

> R01_SIM sets the UDA1380's digital output interface to master.
> This is not allowed if both input and output use a single DAI
> (uda1380_set_dai_fmt_both), because the input interface is slave only.

> Only uda1380_set_dai_fmt_capture should accept the CBM_CFM setting.

OK, applied this patch too - thanks!
