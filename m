From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH 0/4] ASoC: Intel: Skylake: Add token
 support for topology data
Date: Wed, 17 Aug 2016 15:03:45 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F84BA9D71C@shsmsx102.ccr.corp.intel.com>
References: <1470985193-10680-1-git-send-email-vinod.koul@intel.com>
 <20160812104107.GB9347@sirena.org.uk> <20160812105531.GL9681@localhost>
 <57B40B50.8000105@linux.intel.com> <20160817100154.GH9347@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 5FDCA267163
 for <alsa-devel@alsa-project.org>; Wed, 17 Aug 2016 17:04:10 +0200 (CEST)
In-Reply-To: <20160817100154.GH9347@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>, Mengdong Lin <mengdong.lin@linux.intel.com>
Cc: "Koul, Vinod" <vinod.koul@intel.com>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Patches Audio <patches.audio@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Wednesday, August 17, 2016 6:02 PM
> To: Mengdong Lin
> Cc: Koul, Vinod; liam.r.girdwood@linux.intel.com; Lin, Mengdong; Patches
> Audio; alsa-devel@alsa-project.org
> Subject: Re: [alsa-devel] [PATCH 0/4] ASoC: Intel: Skylake: Add token support
> for topology data
> 
> On Wed, Aug 17, 2016 at 02:59:28PM +0800, Mengdong Lin wrote:
> 
> > There will be 2 more series to bring some topology ABI update. The
> > code is ready and verified. And we will not modify ABI to break
> > backward compatibility after this.
> 
> It's been over a year since this code was submitted as an ABI.  What are
> these additional changes?  From where I'm sitting it is really difficult to see
> that there's an end in sight here and we've had systems out that need this
> for quite some time now.

One kernel series is for PCM (FE) and the other is for BE link. I'll submit them for review this week.

Thanks
Mengdong
