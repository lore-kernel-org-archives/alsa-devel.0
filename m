From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Constify struct snd_soc_codec_driver
Date: Fri, 03 Dec 2010 16:16:33 +0000
Message-ID: <1291392993.3271.143.camel@odin>
References: <1291389969-8392-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f41.google.com (mail-ww0-f41.google.com [74.125.82.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 7C426103B19
	for <alsa-devel@alsa-project.org>; Fri,  3 Dec 2010 17:16:36 +0100 (CET)
Received: by wwi18 with SMTP id 18so1191187wwi.2
	for <alsa-devel@alsa-project.org>; Fri, 03 Dec 2010 08:16:36 -0800 (PST)
In-Reply-To: <1291389969-8392-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On Fri, 2010-12-03 at 15:26 +0000, Mark Brown wrote:
> Allow the CODEC driver structure to be marked const by making all
> the APIs that use it do so.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  include/sound/soc.h   |    4 ++--
>  sound/soc/soc-cache.c |   13 +++++++------
>  sound/soc/soc-core.c  |    5 +++--
>  3 files changed, 12 insertions(+), 10 deletions(-)
> 

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
