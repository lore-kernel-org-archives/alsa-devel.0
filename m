From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/2] ASoC: Intel: cleanup runtime_pm
 initialization
Date: Thu, 20 Nov 2014 14:42:08 +0530
Message-ID: <20141120091208.GF2074@intel.com>
References: <1416390207-11020-1-git-send-email-vinod.koul@intel.com>
 <20141119105655.GE22111@sirena.org.uk>
 <F46914AEC2663F4A9BB62374E5EEF8F82B7427B5@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id B032F2605F5
 for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2014 10:11:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <F46914AEC2663F4A9BB62374E5EEF8F82B7427B5@SHSMSX101.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Lin, Mengdong" <mengdong.lin@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 20, 2014 at 02:35:33PM +0530, Lin, Mengdong wrote:
> Hi Mark and Vinod,
Please don't top post

> 
> Could you tell me where are the two patches in git repo?
> 
> I cannot find them on topic/intel branch.
> I want to rebase the Cherrytrail/Braswell machine driver on the two
> applied patches.

I think Mark forgot to push :) don't see update to tree since yesterday

-- 
~Vinod
> 
> Thanks
> Mengdong
> 
> > -----Original Message-----
> > From: alsa-devel-bounces@alsa-project.org
> > [mailto:alsa-devel-bounces@alsa-project.org] On Behalf Of Mark Brown
> > Sent: Wednesday, November 19, 2014 6:57 PM
> > To: Koul, Vinod
> > Cc: alsa-devel@alsa-project.org; lgirdwood@gmail.com
> > Subject: Re: [alsa-devel] [PATCH 1/2] ASoC: Intel: cleanup runtime_pm
> > initialization
> > 
> > On Wed, Nov 19, 2014 at 03:13:26PM +0530, Vinod Koul wrote:
> > > For ACPI we missed to pm_runtime_enable() call which is required to
> > > tell PM core that runtime on this device is enabled now. Since this is
> > > common to both PCI and APCI move it out. Also for ACPI we do not
> > > require
> > > pm_runtime_allow() call, so remove that
> > 
> > Applied, thanks.

-- 
