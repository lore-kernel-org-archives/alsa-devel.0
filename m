From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: asoc device probing and dai question
Date: Thu, 2 Dec 2010 17:08:51 +0530
Message-ID: <438BB0150E931F4B9CE701519A44630104BEE14118@bgsmsx502.gar.corp.intel.com>
References: <438BB0150E931F4B9CE701519A44630104BEE140D2@bgsmsx502.gar.corp.intel.com>
	<20101202110715.GD19267@rakim.wolfsonmicro.main>
	<438BB0150E931F4B9CE701519A44630104BEE140F8@bgsmsx502.gar.corp.intel.com>
	<20101202112515.GA28575@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 6A6A1103828
	for <alsa-devel@alsa-project.org>; Thu,  2 Dec 2010 12:39:04 +0100 (CET)
In-Reply-To: <20101202112515.GA28575@rakim.wolfsonmicro.main>
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
	Priya" <priya.harsha@intel.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org


> > One thing which confused me is the soc-core, there the probe of codec and
> > platform are being called, what is the reason for that?
> 
> This allows them to do any initialisation which requires the ALSA card
> to be present - the ALSA card is only created once the entire platform
> is ready.

Thanks
So I am thinking now that since my platform tells me that I have only one audio 
device which is platform device, so should I add my codec device and platform 
device same way as I add the soc-audio from my machine driver. That way I can 
even change codec's based on what I detect on the board.

And platform and codec driver probe register the dais

Would that be the right approach?

~Vinod
