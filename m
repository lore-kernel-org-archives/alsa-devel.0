From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH 1/2] ASoC: Intel: cleanup
	runtime_pm	initialization
Date: Thu, 20 Nov 2014 09:05:33 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F82B7427B5@SHSMSX101.ccr.corp.intel.com>
References: <1416390207-11020-1-git-send-email-vinod.koul@intel.com>
 <20141119105655.GE22111@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 500FB2605F6
 for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2014 10:06:37 +0100 (CET)
In-Reply-To: <20141119105655.GE22111@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, "Koul, Vinod" <vinod.koul@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark and Vinod,

Could you tell me where are the two patches in git repo?

I cannot find them on topic/intel branch.
I want to rebase the Cherrytrail/Braswell machine driver on the two
applied patches.

Thanks
Mengdong

> -----Original Message-----
> From: alsa-devel-bounces@alsa-project.org
> [mailto:alsa-devel-bounces@alsa-project.org] On Behalf Of Mark Brown
> Sent: Wednesday, November 19, 2014 6:57 PM
> To: Koul, Vinod
> Cc: alsa-devel@alsa-project.org; lgirdwood@gmail.com
> Subject: Re: [alsa-devel] [PATCH 1/2] ASoC: Intel: cleanup runtime_pm
> initialization
> 
> On Wed, Nov 19, 2014 at 03:13:26PM +0530, Vinod Koul wrote:
> > For ACPI we missed to pm_runtime_enable() call which is required to
> > tell PM core that runtime on this device is enabled now. Since this is
> > common to both PCI and APCI move it out. Also for ACPI we do not
> > require
> > pm_runtime_allow() call, so remove that
> 
> Applied, thanks.
