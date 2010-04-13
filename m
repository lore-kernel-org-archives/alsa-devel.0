From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/2] imx-ssi: do not call hrtimer_disable
 in trigger function
Date: Tue, 13 Apr 2010 16:36:06 +0100
Message-ID: <1271172966.3235.56.camel@odin>
References: <1271169489-339-1-git-send-email-s.hauer@pengutronix.de>
	<1271169489-339-2-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f220.google.com (mail-bw0-f220.google.com
	[209.85.218.220])
	by alsa0.perex.cz (Postfix) with ESMTP id 6E9641037E3
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Apr 2010 17:36:13 +0200 (CEST)
Received: by bwz20 with SMTP id 20so8902658bwz.32
	for <alsa-devel@alsa-project.org>; Tue, 13 Apr 2010 08:36:13 -0700 (PDT)
In-Reply-To: <1271169489-339-2-git-send-email-s.hauer@pengutronix.de>
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

On Tue, 2010-04-13 at 16:38 +0200, Sascha Hauer wrote:
> This causes a deadlock.
> 

Code looks fine. Can you fixup the commit message, I assume this patch
fixes rather than causes the deadlock ?

Thanks

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
