From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] [ALSA] soc - fsl_ssi.c fix "BUG:
	scheduling while atomic"
Date: Thu, 08 May 2008 14:19:36 -0500
Message-ID: <48235248.70305@freescale.com>
References: <20080508160112.GA17085@polina.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 8056624797
	for <alsa-devel@alsa-project.org>;
	Thu,  8 May 2008 21:19:41 +0200 (CEST)
In-Reply-To: <20080508160112.GA17085@polina.dev.rtsoft.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Anton Vorontsov wrote:

> We must not sleep with irqs disabled, so replace msleep with mdelay.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Acked-By: Timur Tabi <timur@freescale.com>

Anton, can you try testing the code with the call to mdelay/msleep commented
out?  On my quick test, I didn't need it, so I have a suspicion that it was
needed only for the old 1.0 silicon.

-- 
Timur Tabi
Linux kernel developer at Freescale
