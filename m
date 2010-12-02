From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: asoc device probing and dai question
Date: Thu, 2 Dec 2010 11:25:16 +0000
Message-ID: <20101202112515.GA28575@rakim.wolfsonmicro.main>
References: <438BB0150E931F4B9CE701519A44630104BEE140D2@bgsmsx502.gar.corp.intel.com>
	<20101202110715.GD19267@rakim.wolfsonmicro.main>
	<438BB0150E931F4B9CE701519A44630104BEE140F8@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 69E3E10384C
	for <alsa-devel@alsa-project.org>; Thu,  2 Dec 2010 12:25:17 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <438BB0150E931F4B9CE701519A44630104BEE140F8@bgsmsx502.gar.corp.intel.com>
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

On Thu, Dec 02, 2010 at 04:53:22PM +0530, Koul, Vinod wrote:

> One thing which confused me is the soc-core, there the probe of codec and 
> platform are being called, what is the reason for that?

This allows them to do any initialisation which requires the ALSA card
to be present - the ALSA card is only created once the entire platform
is ready.
