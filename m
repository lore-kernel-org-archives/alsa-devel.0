From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3] ASoC: Add support for cs42l73 codec
Date: Fri, 7 Oct 2011 15:27:42 +0100
Message-ID: <20111007142742.GI14518@opensource.wolfsonmicro.com>
References: <1317917945-32580-1-git-send-email-brian.austin@cirrus.com>
	<20111006185746.GA17685@opensource.wolfsonmicro.com>
	<10520301-F8F9-4096-91F8-141F22CEA68C@cirrus.com>
	<20111007103359.GG19080@opensource.wolfsonmicro.com>
	<1317985636.1573.2272.camel@vkoul-udesk3>
	<20111007114239.GB24534@sirena.org.uk>
	<F41D058E-D2A8-4046-B391-1452889ED54C@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A4A8B103B91
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Oct 2011 16:27:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <F41D058E-D2A8-4046-B391-1452889ED54C@cirrus.com>
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
Cc: Vinod Koul <vinod.koul@linux.intel.com>, "<joe@nucleusys.com>" <joe@nucleusys.com>, "<lrg@ti.com>" <lrg@ti.com>, "<alsa-devel@alsa-project.org>" <alsa-devel@alsa-project.org>, "<ramesh.babu@intel.com>" <ramesh.babu@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 07, 2011 at 02:05:57PM +0000, Austin, Brian wrote:

> The way to enable the output is to enable the output pin.  I have no control in SW 
> over the DAC's. The pins are power controlled of course. I know it looks strange, 
> but without using a machine driver to enable/disable the pins for a certain route, 
> this seems to be the best solution.

Right, which is why I'm saying this routing makes no sense.  You've got
code which has a mixer mixing input signals down into the DAC but what
you've actually got is a single output from the DAC which can then be
sent to the outputs separately.  You should be able to draw a graph of
the audio routes through the CODEC which directly corresponds to the
DAPM graph.
