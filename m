From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH v3 0/7] topology: Add support for vendor
	tuples
Date: Thu, 7 Apr 2016 14:33:13 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F84B9B4A51@shsmsx102.ccr.corp.intel.com>
References: <cover.1460013338.git.mengdong.lin@linux.intel.com>
 <s5h60vt93jl.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 59FEF2650FA
 for <alsa-devel@alsa-project.org>; Thu,  7 Apr 2016 16:36:45 +0200 (CEST)
In-Reply-To: <s5h60vt93jl.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, "mengdong.lin@linux.intel.com" <mengdong.lin@linux.intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Koul,
 Vinod" <vinod.koul@intel.com>, "Shah, Hardik T" <hardik.t.shah@intel.com>, "broonie@kernel.org" <broonie@kernel.org>, "Ughreja,
 Rakesh A" <rakesh.a.ughreja@intel.com>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>, "Prusty,
 Subhransu S" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Thursday, April 07, 2016 5:22 PM
> To: mengdong.lin@linux.intel.com
> Cc: alsa-devel@alsa-project.org; broonie@kernel.org; perex@perex.cz;
> Girdwood, Liam R; Lin, Mengdong; Koul, Vinod; Prusty, Subhransu S; Ughreja,
> Rakesh A; Shah, Hardik T
> Subject: Re: [PATCH v3 0/7] topology: Add support for vendor tuples
> 
> On Thu, 07 Apr 2016 09:27:20 +0200,
> mengdong.lin@linux.intel.com wrote:
> >
> > From: Mengdong Lin <mengdong.lin@linux.intel.com>
> >
> > This series addes support for vendor tuples to topology, to avoid
> > importing binary data blob from other files.
> >
> > Backward compatibility of ABI is not impacted. A kernel patch is also
> > submitted "ASoC: topology: ABI - Define types for vendor tuples".
> >
> > The 1st patch is small code cleanup.
> > The 2nd patch is a preparation, since tuples will need the
> > type-specific free handler.
> >
> > History:
> > v2: add check on string length, use strtol() to get hex value,
> >     and fix memory leak.
> > v3: Fix overflow on uuid string copy. Use strtoul() to get unsigned
> >     vendor values and check range, tested on 32 & 64 bit systems.
> 
> The patches look good to me.  The prerequisite is the change in the kernel
> side.  Mark, how about that?
> 

I saw the kernel patch "ASoC: topology: ABI - Define types for vendor tuples" has been merged to ASoC kernel.

Here is the link:
http://git.kernel.org/cgit/linux/kernel/git/broonie/sound.git/commit/?h=for-next&id=e42839b012eb8179ed2e3571bfcd133fba5df154

Thanks
Mengdong
