From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH v3 0/3] topology: Support widgets' stream
 name and file inclusion for text conf file
Date: Tue, 25 Oct 2016 14:40:33 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F881985A1A@shsmsx102.ccr.corp.intel.com>
References: <cover.1477308877.git.mengdong.lin@linux.intel.com>
 <580DF41F.1070207@linux.intel.com> <s5ha8dsoqgk.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id CD11D26640F
 for <alsa-devel@alsa-project.org>; Tue, 25 Oct 2016 16:40:37 +0200 (CEST)
In-Reply-To: <s5ha8dsoqgk.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, Mengdong Lin <mengdong.lin@linux.intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Koul,
 Vinod" <vinod.koul@intel.com>, "Shah,
 Hardik T" <hardik.t.shah@intel.com>, "Singh,
 Guneshwor O" <guneshwor.o.singh@intel.com>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "broonie@kernel.org" <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Tuesday, October 25, 2016 3:09 PM
> To: Mengdong Lin <mengdong.lin@linux.intel.com>
> Cc: alsa-devel@alsa-project.org; broonie@kernel.org; perex@perex.cz;
> liam.r.girdwood@linux.intel.com; Shah, Hardik T <hardik.t.shah@intel.com>;
> Singh, Guneshwor O <guneshwor.o.singh@intel.com>; Koul, Vinod
> <vinod.koul@intel.com>; Lin, Mengdong <mengdong.lin@intel.com>
> Subject: Re: [PATCH v3 0/3] topology: Support widgets' stream name and file
> inclusion for text conf file
> 
> On Mon, 24 Oct 2016 13:44:31 +0200,
> Mengdong Lin wrote:
> >
> > Sorry, please overlook this version. I forgot to modify the doxygen
> > comment for static functions.
> 
> The doxygen comments still remain in v4.
> But I can fix them manually, so no need for resend.

Sorry, I should not use /**.  
Thanks for your help on this.

Mengdong

> 
> 
> Takashi
> 
> >
> > Thanks
> > Mengdong
> >
> > On 10/24/2016 07:37 PM, mengdong.lin@linux.intel.com wrote:
> > > From: Mengdong Lin <mengdong.lin@linux.intel.com>
> > >
> > > This series doesn't require or cause any ABI updates. It doesn't
> > > need the kernel patches that trying to udpate ABI from v4 or v5.
> > >
> > > Patch 1 fixes a missing topology feature for text conf file to configure
> > >          stream name of a widget.
> > >
> > > Patch 2 allows alsaconf to search included files under global
> > >          configuration directories. This will benefit topology and UCM.
> > >
> > > Patch 3 adds document about how to include files for topology
> > >          configuration. There is no c code change but actually it depends
> > >          on patch 2.
> > >
> > > History:
> > > v2:     No longer use topology-specific code to support searching included
> > >          files, but extend alsaconf to support this and user can just use
> > >          alsaconf syntax <xxx> and <confdir:xxx>.
> > >
> > > v3:     Not use <confdir:xxx> but define new syntax <searchdir:xxx> to
> > >          define directories for searching included file.
> > >
> > > Mengdong Lin (3):
> > >    topology: Fix missing stream name of widgets in text conf file
> > >    alsaconf: Search included files under user specified configuration
> > >      directories
> > >    topology: Add doc for including other files in the text conf file
> > >
> > >   include/topology.h  |  31 ++++++++++
> > >   src/conf.c          | 170
> +++++++++++++++++++++++++++++++++++++++++++++++++++-
> > >   src/topology/dapm.c |  10 ++++
> > >   3 files changed, 210 insertions(+), 1 deletion(-)
> > >
> >
