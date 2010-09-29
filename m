From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Initial WM8962 IRQ support
Date: Wed, 29 Sep 2010 07:49:29 +0100
Message-ID: <1285742969.31437.117.camel@vega>
References: <1285732406-30090-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 5D5111038B6
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Sep 2010 08:49:32 +0200 (CEST)
Received: by eye27 with SMTP id 27so117654eye.38
	for <alsa-devel@alsa-project.org>; Tue, 28 Sep 2010 23:49:32 -0700 (PDT)
In-Reply-To: <1285732406-30090-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On Tue, 2010-09-28 at 20:53 -0700, Mark Brown wrote:
> Provide an initial hookup for interrupts on the WM8962. Currently we simply
> report error status via log messages if an IRQ is provided for the device.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  include/sound/wm8962.h    |    2 +
>  sound/soc/codecs/wm8962.c |   60 ++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 61 insertions(+), 1 deletions(-)
> 

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
