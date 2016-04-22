From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v3 0/3] conf: topology: Add the conf for
	SKL-rt286
Date: Fri, 22 Apr 2016 08:44:16 +0530
Message-ID: <20160422031416.GR2274@localhost>
References: <1461220058-1378-1-git-send-email-vinod.koul@intel.com>
 <s5hy487xwbn.wl-tiwai@suse.de> <20160421105304.GN2274@localhost>
 <s5htwivdy2e.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 03C912669BE
 for <alsa-devel@alsa-project.org>; Fri, 22 Apr 2016 05:09:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5htwivdy2e.wl-tiwai@suse.de>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 21, 2016 at 01:02:33PM +0200, Takashi Iwai wrote:
> On Thu, 21 Apr 2016 12:53:04 +0200,
> Vinod Koul wrote:
> > 
> > On Thu, Apr 21, 2016 at 09:19:56AM +0200, Takashi Iwai wrote:
> > > On Thu, 21 Apr 2016 08:27:35 +0200,
> > > Vinod Koul wrote:
> > > > 
> > > > This series adds SKL-i2c conf for simple PCM  topology graph
> > > > 
> > > > Changes in v3:
> > > > 
> > > >  - remove bin blobs, now they are generated in install step
> > > 
> > > This isn't good in general.  Usually all installed files are generated
> > > in the normal make step, and make-install only copies them.  There are
> > > a few reasons:
> > > - Invoking a random program as root is a security risk.
> > > - This may create a file by root in the working directory, and either
> > >   it's not always possible (e.g. on NFS) or it may be left undeletable
> > >   after make install.
> > 
> > Right, that is good point indeed.
> > 
> > So what is your suggestion then?
> 
> Just put the normal make rule and generate it at the normal make
> step (only when needed).

Okay, thanks will send updated patchset

-- 
~Vinod
