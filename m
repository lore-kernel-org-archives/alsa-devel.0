From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/2] ASoC: TWL6040: Fix playback with 19.2
 Mhz MCLK
Date: Fri, 21 May 2010 10:49:28 +0100
Message-ID: <1274435368.3258.4.camel@odin>
References: <1274395988-19801-1-git-send-email-jorge.candelaria@ti.com>
	<1274395988-19801-2-git-send-email-jorge.candelaria@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 1C6DE103918
	for <alsa-devel@alsa-project.org>;
	Fri, 21 May 2010 11:49:33 +0200 (CEST)
Received: by wyb42 with SMTP id 42so212605wyb.38
	for <alsa-devel@alsa-project.org>; Fri, 21 May 2010 02:49:31 -0700 (PDT)
In-Reply-To: <1274395988-19801-2-git-send-email-jorge.candelaria@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
Cc: Margarita Olaya Cabrera <magi.olaya@ti.com>, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-05-20 at 17:53 -0500, Jorge Eduardo Candelaria wrote:
> When using MCLK is configured for 19.2 Mhz, clock slicer should be
> enabled and HPPLL should be bypassed in clock path.
> 
> Signed-off-by: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
> Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>
> ---

Applied.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
