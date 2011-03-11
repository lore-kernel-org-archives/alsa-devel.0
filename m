From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH RFC] arm: mini2440: Fix uda134x codec
	problem.
Date: Fri, 11 Mar 2011 12:14:11 +0000
Message-ID: <1299845651.3394.47.camel@odin>
References: <1299703580-3957-1-git-send-email-marek.belisko@open-nandra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id BEE58244AF
	for <alsa-devel@alsa-project.org>; Fri, 11 Mar 2011 13:14:15 +0100 (CET)
Received: by wyj26 with SMTP id 26so2276139wyj.38
	for <alsa-devel@alsa-project.org>; Fri, 11 Mar 2011 04:14:15 -0800 (PST)
In-Reply-To: <1299703580-3957-1-git-send-email-marek.belisko@open-nandra.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marek Belisko <marek.belisko@open-nandra.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, broonie@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, ben-linux@fluff.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2011-03-09 at 21:46 +0100, Marek Belisko wrote:
> ASoC audio for mini2440 platform in current kenrel doesn't work.
> First problem is samsung_asoc_dma device is missing in initialization.
> Next problem is with codec. Codec is initialized but never probed
> because no platform_device exist for codec driver. It leads to errors
> during codec binding to asoc dai. Next problem was platform data which
> was passed from board to asoc main driver but not passed to codec when
> called codec_soc_probe().
> 
> Following patch should fix issues. But not sure if in correct way.
> Please review.
> 
> Signed-off-by: Marek Belisko <marek.belisko@open-nandra.com>

Acked-by: Liam Girdwood <lrg@ti.com>
