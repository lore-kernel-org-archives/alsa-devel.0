From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] ASoC: fsl: enable ssi clock in probe
	function
Date: Fri, 30 Mar 2012 21:16:56 +0800
Message-ID: <CAAQ0ZWR5ws7od92bOcLn-kDdbSPAVRDQwdVu-90tRfDSH_49KA@mail.gmail.com>
References: <1332989621-5211-1-git-send-email-shawn.guo@linaro.org>
	<20120329112949.GM3668@opensource.wolfsonmicro.com>
	<4F748751.3020300@freescale.com>
	<20120329160916.GG19506@S2101-09.ap.freescale.net>
	<4F748C8E.1010702@freescale.com>
	<20120330055543.GH19506@S2101-09.ap.freescale.net>
	<4F75AF20.6080009@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lpp01m010-f51.google.com (mail-lpp01m010-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id CFCB0104317
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Mar 2012 15:16:56 +0200 (CEST)
Received: by laap9 with SMTP id p9so680994laa.38
	for <alsa-devel@alsa-project.org>; Fri, 30 Mar 2012 06:16:56 -0700 (PDT)
In-Reply-To: <4F75AF20.6080009@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 30 March 2012 21:03, Timur Tabi <timur@freescale.com> wrote:
...
> You'll need to get Kumar Gala's ACK on that one, but if only the 8610 is
> broken, then I don't think he'll like it.
>
It's only about building in arch/powerpc/kernel/clock.c, which is a
pretty dummy clk API and does not take much cost.

Regards,
Shawn
