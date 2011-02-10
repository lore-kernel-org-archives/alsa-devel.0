From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Allow use sleeping gpio in soc-jack
Date: Thu, 10 Feb 2011 23:03:52 +0000
Message-ID: <1297379032.3313.46.camel@odin>
References: <1297351343-17297-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id A382A244C3
	for <alsa-devel@alsa-project.org>; Fri, 11 Feb 2011 00:03:56 +0100 (CET)
Received: by wwe15 with SMTP id 15so1914236wwe.20
	for <alsa-devel@alsa-project.org>; Thu, 10 Feb 2011 15:03:56 -0800 (PST)
In-Reply-To: <1297351343-17297-1-git-send-email-jhnikula@gmail.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-02-10 at 17:22 +0200, Jarkko Nikula wrote:
> It is safe to use sleeping gpio in snd_soc_jack_gpio_detect as it is not
> called from interrupt context. This avoids WARN_ON from __gpio_get_value
> if sleeping gpio is registered for jack.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> ---

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
