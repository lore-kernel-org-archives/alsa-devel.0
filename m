From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: asoc register read/write calls
Date: Thu, 25 Nov 2010 09:01:18 +0530
Message-ID: <438BB0150E931F4B9CE701519A44630104BECC842A@bgsmsx502.gar.corp.intel.com>
References: <438BB0150E931F4B9CE701519A44630104BECC82EB@bgsmsx502.gar.corp.intel.com>
	<20101124125421.GB13507@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id DBD4B103B4D
	for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2010 04:32:34 +0100 (CET)
In-Reply-To: <20101124125421.GB13507@sirena.org.uk>
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
	Priya" <priya.harsha@intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 24, 2010 at 6:24PM +0530, Mark Brown wrote:
> On Wed, Nov 24, 2010 at 06:11:51PM +0530, Koul, Vinod wrote:
> > Mark,
> 
> Please remember to always CC maintainers on posts to the mailing lists.
> I've reminded you of this on quite a few previous occasions.
I apologize for this, will be double careful in future...

> > In the asoc framework, do the codec register read-write calls need to be
> atomic?
> > Will it work in non-atomic context?
> 
> There is no requirement for atomic context, in fact vanishingly few
> CODECs can be accessed in atomic context as pretty much all of them
> are controlled using I2C or SPI.
I don't have SPI or I2C to read/write my codec :-(
I need to use read/write apis defined in <asm/intel_scu_ipc.h>
	int intel_scu_ipc_ioread8(u16 addr, u8 *data);
	int intel_scu_ipc_iowrite8(u16 addr, u8 data);
and these can block a little while they get/set the data.

But since that is not an issue, makes my life easy :-)

Thanks
~Vinod
