From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH v5] ASoC:Add support for cs42l73 codec
Date: Thu, 20 Oct 2011 19:24:30 +0530
Message-ID: <1319118870.9355.4.camel@vkoul-udesk3>
References: <1318952816-16983-1-git-send-email-brian.austin@cirrus.com>
	<1319013770.23438.184.camel@vkoul-udesk3>
	<EE74D414-85CB-4382-B495-46842866C963@cirrus.com>
	<20111020135811.GA6100@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C129247C1
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Oct 2011 16:03:33 +0200 (CEST)
In-Reply-To: <20111020135811.GA6100@sirena.org.uk>
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
Cc: "Austin, Brian" <Brian.Austin@cirrus.com>, "<alsa-devel@alsa-project.org>" <alsa-devel@alsa-project.org>, "<ramesh.babu@intel.com>" <ramesh.babu@intel.com>, "<lrg@ti.com>" <lrg@ti.com>, "<heelrod@heelrod.ad.cirrus.com>" <heelrod@heelrod.ad.cirrus.com>, "jeeja.kp" <jeeja.kp@intel.com>, "<joe@nucleusys.com>" <joe@nucleusys.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-10-20 at 14:58 +0100, Mark Brown wrote:
> On Thu, Oct 20, 2011 at 01:54:06PM +0000, Austin, Brian wrote:
> 
> > The mixer in the codec is configured by the Attenuation mixer controls.
> > You then select the mono/stereo output with the xSP Output Mixer Select.
> > I didn't think we needed to represent that in the DAPM map.
> 
> That would be *extremely* surprising given that DAPM is supposed to
> understand the audio routing through the CODEC so it can tell where the
> connected audio paths go.  Doesn't your current design cause too much of
> the device to be powered up?
Precisely why this should be controlled by DAPM  :)

-- 
~Vinod
