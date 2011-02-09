From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: [PATCH 3/3] ASoC: sn95031: Add support for
	reading	mic bias
Date: Wed, 9 Feb 2011 20:39:46 +0530
Message-ID: <438BB0150E931F4B9CE701519A4463010846D59D4C@bgsmsx502.gar.corp.intel.com>
References: <1297242747-18632-1-git-send-email-vinod.koul@intel.com>
	<1297242747-18632-4-git-send-email-vinod.koul@intel.com>
	<20110209150606.GF24042@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id D018224490
	for <alsa-devel@alsa-project.org>; Wed,  9 Feb 2011 16:09:52 +0100 (CET)
In-Reply-To: <20110209150606.GF24042@opensource.wolfsonmicro.com>
Content-Language: en-US
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Harsha,
	Priya" <priya.harsha@intel.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

> >
> > This patch adds support to read the mic bias voltage
> > when a jack is inserted. It uses ADC to measure.
> 
> This looks OK.
Thanks for the review.
I will fix patch 1, and remove the gpios stuff from patch 2.
For gpiolib I will send a seprate patch

~Vinod
