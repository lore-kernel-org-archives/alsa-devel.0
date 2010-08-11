From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/2] asoc/multi-component: remove
 superfluous snd_card member from snd_soc_codec
Date: Wed, 11 Aug 2010 14:44:29 +0100
Message-ID: <1281534269.3080.113.camel@odin>
References: <1281529786-5267-1-git-send-email-s.hauer@pengutronix.de>
	<1281529786-5267-2-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id AEEF6103872
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Aug 2010 15:44:34 +0200 (CEST)
Received: by wwa36 with SMTP id 36so100251wwa.20
	for <alsa-devel@alsa-project.org>; Wed, 11 Aug 2010 06:44:34 -0700 (PDT)
In-Reply-To: <1281529786-5267-2-git-send-email-s.hauer@pengutronix.de>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-08-11 at 14:29 +0200, Sascha Hauer wrote:
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  include/sound/soc.h  |    1 -
>  sound/soc/soc-core.c |    6 +++---
>  sound/soc/soc-dapm.c |    6 +++---
>  sound/soc/soc-jack.c |    2 +-
>  4 files changed, 7 insertions(+), 8 deletions(-)
> 

Both applied.

Thanks.

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
