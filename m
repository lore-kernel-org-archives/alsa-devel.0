From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH 0/6] topology: Updates for PCM object in
	ABI v5
Date: Thu, 3 Nov 2016 23:09:29 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F88198C0D8@shsmsx102.ccr.corp.intel.com>
References: <cover.1478212626.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 913A4266BC4
 for <alsa-devel@alsa-project.org>; Fri,  4 Nov 2016 00:09:33 +0100 (CET)
In-Reply-To: <cover.1478212626.git.mengdong.lin@linux.intel.com>
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
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I'm so sorry, please overlook the duplicated cover letters. I sent them out by mistake.

Thanks
Mengdong

> -----Original Message-----
> From: mengdong.lin@linux.intel.com [mailto:mengdong.lin@linux.intel.com]
> Sent: Friday, November 4, 2016 7:00 AM
> To: alsa-devel@alsa-project.org
> Cc: tiwai@suse.de; broonie@kernel.org; perex@perex.cz;
> liam.r.girdwood@linux.intel.com; Shah, Hardik T <hardik.t.shah@intel.com>;
> Singh, Guneshwor O <guneshwor.o.singh@intel.com>; Koul, Vinod
> <vinod.koul@intel.com>; Lin, Mengdong <mengdong.lin@intel.com>;
> Mengdong Lin <mengdong.lin@linux.intel.com>
> Subject: [PATCH 0/6] topology: Updates for PCM object in ABI v5
> 
> From: Mengdong Lin <mengdong.lin@linux.intel.com>
> 
> These ABI updates for PCM have just been applied to ASoC kernel. And
> kernel can handle the PCM ABI updates in a backward compatible way.
> 
> So we update the user space code for PCM now.
> 
> The updates for physical DAI link and DAIs will come later after their kernel
> updates be applied at first.
> 
> Mengdong Lin (6):
>   topology: ABI - Update stream caps and PCM objects to ABI v5
>   topology: Parse sig_bits of stream caps
>   topology: Parse flags for PCM
>   topology: Define a function to build a single PCM element
>   topology: Parse and build private data for PCM
>   topology: tplg_elem_lookup() checks parameter before searching
> 
>  include/sound/asoc.h      |   9 ++++
>  include/topology.h        |  11 +++++
>  src/topology/elem.c       |   3 ++
>  src/topology/parser.c     |   2 +-
>  src/topology/pcm.c        | 120
> ++++++++++++++++++++++++++++++++++++++++++++--
>  src/topology/tplg_local.h |   2 +-
>  6 files changed, 140 insertions(+), 7 deletions(-)
> 
> --
> 2.7.4
