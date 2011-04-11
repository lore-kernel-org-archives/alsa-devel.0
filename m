From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Add WM8915 CODEC driver
Date: Mon, 11 Apr 2011 20:59:11 +0100
Message-ID: <1302551951.3449.62.camel@odin>
References: <1302497736-10534-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 70BE1103883
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Apr 2011 21:59:15 +0200 (CEST)
Received: by wyg36 with SMTP id 36so5578658wyg.38
	for <alsa-devel@alsa-project.org>; Mon, 11 Apr 2011 12:59:15 -0700 (PDT)
In-Reply-To: <1302497736-10534-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On Sun, 2011-04-10 at 21:55 -0700, Mark Brown wrote:
> 
> The WM8915 is an ultra low power mobile CODEC designed for
> smartphones,
> featuring a mixture of digital and analogue I/O with flexible mixing
> options and advanced low power accessory detection functionality in a
> compact package.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  include/sound/wm8915.h    |   55 +
>  sound/soc/codecs/Kconfig  |    4 +
>  sound/soc/codecs/Makefile |    2 +
>  sound/soc/codecs/wm8915.c | 2925 +++++++++++++++++++++++++++++++++++
>  sound/soc/codecs/wm8915.h | 3717
> +++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 6703 insertions(+), 0 deletions(-)
>  create mode 100644 include/sound/wm8915.h
>  create mode 100644 sound/soc/codecs/wm8915.c
>  create mode 100644 sound/soc/codecs/wm8915.h

>  
Acked-by: Liam Girdwood <lrg@ti.com>
