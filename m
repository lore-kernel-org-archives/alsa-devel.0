From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 2/2] ASoC: Trace Wolfson jack detection IRQs
Date: Wed, 22 Dec 2010 10:55:22 +0000
Message-ID: <1293015322.3329.13.camel@odin>
References: <1292976559-11466-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1292976559-11466-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 95191103C1D
	for <alsa-devel@alsa-project.org>; Wed, 22 Dec 2010 11:55:25 +0100 (CET)
Received: by wyi11 with SMTP id 11so4726461wyi.38
	for <alsa-devel@alsa-project.org>; Wed, 22 Dec 2010 02:55:25 -0800 (PST)
In-Reply-To: <1292976559-11466-2-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On Wed, 2010-12-22 at 00:09 +0000, Mark Brown wrote:
> Add jack detection interrupt trace to Wolfson CODEC drivers.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm8350.c |    5 +++++
>  sound/soc/codecs/wm8903.c |    4 ++++
>  sound/soc/codecs/wm8962.c |    3 +++
>  sound/soc/codecs/wm8994.c |    5 +++++
>  4 files changed, 17 insertions(+), 0 deletions(-)
Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
