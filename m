From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 0/4] ASoC: Regression fix for OMAP in DT
 boot (3.11)
Date: Thu, 11 Jul 2013 16:23:24 +0200
Message-ID: <51DEBFDC.4000607@ti.com>
References: <1373546146-30271-1-git-send-email-peter.ujfalusi@ti.com>
 <51DEBAE2.6060709@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id B6CD6265884
 for <alsa-devel@alsa-project.org>; Thu, 11 Jul 2013 16:23:29 +0200 (CEST)
In-Reply-To: <51DEBAE2.6060709@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On 07/11/2013 04:02 PM, Lars-Peter Clausen wrote:
> Looks good, all 4 patches:
> Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks

> But I'm wondering who do you register the PCM device in the DT case? Do y=
ou
> have a separate DT node for the PCM device?

It is a platform_device right now registered in arch/arm/mach-omap2/devices=
.c
We do not have and I don't plan to have DT node for it. The device for the =
PCM
is registered if soc audio is selected for OMAP.

-- =

P=E9ter
