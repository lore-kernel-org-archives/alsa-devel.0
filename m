From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: [PATCH v2 2/2] conf: topology: Generate Private
 data binary blobs
Date: Tue, 5 Apr 2016 15:52:19 +0000
Message-ID: <1459871538.3136.42.camel@intel.com>
References: <1459833605-11223-1-git-send-email-vinod.koul@intel.com>
 <1459833605-11223-3-git-send-email-vinod.koul@intel.com>
 <s5h8u0s9sep.wl-tiwai@suse.de> <1459867127.3136.39.camel@intel.com>
 <s5hh9fgm7vy.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id EB0C02657C6
 for <alsa-devel@alsa-project.org>; Tue,  5 Apr 2016 17:52:25 +0200 (CEST)
In-Reply-To: <s5hh9fgm7vy.wl-tiwai@suse.de>
Content-Language: en-US
Content-ID: <73FFF8C6E18F6A49A46A084AD9B2FD99@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "tiwai@suse.de" <tiwai@suse.de>
Cc: "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, Patches Audio <patches.audio@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, "Nc,
 Shreyas" <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2016-04-05 at 16:45 +0200, Takashi Iwai wrote:
> > There is no special dependency here, so we can just add
> > > src/conf/toplogty/*/data/Makefile.am in the toplevel configure.ac?
> > 
> > Yes that seems better. Also please note if we do that alsa-lib can
> > compile the data before it compiles skl topology so we can get rid
> > of
> > bnary blobs whcih are prebuilt and get them generated on alsa-lib
> > compile.
> 
> Yeah, that's nicer, too.

One thing though we need to run the binary to generate blobs, am
thinking of hooking that up with install step.

> 
> > This will solve above header patch and will use std path in lib
> > 
> > Is that okay with you?
> 
> Sure.
> 
> 
> thanks,
> 
> Takashi

-- 
~Vinod
