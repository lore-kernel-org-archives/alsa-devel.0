From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] ASoC: Clean up the CODEC device as
 well as the board for SMDK WM9713
Date: Fri, 24 Sep 2010 13:01:40 +0100
Message-ID: <20100924120140.GL32112@rakim.wolfsonmicro.main>
References: <1285252845-24171-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1285252845-24171-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<AANLkTi=8G9jt7KWafeUhinWCQMqRtxfXY1ZxwSNZBby1@mail.gmail.com>
	<20100923145614.GJ25663@rakim.wolfsonmicro.main>
	<AANLkTiksrurq_GQOp7gmZ=NeWX8NQFq2W2cA7hvwPveP@mail.gmail.com>
	<20100924092223.GH32112@rakim.wolfsonmicro.main>
	<AANLkTi=e0LK+1cD8x6iQv+GE3awrnO1yX585e6yxhrSF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E27E91039A1
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Sep 2010 14:01:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=e0LK+1cD8x6iQv+GE3awrnO1yX585e6yxhrSF@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Jassi Brar <jassi.brar@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 24, 2010 at 08:10:50PM +0900, Jassi Brar wrote:
> On Fri, Sep 24, 2010 at 6:22 PM, Mark Brown

> > Could you be more specific about what other changes you believe are
> > needed?

> IIUIC, the aim of this patch is to be able to reload the module, which isn't
> going to work simply with this chage - we need to do as well something
> about the 'soc-audio' platform device added the first time ?
> So IMHO, this change is a right step but not enough.

As I said in reply to your earlier mail the pre-existing code in the
driver already does that:

--- a/sound/soc/s3c24xx/smdk_wm9713.c
+++ b/sound/soc/s3c24xx/smdk_wm9713.c
@@ -95,6 +95,7 @@ err:
 static void __exit smdk_exit(void)
 {
        platform_device_unregister(smdk_snd_ac97_device);

This preexisting line from the context is cleaning up the soc-audio
device.

+       platform_device_unregister(smdk_snd_wm9713_device);

This new line cleans up the wm9713-codec device which is also added in
the probe function (yay AC'97!).

Reloading the module works, I've been doing that rather a lot.
