From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ASoC: dapm: Remove bodges for no-widget
	CODECs
Date: Mon, 19 Mar 2012 13:11:21 -0500
Message-ID: <4F6776C9.3080003@freescale.com>
References: <1331219169-21998-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
	(va3ehsobe006.messaging.microsoft.com [216.32.180.16])
	by alsa0.perex.cz (Postfix) with ESMTP id 8079A1041DC
	for <alsa-devel@alsa-project.org>; Mon, 19 Mar 2012 19:11:36 +0100 (CET)
In-Reply-To: <1331219169-21998-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> Now that we're creating widgets for all DAIs there should be no more
> need for the bodges we've been carrying for non-DAPM CODEC drivers so
> remove them.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
> 
> I don't actually have any no widget CODECs so can't really test - Timur,
> would it be possible for you to give it a spin?

It doesn't break anything, so:

Acked-by: Timur Tabi <timur@freescale.com>

Note that I don't have any DAPM support on my board.

-- 
Timur Tabi
Linux kernel developer at Freescale
