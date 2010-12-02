From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: omap: N810: Don't select
 CONFIG_OMAP_MUX but make it as dependency
Date: Thu, 02 Dec 2010 11:50:53 +0000
Message-ID: <1291290653.3262.48.camel@odin>
References: <1291194080-8101-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 9FB5C103A73
	for <alsa-devel@alsa-project.org>; Thu,  2 Dec 2010 12:50:56 +0100 (CET)
Received: by mail-wy0-f179.google.com with SMTP id 11so8111623wyi.38
	for <alsa-devel@alsa-project.org>; Thu, 02 Dec 2010 03:50:56 -0800 (PST)
In-Reply-To: <1291194080-8101-1-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, alsa-devel@alsa-project.org, Brown <broonie@opensource.wolfsonmicro.com>, Mark@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-12-01 at 11:01 +0200, Jarkko Nikula wrote:
> Not all omap boards use kernel based pin multiplexing so
> CONFIG_SND_OMAP_SOC_N810 should not select it by default as it can make
> harm to other boards in multi-board kernels.
> 
> Therefore put CONFIG_OMAP_MUX as a dependency to N810 ASoC machine driver.
> 
> Thanks to Tony Lindgren <tony@atomide.com> for noticing.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> Cc: Tony Lindgren <tony@atomide.com>
> ---
Applied.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
