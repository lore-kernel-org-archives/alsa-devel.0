From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: asoc device probing and dai question
Date: Thu, 2 Dec 2010 11:47:13 +0000
Message-ID: <20101202114712.GB28575@rakim.wolfsonmicro.main>
References: <438BB0150E931F4B9CE701519A44630104BEE140D2@bgsmsx502.gar.corp.intel.com>
	<20101202110715.GD19267@rakim.wolfsonmicro.main>
	<438BB0150E931F4B9CE701519A44630104BEE140F8@bgsmsx502.gar.corp.intel.com>
	<20101202112515.GA28575@rakim.wolfsonmicro.main>
	<438BB0150E931F4B9CE701519A44630104BEE14118@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7B811103A4F
	for <alsa-devel@alsa-project.org>; Thu,  2 Dec 2010 12:47:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <438BB0150E931F4B9CE701519A44630104BEE14118@bgsmsx502.gar.corp.intel.com>
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
	Priya" <priya.harsha@intel.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 02, 2010 at 05:08:51PM +0530, Koul, Vinod wrote:

> So I am thinking now that since my platform tells me that I have only one audio 
> device which is platform device, so should I add my codec device and platform 
> device same way as I add the soc-audio from my machine driver. That way I can 
> even change codec's based on what I detect on the board.

> And platform and codec driver probe register the dais

> Would that be the right approach?

Ideally your platform would also register the devices separately
(especialy the CODEC which would usually be instantiated by whatever
bus it's on, or the probe of the core driver for the CODEC if it's an
MFD like yours are in silicon) but if you're limited in this way then 
it's a good approach.

It may be worth separating out the device registration from the rest of
the machine driver for clarity.
