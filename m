From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/2] ASoC: omap: rx51: Add stereo output
 support to audio jack
Date: Thu, 27 Jan 2011 20:49:27 +0000
Message-ID: <1296161367.3376.58.camel@odin>
References: <1296139632-17457-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 9D86C10380A
	for <alsa-devel@alsa-project.org>; Thu, 27 Jan 2011 21:50:17 +0100 (CET)
Received: by wwe15 with SMTP id 15so2498794wwe.20
	for <alsa-devel@alsa-project.org>; Thu, 27 Jan 2011 12:50:17 -0800 (PST)
In-Reply-To: <1296139632-17457-1-git-send-email-jhnikula@gmail.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-01-27 at 16:47 +0200, Jarkko Nikula wrote:
> Audio jack in Nokia RX-51/N900 is driven by TPA6130 headphone amplifier.
> This patch adds support for it and stereo output can be active when
> "Jack Function" == "TV-OUT" || "Headphone".
> 
> As the TPA6130 can output very high volume levels the output is limited
> with snd_soc_limit_volume. Limiting value is found from Maemo kernel sources.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
> Just repost with Mark's ack added. Previous thread here:
> http://mailman.alsa-project.org/pipermail/alsa-devel/2011-January/035312.html
> ---
>  sound/soc/omap/Kconfig |    1 +
>  sound/soc/omap/rx51.c  |   43 +++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 40 insertions(+), 4 deletions(-)
> 

Applied.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
