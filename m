From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Avoid direct register cache access
 when setting defaults
Date: Mon, 17 Jan 2011 13:51:59 +0000
Message-ID: <1295272319.3283.10.camel@odin>
References: <1293713859-4480-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	(sfid-20101230_125733_199121_1B314023)
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id A85AF103818
	for <alsa-devel@alsa-project.org>; Mon, 17 Jan 2011 14:52:03 +0100 (CET)
Received: by wyi11 with SMTP id 11so5146984wyi.38
	for <alsa-devel@alsa-project.org>; Mon, 17 Jan 2011 05:52:03 -0800 (PST)
In-Reply-To: <1293713859-4480-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	(sfid-20101230_125733_199121_1B314023)
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
Cc: Liam Girdwood <lrg@slimglogic.co.uk>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-12-30 at 12:57 +0000, Mark Brown wrote:
> Directly accessing the register cache means that we can't use anything
> except a flat register cache so use snd_soc_update_bits().
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm8523.c |    6 +++---
>  sound/soc/codecs/wm8741.c |   13 ++++++++-----
>  sound/soc/codecs/wm8904.c |   41 ++++++++++++++++++++++++++---------------
>  sound/soc/codecs/wm8955.c |   27 +++++++++++++++++++--------
>  sound/soc/codecs/wm8962.c |   30 ++++++++++++++++++++----------
>  sound/soc/codecs/wm8978.c |    2 +-
>  sound/soc/codecs/wm9090.c |   41 ++++++++++++++++++++++++-----------------
>  7 files changed, 101 insertions(+), 59 deletions(-)

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
