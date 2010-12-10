From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 3/3] ASoC: Automatically manage WM8903
 deemphasis rate
Date: Fri, 10 Dec 2010 23:04:04 +0000
Message-ID: <1292022244.3422.29.camel@odin>
References: <1292008628-29457-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1292008628-29457-3-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id F411410380C
	for <alsa-devel@alsa-project.org>; Sat, 11 Dec 2010 00:04:06 +0100 (CET)
Received: by wwe15 with SMTP id 15so4036886wwe.20
	for <alsa-devel@alsa-project.org>; Fri, 10 Dec 2010 15:04:06 -0800 (PST)
In-Reply-To: <1292008628-29457-3-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On Fri, 2010-12-10 at 19:17 +0000, Mark Brown wrote:
> Provide the user with a boolean control then automatically select
> the deemphasis filter most closely matching the sample rate.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm8903.c |   82 ++++++++++++++++++++++++++++++++++++++++----
>  1 files changed, 74 insertions(+), 8 deletions(-)

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
