From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v4 0/3]: conf: topology: Add the conf for
	SKL-rt286
Date: Mon, 2 May 2016 14:07:13 +0530
Message-ID: <20160502083713.GZ2274@localhost>
References: <1461821878-26953-1-git-send-email-vinod.koul@intel.com>
 <s5hy47xstpf.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 422DC26054D
 for <alsa-devel@alsa-project.org>; Mon,  2 May 2016 10:31:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hy47xstpf.wl-tiwai@suse.de>
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

On Thu, Apr 28, 2016 at 04:18:04PM +0200, Takashi Iwai wrote:
> On Thu, 28 Apr 2016 07:37:55 +0200,
> Vinod Koul wrote:
> > 
> > This series adds SKL-i2c conf for simple PCM  topology graph
> > 
> > Changes in v4:
> >  - add back the pre-compiled binary blobs
> >  - remove running the binary on intsall step
> > 
> > Changes in v3:
> > 
> >  - remove bin blobs, now they are generated in install step
> >  - hook the tool compilation to alsa-lib and run it on install
> >  - add u8 in alsa type_compat.h
> > 
> > Shreyas NC (3):
> >   conf: topology: Add Skylake i2s conf
> >   Add u8 in type_compat.h
> >   conf: topology: Generate Private data binary blobs
> 
> Applied now (with a slight fix for git bisection and adding the
> missing .gitignore).

Thanks a bunch :)

-- 
~Vinod
