From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: [PATCH 2/3] ASoC: mfld_machine: Add support for
	jack detection
Date: Wed, 9 Feb 2011 20:23:30 +0530
Message-ID: <438BB0150E931F4B9CE701519A4463010846D59D3A@bgsmsx502.gar.corp.intel.com>
References: <1297242747-18632-1-git-send-email-vinod.koul@intel.com>
	<1297242747-18632-3-git-send-email-vinod.koul@intel.com>
	<20110209135506.GD24042@opensource.wolfsonmicro.com>
	<438BB0150E931F4B9CE701519A4463010846D59D1B@bgsmsx502.gar.corp.intel.com>
	<20110209143958.GE24042@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 81C2E24463
	for <alsa-devel@alsa-project.org>; Wed,  9 Feb 2011 15:53:36 +0100 (CET)
In-Reply-To: <20110209143958.GE24042@opensource.wolfsonmicro.com>
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

> > The GPIOs in this chip can be programmed using a codec
> > register read/write. Anyone can use the soc_read/write or
> > scu_ipc_read/writes to program the GPIO.
> 
> This is the same as any other CODEC with GPIOs.
> 
> > Would putting one more wrapper over these APIs make it look better?
> 
> Yes, it means that users can just use standard Linux APIs to control the
> GPIOs instead of having to learn about the CODEC register map.
Okay, agreed. I will add the gpiolib support here
(would add that as separate patch)

~Vinod
