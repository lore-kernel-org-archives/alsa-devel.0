From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v3 4/5] ALSA - hda: Add support for parsing
 new HDA capabilities
Date: Thu, 4 Aug 2016 11:21:34 +0530
Message-ID: <20160804055133.GB9681@localhost>
References: <1470240374-20018-1-git-send-email-vinod.koul@intel.com>
 <1470240374-20018-5-git-send-email-vinod.koul@intel.com>
 <s5hinvh96j3.wl-tiwai@suse.de> <20160804020059.GA9681@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D2092656F3
 for <alsa-devel@alsa-project.org>; Thu,  4 Aug 2016 07:44:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20160804020059.GA9681@localhost>
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
Cc: alsa-devel@alsa-project.org, patches.audio@intel.com, Hardik T Shah <hardik.t.shah@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, liam.r.girdwood@linux.intel.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 04, 2016 at 07:30:59AM +0530, Vinod Koul wrote:
> > > +
> > > +#ifdef CONFIG_X86
> > > +	if ((bus->ppcap && boot_cpu_has(X86_FEATURE_ART)))
> > 
> > Superfluous parentheses.
> > Also, don't we need to include asm/cpufeature.h?
> 
> Its somehow included, I will check that part as well

And didnt find how :(

Btw we include asm/pgtable.h which uses boot_cpu_has() macro.
So somehow it is getting included.

Do you want this be explicitly included?

-- 
~Vinod
