From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ALSA: ASoC V2: disable automatic volume
 control in the CS4270 sound driver
Date: Fri, 22 Aug 2008 16:18:49 -0500
Message-ID: <48AF2D39.6000701@freescale.com>
References: <1218126153-26095-1-git-send-email-timur@freescale.com>
	<1218126153-26095-2-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 45E67243B7
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Aug 2008 23:18:58 +0200 (CEST)
In-Reply-To: <1218126153-26095-2-git-send-email-timur@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lg@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Timur Tabi wrote:
> Disable the automatic volume control feature of the CS4270 audio codec.  This
> feature, which is enabled by default, causes volume change commands to be
> delayed.  Sometimes the volume change happens after playback is started.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> 
> This patch is for ASoC V2.

Did you guys forget about this patch?  I don't see it in asoc-v2-dev.

-- 
Timur Tabi
Linux kernel developer at Freescale
