From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Move WM8994 read/write access data
 into separate file
Date: Thu, 18 Nov 2010 17:40:41 +0000
Message-ID: <1290102041.3328.8.camel@odin>
References: <1290086669-27279-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 3041E10381C
	for <alsa-devel@alsa-project.org>; Thu, 18 Nov 2010 18:40:48 +0100 (CET)
Received: by wyg36 with SMTP id 36so3429832wyg.38
	for <alsa-devel@alsa-project.org>; Thu, 18 Nov 2010 09:40:47 -0800 (PST)
In-Reply-To: <1290086669-27279-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On Thu, 2010-11-18 at 13:24 +0000, Mark Brown wrote:
> Makes the WM8994 driver file itself substantially smaller.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm8994-tables.c | 1575
> +++++++++++++++++++++++++++++++++++++
>  sound/soc/codecs/wm8994.c        | 1582
> +-------------------------------------
>  sound/soc/codecs/wm8994.h        |    9 +
>  3 files changed, 1587 insertions(+), 1579 deletions(-)
>  create mode 100644 sound/soc/codecs/wm8994-tables.c
> 
> 
Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
