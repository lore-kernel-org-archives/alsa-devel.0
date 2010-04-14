From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/2] imx-ssi: do not call hrtimer_disable
 in trigger function
Date: Wed, 14 Apr 2010 08:41:12 +0100
Message-ID: <1271230872.3235.228.camel@odin>
References: <1271229451-26692-1-git-send-email-s.hauer@pengutronix.de>
	<1271229451-26692-2-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 2A1962444A
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Apr 2010 09:41:20 +0200 (CEST)
Received: by wyb29 with SMTP id 29so1452301wyb.38
	for <alsa-devel@alsa-project.org>; Wed, 14 Apr 2010 00:41:18 -0700 (PDT)
In-Reply-To: <1271229451-26692-2-git-send-email-s.hauer@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Valentin Longchamp <valentin.longchamp@epfl.ch>
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-04-14 at 09:17 +0200, Sascha Hauer wrote:
> Doing so causes a deadlock, so just signal the timer to stop
> using an atomic variable.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
