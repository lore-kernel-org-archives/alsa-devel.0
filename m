From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] ASoC: mfld_machine: Add support for
	jack detection
Date: Wed, 9 Feb 2011 14:39:58 +0000
Message-ID: <20110209143958.GE24042@opensource.wolfsonmicro.com>
References: <1297242747-18632-1-git-send-email-vinod.koul@intel.com>
	<1297242747-18632-3-git-send-email-vinod.koul@intel.com>
	<20110209135506.GD24042@opensource.wolfsonmicro.com>
	<438BB0150E931F4B9CE701519A4463010846D59D1B@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 233852442B
	for <alsa-devel@alsa-project.org>; Wed,  9 Feb 2011 15:40:01 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <438BB0150E931F4B9CE701519A4463010846D59D1B@bgsmsx502.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Koul, Vinod" <vinod.koul@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Harsha,
	Priya" <priya.harsha@intel.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 09, 2011 at 08:08:39PM +0530, Koul, Vinod wrote:

> The GPIOs in this chip can be programmed using a codec
> register read/write. Anyone can use the soc_read/write or
> scu_ipc_read/writes to program the GPIO.

This is the same as any other CODEC with GPIOs.

> Would putting one more wrapper over these APIs make it look better?

Yes, it means that users can just use standard Linux APIs to control the
GPIOs instead of having to learn about the CODEC register map.
