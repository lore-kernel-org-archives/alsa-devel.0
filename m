From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/4] ASoC: fsi: ensures process inside
 master lock
Date: Wed, 24 Mar 2010 09:49:23 +0000
Message-ID: <1269424163.3798.31.camel@odin>
References: <u1vfa44ls.wl%morimoto.kuninori@renesas.com>
	<uzl1y2q0j.wl%morimoto.kuninori@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f176.google.com (mail-yw0-f176.google.com
	[209.85.211.176])
	by alsa0.perex.cz (Postfix) with ESMTP id AF6C710387E
	for <alsa-devel@alsa-project.org>; Wed, 24 Mar 2010 10:49:28 +0100 (CET)
Received: by ywh6 with SMTP id 6so1639022ywh.16
	for <alsa-devel@alsa-project.org>; Wed, 24 Mar 2010 02:49:27 -0700 (PDT)
In-Reply-To: <uzl1y2q0j.wl%morimoto.kuninori@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-03-24 at 15:27 +0900, Kuninori Morimoto wrote:
> Bit operation for fsi_master should be done inside master lock.
> But soft-reset/interrupt operation were outside of it.
> This patch modify this problem.
> It still allow to INT_ST outside-operation on fsi_interrupt,
> but it is not problem.
> Because this register doesn't need the bit operation.
> 
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
> ---
>  sound/soc/sh/fsi.c |   22 +++++++++++-----------
>  1 files changed, 11 insertions(+), 11 deletions(-)
> 
Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
