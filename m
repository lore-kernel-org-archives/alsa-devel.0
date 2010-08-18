From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Support non-crystal master clocks
 for WM8731
Date: Wed, 18 Aug 2010 16:22:49 +0100
Message-ID: <1282144969.3117.603.camel@odin>
References: <1282144793-32137-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 430872453C
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Aug 2010 17:22:54 +0200 (CEST)
Received: by wwi18 with SMTP id 18so803989wwi.20
	for <alsa-devel@alsa-project.org>; Wed, 18 Aug 2010 08:22:53 -0700 (PDT)
In-Reply-To: <1282144793-32137-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-08-18 at 16:19 +0100, Mark Brown wrote:
> Instead of unconditionally enabling the crystal oscillator on the WM8731
> only enable it when explicitly selected via set_sysclk(), allowing machine
> drivers to specify that they drive a clock into MCLK alone. This avoids
> any conflicts between the oscillator and the external MCLK source and saves
> power for systems which do not need the oscillator.
> 
> This should also deliver a small power saving on systems using the crystal
> since the oscillator will only be enabled when the ADC or DAC is active.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
