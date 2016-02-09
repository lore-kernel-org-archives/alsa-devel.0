From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: [PATCH] conf: topology: Add topolgy for skylake
	i2s configuration
Date: Tue, 9 Feb 2016 18:44:19 +0530
Message-ID: <20160209131415.GA26322@subhransu-desktop>
References: <1454903756-2075-1-git-send-email-subhransu.s.prusty@intel.com>
 <s5ha8naxhge.wl-tiwai@suse.de>
 <20160209114749.GA7243@subhransu-desktop>
 <s5h1t8mxfnk.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id C69532619BF
 for <alsa-devel@alsa-project.org>; Tue,  9 Feb 2016 14:13:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h1t8mxfnk.wl-tiwai@suse.de>
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
Cc: patches.audio@intel.com, Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 09, 2016 at 12:54:39PM +0100, Takashi Iwai wrote:
> On Tue, 09 Feb 2016 12:47:53 +0100,
> Subhransu S. Prusty wrote:
> > 
> > On Tue, Feb 09, 2016 at 12:15:45PM +0100, Takashi Iwai wrote:
> > > On Mon, 08 Feb 2016 04:55:56 +0100,
> > > Subhransu S. Prusty wrote:
> > > > 
> > > > This patch adds basic playback/capture support for skylake i2s
> > > > platform. DSP topology module data are passed through the binary
> > > > files. The framework parses these files and puts the data in the
> > > > widget private section for the corresponding widget. This is
> > > > parsed by kernel driver and stored as module config for the DSP.
> > > > Based on usecase these data are sent to the DSP through IPCs for
> > > > further processing.
> > > 
> > > Can we have sources for these binaries, or do they have to be
> > > binary-only?
> > 
> > Hi Takashi,
> > 
> > These are binary only data.
> 
> Then this isn't a good material for merging to alsa-lib.  How is the
> license compatibility?

Each binary file here holds config for each module based on skl_dfw_module
structure as expected by Skylake driver. The skl driver formats IPCs parsing
this config.

This structure skl_dfw_module is already defined as part of
skl-tplg-interface.h.

Regards,
Subhransu
> 
> 
> Takashi

-- 
