From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 0/3] conf: Add vendor tuples in conf
Date: Tue, 23 Aug 2016 09:26:50 +0530
Message-ID: <20160823035650.GU2890@localhost>
References: <1470985217-10719-1-git-send-email-vinod.koul@intel.com>
 <s5hfupxf0r5.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id DF845266A6F
 for <alsa-devel@alsa-project.org>; Tue, 23 Aug 2016 05:48:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hfupxf0r5.wl-tiwai@suse.de>
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

On Mon, Aug 22, 2016 at 02:26:22PM +0200, Takashi Iwai wrote:
> On Fri, 12 Aug 2016 09:00:14 +0200,
> Vinod Koul wrote:
> > 
> > Topology changes in alsa-lib allow driver data for modules to be be passed
> > in topology conf file using tuples. These changes allow private data to
> > represented by tuples of type UUID, byte, short, word and strings.
> > 
> > This patch series adds changes to :
> >  - include tuple and token list in the conf file
> >    to define module private data.
> >  - Private data blobs for modules are no longer required. So, remove the
> >    binary blobs and the tool used to generate the blobs.
> >  - Then add bxt conf file which is based on tuples
> > 
> > Takashi,
> > 	This should be merged after the kernel changes are merged.
> > 
> > Shreyas NC (3):
> >   conf: sklrt286: define module private data through tuples in skylake
> >   conf: sklrt286: Remove tool to generate private data blobs
> >   conf: bxtrt298: Add topology conf file for bxt
> 
> Did you submit all patches?  I've seen only this cover letter.
> In anyway, please resubmit.

Ah not sure, how. I will send again now

-- 
~Vinod
