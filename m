From: "Jie, Yang" <yang.jie@intel.com>
Subject: Re: [PATCH 0/5] Intel SST driver restructure
Date: Fri, 13 Mar 2015 14:13:17 +0000
Message-ID: <E7B1D079BA13FB44A978CC8F69C7D6A901BD7F2C@SHSMSX101.ccr.corp.intel.com>
References: <1426170720-8260-1-git-send-email-yang.jie@intel.com>
 <20150313062829.GA32000@intel.com> <55029D8B.9060309@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C5A1264FE3
 for <alsa-devel@alsa-project.org>; Fri, 13 Mar 2015 15:13:26 +0100 (CET)
In-Reply-To: <55029D8B.9060309@intel.com>
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
To: "Nikula, Jarkko" <jarkko.nikula@intel.com>, "Koul, Vinod" <vinod.koul@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Lin,
 Mengdong" <mengdong.lin@intel.com>, "broonie@kernel.org" <broonie@kernel.org>, "Girdwood, Liam R" <liam.r.girdwood@intel.com>, "Jin, Yao" <yao.jin@intel.com>, "Bossart, Pierre-louis" <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Nikula, Jarkko
> Sent: Friday, March 13, 2015 4:19 PM
> To: Koul, Vinod; Jie, Yang
> Cc: broonie@kernel.org; alsa-devel@alsa-project.org; Girdwood, Liam R;
> Bossart, Pierre-louis; Lin, Mengdong; Jin, Yao
> Subject: Re: [PATCH 0/5] Intel SST driver restructure
> 
> On 03/13/2015 08:28 AM, Vinod Koul wrote:
> > On Thu, Mar 12, 2015 at 10:31:55PM +0800, Jie Yang wrote:
> >> In order to prepare for the upstreaming of Skylake drivers and to
> >> allow reuse of code between different Intel audio DSP products, this
> >> patch series restructures the Intel directory as follows:
> >>
> >> 1. Create "common" directory. Move common files into this directory.
> >>
> >> 2. Create "boards" directory. Move all machine drivers into this directory.
> >>
> >> 3. Create "haswell" directory. Move all remaining hsw/bdw code into this
> directory.
> >>
> >> 4. Create "baytrail" directory. Move remaining baytrail driver to this
> directory.
> >>
> >> 5. Create "atom" directory. Move all MCG platform drivers(including
> >> sst/ folder) to this directory.
> >>
> >> Todo next step:
> >> 1. Change and move atom related codes(in atom/sst/) to corresponding
> >> and try share as many as possible codes(e.g. sst_acpi.c).
> >> 2. Share more common codes about IPC for different platforms, e.g.
> >> The methods for queueing and sending/reciving Tx/Rx messages, The
> >> methods for mailbox IO, The IPC error return codes, etc.
> >>
> >> Jie Yang (5):
> >>    ASoC: Intel: create common folder and move common files in
> >>    ASoC: Intel: create haswell folder and move haswell platform files in
> >>    ASoC: Intel: create boards folder and move sst boards files in
> >>    ASoC: Intel: create baytrail folder and move baytrail platform files
> >>      in
> >>    ASoC: Intel: create atom folder and move atom platform files in
> >>
> > For atom parts
> >
> > Acked-by: Vinod Koul <vinod.koul@intel.com>
> >
> I tested the set on byt-rt5640. To all patches (or 1, 3 and 4):
> 
> Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
[Keyon] thank you all. Hi Mark, so should I keep them locally and send to you
2 or 3 weeks later, or you will keep them in queue and apply them one day?
