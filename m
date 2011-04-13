From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ARM: s3c2440: gta02;
 Register dfbmcs320 device
Date: Wed, 13 Apr 2011 08:43:48 +0100
Message-ID: <1302680628.3600.15.camel@odin>
References: <1302641464-27494-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id A1526103956
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Apr 2011 09:43:52 +0200 (CEST)
Received: by wyg36 with SMTP id 36so287750wyg.38
	for <alsa-devel@alsa-project.org>; Wed, 13 Apr 2011 00:43:52 -0700 (PDT)
In-Reply-To: <1302641464-27494-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Kukjin Kim <kgene.kim@samsung.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-04-12 at 22:51 +0200, Lars-Peter Clausen wrote:
> Register the dfbmcs320 device which provides the PCM DAI for the bluetooth
> module.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  arch/arm/mach-s3c2440/mach-gta02.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 

Acked-by: Liam Girdwood <lrg@ti.com>
