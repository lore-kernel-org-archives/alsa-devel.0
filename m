From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v3 3/3] conf: topology: Generate Private
	data binary blobs
Date: Thu, 21 Apr 2016 16:26:54 +0530
Message-ID: <20160421105654.GP2274@localhost>
References: <1461220058-1378-1-git-send-email-vinod.koul@intel.com>
 <1461220058-1378-4-git-send-email-vinod.koul@intel.com>
 <s5hvb3bxw5u.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id E7901260711
 for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2016 12:52:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hvb3bxw5u.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 21, 2016 at 09:23:25AM +0200, Takashi Iwai wrote:
> On Thu, 21 Apr 2016 08:27:38 +0200,
> Vinod Koul wrote:
> > 
> > From: Shreyas NC <shreyas.nc@intel.com>
> > 
> > The DSP modules need private data and that is provided as binary
> > blob. These blobs are compiled from C structures which specify module
> > configuration.
> > 
> > Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
> > Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> 
> What if this program is executed on big endian system?

So we made the data structure m,emebers as __lexx shouldn't that take care
of this, or we can say, we don't support BE systems.

Am not sure if someone running BE system will be intrested in Intel aDSP :D

-- 
~Vinod
