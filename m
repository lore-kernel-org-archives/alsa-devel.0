From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/3] asoc/multi-component: add support for
 the Freescale P1022 DS reference board
Date: Fri, 20 Aug 2010 11:48:28 +0100
Message-ID: <1282301308.3084.155.camel@odin>
References: <1282255900-20515-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id DE6BF1038DE
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Aug 2010 12:48:34 +0200 (CEST)
Received: by wyb42 with SMTP id 42so3374943wyb.38
	for <alsa-devel@alsa-project.org>; Fri, 20 Aug 2010 03:48:34 -0700 (PDT)
In-Reply-To: <1282255900-20515-1-git-send-email-timur@freescale.com>
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
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-08-19 at 17:11 -0500, Timur Tabi wrote:
> The Freescale P1022 is a dual-core e500-based SOC with multimedia capabilities,
> specifically the same SSI audio controller on the MPC8610.  The P1022 DS
> reference board includes a P1022 and a Wolfson Microelectronics WM8776
> codec.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>  sound/soc/fsl/Kconfig    |   24 ++-
>  sound/soc/fsl/Makefile   |    8 +-
>  sound/soc/fsl/p1022_ds.c |  590 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 614 insertions(+), 8 deletions(-)
>  create mode 100644 sound/soc/fsl/p1022_ds.c

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
