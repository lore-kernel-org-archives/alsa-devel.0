From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v5] ASoC:Add support for cs42l73 codec
Date: Thu, 20 Oct 2011 15:20:08 +0100
Message-ID: <20111020142007.GE3524@opensource.wolfsonmicro.com>
References: <1318952816-16983-1-git-send-email-brian.austin@cirrus.com>
	<1319013770.23438.184.camel@vkoul-udesk3>
	<EE74D414-85CB-4382-B495-46842866C963@cirrus.com>
	<20111020135811.GA6100@sirena.org.uk>
	<1319118870.9355.4.camel@vkoul-udesk3>
	<EBA4E46B-C386-4800-829D-73CE475FB965@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 515BA247C5
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Oct 2011 16:20:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <EBA4E46B-C386-4800-829D-73CE475FB965@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Austin, Brian" <Brian.Austin@cirrus.com>
Cc: Vinod Koul <vinod.koul@linux.intel.com>, "<alsa-devel@alsa-project.org>" <alsa-devel@alsa-project.org>, "<ramesh.babu@intel.com>" <ramesh.babu@intel.com>, "<joe@nucleusys.com>" <joe@nucleusys.com>, "<heelrod@heelrod.ad.cirrus.com>" <heelrod@heelrod.ad.cirrus.com>, "jeeja.kp" <jeeja.kp@intel.com>, "<lrg@ti.com>" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 20, 2011 at 02:11:32PM +0000, Austin, Brian wrote:

> With the current mixer settings enabling the AMP to be used for
> output, the power is exactly where it is supposed to be.

Could you explain how this works please?  It may be that we're just
missing something about how the chip power is managed here but what
you're describing is definitely not normal.
