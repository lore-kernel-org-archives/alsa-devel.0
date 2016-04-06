From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: Re: [PATCH v2 2/2] conf: topology: Generate Private
 data binary blobs
Date: Wed, 6 Apr 2016 13:03:25 +0000
Message-ID: <1459947792.3136.68.camel@intel.com>
References: <1459833605-11223-1-git-send-email-vinod.koul@intel.com>
 <1459833605-11223-3-git-send-email-vinod.koul@intel.com>
 <s5h8u0s9sep.wl-tiwai@suse.de> <1459867127.3136.39.camel@intel.com>
 <s5hh9fgm7vy.wl-tiwai@suse.de> <1459871538.3136.42.camel@intel.com>
 <s5h60vwm46f.wl-tiwai@suse.de> <1459872533.3136.49.camel@intel.com>
 <s5hinzvyfxz.wl-tiwai@suse.de> <20160405212416.GL1924@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id BB0D5265450
 for <alsa-devel@alsa-project.org>; Wed,  6 Apr 2016 15:04:53 +0200 (CEST)
In-Reply-To: <20160405212416.GL1924@sirena.org.uk>
Content-Language: en-US
Content-ID: <1A64B2DE814741459E31155D81AD53C0@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "broonie@kernel.org" <broonie@kernel.org>, "tiwai@suse.de" <tiwai@suse.de>
Cc: "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, Patches Audio <patches.audio@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Nc,
 Shreyas" <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2016-04-05 at 14:24 -0700, Mark Brown wrote:
> On Tue, Apr 05, 2016 at 10:10:48PM +0200, Takashi Iwai wrote:
> 
> > OK.  But now I noticed another pitfall.
> > The topology firmware is endian-sensitive, and the code to generate
> > is
> > so, too.  Thus it can't work for big-endian architectures.

This code is not intended to work on big-endian ones :). We will add
__lexx notations on these.

> The firmware side of this needs to be fixed at the ABI level I think,
> that's definitely an oversight - thanks for spotting it!  We have
> platforms which can switch at boot time between big and little endian 
> so an unfixed endinanness is not going to be usable there.

The topology ABI has been defined as little-endian. The driver needs to
do conversion to machine type and use data from topology.

-- 
~Vinod
