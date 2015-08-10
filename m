From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH 1/3] topology: Add C templates structure
 for building topology from C programs
Date: Mon, 10 Aug 2015 11:23:59 +0100
Message-ID: <1439202239.2416.7.camel@loki>
References: <1438963434-6407-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <1438963434-6407-2-git-send-email-liam.r.girdwood@linux.intel.com>
 <s5htwsbf543.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id EA948260836
 for <alsa-devel@alsa-project.org>; Mon, 10 Aug 2015 12:24:03 +0200 (CEST)
In-Reply-To: <s5htwsbf543.wl-tiwai@suse.de>
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
Cc: Mengdong Lin <mengdong.lin@intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 2015-08-07 at 18:14 +0200, Takashi Iwai wrote:
> On Fri, 07 Aug 2015 18:03:52 +0200,
> Liam Girdwood wrote:
> > 
> > From: Mengdong Lin <mengdong.lin@intel.com>
> > 
> > Define structures that can be used by applications to directly build topology
> > data instead of using text files. The application will build up the topology
> > data by populating the template structures for each object type and then
> > registering the template with the topology core.
> > 
> > Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>
> > Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
> > ---
> >  include/sound/asoc.h      |   2 +
> >  include/topology.h        | 178 ++++++++++++++++++++++++++++++++++++++++++++++
> >  src/topology/builder.c    |  38 +++++-----
> >  src/topology/ctl.c        |  38 +++++-----
> >  src/topology/dapm.c       |  28 ++++----
> >  src/topology/data.c       |  10 +--
> >  src/topology/elem.c       |  26 +++----
> >  src/topology/parser.c     |   6 +-
> >  src/topology/pcm.c        |  34 ++++-----
> >  src/topology/text.c       |   2 +-
> >  src/topology/tplg_local.h |  23 +-----
> >  11 files changed, 273 insertions(+), 112 deletions(-)
> > 
> > diff --git a/include/sound/asoc.h b/include/sound/asoc.h
> > index c642855..1b19739 100644
> > --- a/include/sound/asoc.h
> > +++ b/include/sound/asoc.h
> > @@ -15,6 +15,8 @@
> >  #ifndef __LINUX_UAPI_SND_ASOC_H
> >  #define __LINUX_UAPI_SND_ASOC_H
> >  
> > +#include <sound/type_compat.h>
> > +
> 
> Don't modify this file specific to alsa-lib.  This file should be a
> copy from the kernel uapi header.
> 

Fwiw the reasoning behind this was to allow client application to use
the SND_SOC_TPLG_ macros in aosc.h to identify topology object types.
The problem is that asoc.h also contains lots of endian specific types
in the ABI that need type_compat.h. I guess clients will also need to
include <sound/type_compat.h> from now on.


> >  #ifdef __cplusplus
> > diff --git a/src/topology/builder.c b/src/topology/builder.c
> > index a944866..3bccd44 100644
> > --- a/src/topology/builder.c
> > +++ b/src/topology/builder.c
> > @@ -141,7 +141,7 @@ static int write_elem_block(snd_tplg_t *tplg,
> >  		if (elem->compound_elem)
> >  			continue;
> >  
> > -		if (elem->type != OBJECT_TYPE_DAPM_GRAPH)
> > +		if (elem->type != SND_TPLG_TYPE_DAPM_GRAPH)
> 
> I prefer splitting this systematic replacement in another patch.
> Then it's easier to check by a script, and the size won't matter.
> Otherwise the whole patch became too big and difficult to follow.
> 

Sorry, this was squashed in by mistake, it should have been a separate
patch.

Liam
