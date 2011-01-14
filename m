From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/4] ASoC: soc core allow machine driver to
 register the card
Date: Fri, 14 Jan 2011 11:37:26 +0000
Message-ID: <20110114113725.GA20846@opensource.wolfsonmicro.com>
References: <1294939150-26443-1-git-send-email-vinod.koul@intel.com>
	<20110113234135.GD13717@opensource.wolfsonmicro.com>
	<438BB0150E931F4B9CE701519A4463010844672180@bgsmsx502.gar.corp.intel.com>
	<20110114105224.GA13256@opensource.wolfsonmicro.com>
	<438BB0150E931F4B9CE701519A4463010844672488@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 83EE3103B98
	for <alsa-devel@alsa-project.org>; Fri, 14 Jan 2011 12:37:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <438BB0150E931F4B9CE701519A4463010844672488@bgsmsx502.gar.corp.intel.com>
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
	Priya" <priya.harsha@intel.com>, "Bensaid,
	Selma" <selma.bensaid@intel.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 14, 2011 at 04:55:47PM +0530, Koul, Vinod wrote:

> > If that's all it is then the check should be changed to return -EINVAL
> > or similar as this is an error which prevents the device being
> > instantiated.  It shouldn't pretend it succeeded, and not doing so will
> > save us having to check in any of the other functions.

> Agreed, but on the other hand if someone is using register api they should
> not be creating the device, so probe shouldn't be called at all.
> We can leave this check. What do you think?

I think the check should be changed to report an error since they should
never be calling this function in the first place; this is the standard
thing for devices with an invalid setup.
