From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: Ambiguous DAPM widget names and DPCM
Date: Thu, 25 Jul 2013 20:53:38 +0100
Message-ID: <1374782018.2371.61.camel@loki>
References: <51EE3F18.3030207@gmail.com>
 <20130723123017.GV9858@sirena.org.uk> <51EEA2A3.8030106@gmail.com>
 <20130723183038.GO9858@sirena.org.uk> <51F11916.1080002@gmail.com>
 <20130725124859.GC9858@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 6FB4D2608D7
 for <alsa-devel@alsa-project.org>; Thu, 25 Jul 2013 21:54:08 +0200 (CEST)
In-Reply-To: <20130725124859.GC9858@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, ALSA development <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2013-07-25 at 13:48 +0100, Mark Brown wrote:
> On Thu, Jul 25, 2013 at 02:24:54PM +0200, Daniel Mack wrote:
> > On 23.07.2013 20:30, Mark Brown wrote:

> 
> > > The prefix mechanism is intended to address this; however it's only
> > > currently supported for CODECs.  If we move the prefixes to components
> > > then they should be usable for CPU DAIs.
> 
> > But that's a static string as well. How can we distiguish between two
> > Codecs of the same type, or two McASP instances?
> 
> The point is to give a different prefix to each device; giving the same
> prefix to different devices rather defeats the poinnt.

I don't think we had any issues with DAI global naming on OMAP4 (we were
probably just lucky I guess). We had several physical McBSP and several
logical McPDM interfaces that were used by the ABE and they were
globally connected in the machine driver using the DAI device name e.g.
"omap-mcbsp.1"

Fwiw, I've just looked at Peter's topic/ti-audio-next-bnw-wip branch at
gitorious.org:omap-audio/linux-audio.git and can see we may be missing a
couple of patches that can affect the DAI connections i.e.
35f485c300d514225710af4a436c987b15b9b690. These are not required for
DPCM on Haswell (where I connect to DAIs SSP0 and SSP1) and were written
before Mark upstreamed the CODEC<->CODEC work which also supported
widget DAI connections. It may be that some of these patches are still
required for some configurations. Peter, you may be able to drop some of
these patches since CODEC<->CODEC provides similar DAI widget
functionality. 

We probably have to address the local/global context for widget naming
as Mark suggests. I guess that the global context will only apply to the
machine driver whilst the local context will only be used for component
drivers. This may just mean some changes for machine drivers in the way
we connect to component driver widgets.

Liam
