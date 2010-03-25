From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 2/4 v2] ASoC: fsi: Add FIFO size calculate
Date: Thu, 25 Mar 2010 10:42:02 +0000
Message-ID: <1269513722.3758.35.camel@odin>
References: <ubpecvh9k.wl%morimoto.kuninori@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f178.google.com (mail-iw0-f178.google.com
	[209.85.223.178])
	by alsa0.perex.cz (Postfix) with ESMTP id C40E11038BE
	for <alsa-devel@alsa-project.org>; Thu, 25 Mar 2010 11:42:07 +0100 (CET)
Received: by iwn8 with SMTP id 8so2797017iwn.16
	for <alsa-devel@alsa-project.org>; Thu, 25 Mar 2010 03:42:06 -0700 (PDT)
In-Reply-To: <ubpecvh9k.wl%morimoto.kuninori@renesas.com>
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

On Thu, 2010-03-25 at 19:15 +0900, Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
> ---
> v1 -> v2
> 
> o move calculate area to fsi_fifo_init
> o modify fifo calculation way
> o Add tiny document for fifo calculation
> 
>  sound/soc/sh/fsi.c |   70 ++++++++++++++++++++++++++++++++--------------------
>  1 files changed, 43 insertions(+), 27 deletions(-)

Both 2/4 and 4/4

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
