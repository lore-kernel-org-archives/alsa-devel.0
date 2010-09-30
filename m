From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: WM8804: Initial driver
Date: Thu, 30 Sep 2010 20:28:53 +0100
Message-ID: <1285874933.3101.128.camel@odin>
References: <1285755296-24497-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 2601410394E
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Sep 2010 21:28:57 +0200 (CEST)
Received: by wwb28 with SMTP id 28so2393062wwb.20
	for <alsa-devel@alsa-project.org>; Thu, 30 Sep 2010 12:28:56 -0700 (PDT)
In-Reply-To: <1285755296-24497-1-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-09-29 at 11:14 +0100, Dimitris Papastamos wrote:
> The WM8804 is a high performance consumer mode
> S/PDIF transceiver with support for 1 received channel and
> 1 transmitted channel.
> 
> Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/Kconfig  |    4 +
>  sound/soc/codecs/Makefile |    2 +
>  sound/soc/codecs/wm8804.c |  820 +++++++++++++++++++++++++++++++++++++++++++++
>  sound/soc/codecs/wm8804.h |   61 ++++
>  4 files changed, 887 insertions(+), 0 deletions(-)
>  create mode 100644 sound/soc/codecs/wm8804.c
>  create mode 100644 sound/soc/codecs/wm8804.h
> 

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

but

> +
> +static struct snd_soc_dai_driver wm8804_dai = {
> +	.name = "wm8804-s/pdif",

There may be per DAI debugfs or sysfs info in the future so it's best to
not use a "/" in a name. Can you do an incremental change.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
