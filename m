From: Axel Lin <axel.lin@gmail.com>
Subject: Re: [PATCH v2] ASoC: Fix recursive dependency for
	SND_AT91_SOC_SAM9G20_WM8731
Date: Tue, 10 Jan 2012 10:42:00 +0800
Message-ID: <CAF+7xW=mR5xLG-wETVjUEiN8Ryqbp8mN7mj=WGvbNKxTaDuW1Q@mail.gmail.com>
References: <1326161122-20717-1-git-send-email-festevam@gmail.com>
Reply-To: axel.lin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lpp01m010-f51.google.com (mail-lpp01m010-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 5D7D410396D
	for <alsa-devel@alsa-project.org>; Tue, 10 Jan 2012 03:42:24 +0100 (CET)
Received: by lago2 with SMTP id o2so1680538lag.38
	for <alsa-devel@alsa-project.org>; Mon, 09 Jan 2012 18:42:22 -0800 (PST)
In-Reply-To: <1326161122-20717-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

2012/1/10 Fabio Estevam <festevam@gmail.com>:
> commit 739be96 (ASoC: Fix build dependency for SND_ATMEL_SOC_SSC) introduced the following
> recursive dependency:
Hi Fabio,
I already sent a fix for this and the fix is already merged into ASoC tree.
The patch is http://mailman.alsa-project.org/pipermail/alsa-devel/2012-January/047931.html
I think today's linux-next tree will include the fix.

Thanks,
Axel
