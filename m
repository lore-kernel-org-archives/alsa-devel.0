From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/3] ASoC: Use card rather than soc-audio
 device to card PM functions
Date: Wed, 26 Jan 2011 20:12:26 +0000
Message-ID: <1296072746.3298.46.camel@odin>
References: <1296061709-12494-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id AD35E103A0B
	for <alsa-devel@alsa-project.org>; Wed, 26 Jan 2011 21:12:29 +0100 (CET)
Received: by wyi11 with SMTP id 11so1304092wyi.38
	for <alsa-devel@alsa-project.org>; Wed, 26 Jan 2011 12:12:29 -0800 (PST)
In-Reply-To: <1296061709-12494-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2011-01-26 at 17:08 +0000, Mark Brown wrote:
> The platform device for the card is tied closely to the soc-audio
> implementation which we're currently trying to remove in favour of
> allowing cards to have their own devices. Begin removing it by
> replacing it with the card in the suspend and resume callbacks we
> give to cards, also taking the opportunity to remove the legacy
> suspend types which are currently hard coded anyway.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  include/sound/soc.h      |    8 ++++----
>  sound/soc/pxa/raumfeld.c |    4 ++--
>  sound/soc/pxa/zylonite.c |    5 ++---
>  sound/soc/soc-core.c     |    9 ++++-----
>  4 files changed, 12 insertions(+), 14 deletions(-)

All

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
