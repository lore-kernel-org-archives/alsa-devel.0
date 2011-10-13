From: Axel Lin <axel.lin@gmail.com>
Subject: Re: [PATCH] ASoC: ak4642: fixup cache register table
Date: Thu, 13 Oct 2011 17:16:37 +0800
Message-ID: <CAF+7xW=10yL411_ko6GKsYtpy1mwteMPt3bUEikPoWfAae=fWA@mail.gmail.com>
References: <1318335653.3573.1.camel@phoenix>
	<87ty7dl0uh.wl%kuninori.morimoto.gx@renesas.com>
Reply-To: axel.lin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id BF5DC10385A
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Oct 2011 11:16:57 +0200 (CEST)
Received: by bkbzu17 with SMTP id zu17so1118291bkb.38
	for <alsa-devel@alsa-project.org>; Thu, 13 Oct 2011 02:16:57 -0700 (PDT)
In-Reply-To: <87ty7dl0uh.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

2011/10/13 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>:
> ak4642 register was 8bit, but cache table was defined as 16bit.
> ak4642 doesn't work correctry without this patch.
>
ak4535 also has the same bug. I'm sending a patch for ak4535.

Regards,
Axel
