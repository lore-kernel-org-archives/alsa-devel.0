From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 0/2] ASoC: Override codec compress_type
 from the machine driver
Date: Fri, 03 Dec 2010 16:14:41 +0000
Message-ID: <1291392881.3271.141.camel@odin>
References: <1291306266-4907-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f42.google.com (mail-ew0-f42.google.com
	[209.85.215.42]) by alsa0.perex.cz (Postfix) with ESMTP id 93BD22453C
	for <alsa-devel@alsa-project.org>; Fri,  3 Dec 2010 17:14:44 +0100 (CET)
Received: by ewy1 with SMTP id 1so5223368ewy.29
	for <alsa-devel@alsa-project.org>; Fri, 03 Dec 2010 08:14:44 -0800 (PST)
In-Reply-To: <1291306266-4907-1-git-send-email-dp@opensource.wolfsonmicro.com>
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

On Thu, 2010-12-02 at 16:11 +0000, Dimitris Papastamos wrote:
> This patch adds support for overriding the compress_type of the codec driver
> from the machine driver.  This patch depends on the previous series of patches
> that I've submitted with Subject "ASoC: Laying the groundwork for
> compress_type overriding".
> 
> Dimitris Papastamos (2):
>   ASoC: soc-cache: Use reg_def_copy instead of reg_cache_default
>   ASoC: soc-core: Allow machine drivers to override compress_type
> 
>  include/sound/soc.h   |    2 +
>  sound/soc/soc-cache.c |   36 +++++++++++++-------
>  sound/soc/soc-core.c  |   87 +++++++++++++++++++++++++++++++++++++++++++-----
>  3 files changed, 104 insertions(+), 21 deletions(-)
> 

All

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
