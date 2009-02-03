From: pHilipp Zabel <philipp.zabel@gmail.com>
Subject: Re: [PATCH 3/4] ASoC: pxa2xx-i2s: remove GPIO pin setup
Date: Tue, 3 Feb 2009 17:56:24 +0100
Message-ID: <74d0deb30902030856g5a48ef52ge4e3fb0c24040b2d@mail.gmail.com>
References: <1233677983-23710-1-git-send-email-philipp.zabel@gmail.com>
	<1233677983-23710-4-git-send-email-philipp.zabel@gmail.com>
	<20090203163223.GE23827@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.154])
	by alsa0.perex.cz (Postfix) with ESMTP id 3E57B10385D
	for <alsa-devel@alsa-project.org>; Tue,  3 Feb 2009 17:56:25 +0100 (CET)
Received: by yw-out-1718.google.com with SMTP id 9so881845ywk.2
	for <alsa-devel@alsa-project.org>; Tue, 03 Feb 2009 08:56:24 -0800 (PST)
In-Reply-To: <20090203163223.GE23827@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Vasily Khoruzhick <anarsoul@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 3, 2009 at 5:32 PM, Mark Brown <broonie@sirena.org.uk> wrote:
> On Tue, Feb 03, 2009 at 05:19:42PM +0100, Philipp Zabel wrote:
>> This should be done during board init via pxa2xx_mfp_config instead.
>
>> Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
>
> It should, but you need to update all the affected boards too.

The affected boards are Corgi, Spitz, Poodle, Magician, AMESOM, H5000,
Mainstone.
Of those only Spitz, H5000 and Mainstone are missing I2S setup in
arch/arm/mach-pxa.
I'll try to get those patches into the PXA tree and then resend this one.

My actual problem with the current code is that pxa2xx-i2s sets up
GPIO30 as I2S SDATA_OUT while on magician that GPIO is connected to
the battery charger.

regards
Philipp
