From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: asoc device probing and dai question
Date: Thu, 2 Dec 2010 16:53:22 +0530
Message-ID: <438BB0150E931F4B9CE701519A44630104BEE140F8@bgsmsx502.gar.corp.intel.com>
References: <438BB0150E931F4B9CE701519A44630104BEE140D2@bgsmsx502.gar.corp.intel.com>
	<20101202110715.GD19267@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 0C64B103A4C
	for <alsa-devel@alsa-project.org>; Thu,  2 Dec 2010 12:23:28 +0100 (CET)
In-Reply-To: <20101202110715.GD19267@rakim.wolfsonmicro.main>
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

On Thu, Dec 02, 2010 at 04:37:29PM +0530, Mark Brown wrote:
> On Thu, Dec 02, 2010 at 04:31:07PM +0530, Koul, Vinod wrote:
> 
> > So should I continue to register the dai for both cpu and codec in machine
> > probe. I didn't see other driver in soc/ doing this, so did I miss something.
> 
> No, this is the wrong approach.  The machine driver should not be
> registering anything except itself.  The CODEC and CPU drivers should be
> being probed independantly in whatever way they would normally be probed
> for the bus they're on. 

Thanks.
One thing which confused me is the soc-core, there the probe of codec and 
platform are being called, what is the reason for that?

~Vinod
