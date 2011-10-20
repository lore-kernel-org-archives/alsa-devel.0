From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v5] ASoC:Add support for cs42l73 codec
Date: Thu, 20 Oct 2011 14:58:11 +0100
Message-ID: <20111020135811.GA6100@sirena.org.uk>
References: <1318952816-16983-1-git-send-email-brian.austin@cirrus.com>
	<1319013770.23438.184.camel@vkoul-udesk3>
	<EE74D414-85CB-4382-B495-46842866C963@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 0F92D247B7
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Oct 2011 15:58:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <EE74D414-85CB-4382-B495-46842866C963@cirrus.com>
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
Cc: Vinod Koul <vinod.koul@linux.intel.com>, "<alsa-devel@alsa-project.org>" <alsa-devel@alsa-project.org>, "<ramesh.babu@intel.com>" <ramesh.babu@intel.com>, "<lrg@ti.com>" <lrg@ti.com>, "<heelrod@heelrod.ad.cirrus.com>" <heelrod@heelrod.ad.cirrus.com>, "jeeja.kp" <jeeja.kp@intel.com>, "<joe@nucleusys.com>" <joe@nucleusys.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 20, 2011 at 01:54:06PM +0000, Austin, Brian wrote:

> The mixer in the codec is configured by the Attenuation mixer controls.
> You then select the mono/stereo output with the xSP Output Mixer Select.
> I didn't think we needed to represent that in the DAPM map.

That would be *extremely* surprising given that DAPM is supposed to
understand the audio routing through the CODEC so it can tell where the
connected audio paths go.  Doesn't your current design cause too much of
the device to be powered up?
