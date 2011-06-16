From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 0/5] AD1836 updates part two
Date: Thu, 16 Jun 2011 09:35:59 +0100
Message-ID: <4DF9C06F.5050600@ti.com>
References: <1308166163-22355-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id EC93C24632
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Jun 2011 10:36:12 +0200 (CEST)
In-Reply-To: <1308166163-22355-1-git-send-email-vapier@gentoo.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Lars-Peter Clausen <lars@metafoo.de>, "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 15/06/11 20:29, Mike Frysinger wrote:
> This replaces the patchset I sent out yesterday.  It mostly syncs the
> missing work we had locally with what Lars-Peter did.  I guess we can
> omit the "ad1836" -> "ad183x" rename.
> 
> Barry Song (1):
>   ASoC: AD1836: rename suspend/resume funcs
> 
> Mike Frysinger (4):
>   ASoC: AD1836: drop unnecessary spi register check
>   ASoC: AD1836: fix intermixed tab/space indentation
>   ASoC: AD1836: fix codec name
>   ASoC: AD1836: clean up comment headers
> 
>  sound/soc/codecs/ad1836.c |   78 +++++++++++++++++---------------------------
>  sound/soc/codecs/ad1836.h |   21 +++---------
>  2 files changed, 36 insertions(+), 63 deletions(-)
> 

All

Acked-by: Liam Girdwood <lrg@ti.com>
