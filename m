From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: [RFC 3/4] ASoC SST: add mid machine driver
Date: Tue, 28 Dec 2010 21:13:45 +0530
Message-ID: <438BB0150E931F4B9CE701519A44630104C104CF84@bgsmsx502.gar.corp.intel.com>
References: <1293538287-31918-1-git-send-email-vinod.koul@intel.com>
	<20101228145757.GE31883@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 2FC4F2413A
	for <alsa-devel@alsa-project.org>; Tue, 28 Dec 2010 16:43:51 +0100 (CET)
In-Reply-To: <20101228145757.GE31883@opensource.wolfsonmicro.com>
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
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Harsha, Priya" <priya.harsha@intel.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 28, 2010 at 08:28:04PM +0530, Mark Brown wrote:
> On Tue, Dec 28, 2010 at 05:41:27PM +0530,  Koul, Vinod wrote:
> > From: Vinod Koul <vinod.koul@intel.com>
> >
> > This patch adds the mic machine driver
> > The mid machine driver glues the msic and mid_platfrom driver to form the
> asoc sound driver
> 
> A machine driver should be for a particular machine, describing how the
> various components have been connected on that particular machine.  This
> looks like you're trying to do a single machine driver for all systems.
Yes that is the intention, that's why a table.
At least currently we plan to use single machine driver for two platforms and
having 4 codecs. For now most of the code is reuse in machine driver so would
make sense to have common driver.

> Probably this should have some sort of name indicating that it's for use
> with systems that are trying to do something using the BIOS scheme
> you've got for these systems; I'd expect that if the systems get much
> traction in the market you'll also end up with systems implementing
> regular ASoC machine drivers too.
Yes I am also divided on which approach to take

~Vinod
