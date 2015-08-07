From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: [PATCH 00/13] Add DSP topology management for SKL
Date: Sat, 8 Aug 2015 00:29:05 +0530
Message-ID: <20043.0519333624$1438974004@news.gmane.org>
References: <1438971749-874-1-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id D37682606CA
 for <alsa-devel@alsa-project.org>; Fri,  7 Aug 2015 20:59:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1438971749-874-1-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

I resent some older patches as well with this series. Please ignore. Will
resend the series.

Sorry for the spam.

On Fri, Aug 07, 2015 at 11:52:16PM +0530, Subhransu S. Prusty wrote:
> The SKL driver does not code DSP topology in driver. With this series
> the soc topology framework is used to parse the topology information
> to create widgets, controls and route map for the FW topology.
> 
> It adds routines for SKL DSP module configuration, add building blocks
> to instanatiate modules and pipes. It uses SKL IPC library added earlier
> to send IPC for initialize the module, bind/unbind modules, create
> pipeline and manage them.
> 
> Last patch in this series removes the unused dais.
> 
> Hardik T Shah (1):
>   ASoC: Intel: Skylake: Add helpers for SRC and converter modules
> 
> Jeeja KP (12):
>   ASoC: Intel: Skylake: Add helpers for DSP module configuration
>   ASoC: Intel: Skylake: Add DSP module init and binding routines
>   ASoC: Intel: Skylake: Add pipe management helpers
>   ASoC: Intel: Skylake: Add pipe and modules handlers
>   ASoC: Intel: Skylake: Add module configuration helpers
>   ASoC: Intel: Skylake: add DSP platform widget event handlers
>   ASoC: Intel: Skylake: Add FE and BE hw_params handling
>   ASoC: Intel: Skylake: Add topology core init and handlers
>   ASoC: Intel: Skylake: Initialize and load DSP controls
>   ASoC: Intel: Skylake: Add DSP support and enable it
>   ASoC: Intel: Skylake: Initialize NHLT table
>   ASoC: Intel: Skylake: Remove CPU dai that is not used
> 
>  sound/soc/intel/skylake/Makefile             |    3 +-
>  sound/soc/intel/skylake/skl-messages.c       |  751 +++++++++++++++
>  sound/soc/intel/skylake/skl-pcm.c            |  173 ++--
>  sound/soc/intel/skylake/skl-topology.c       | 1264 ++++++++++++++++++++++++++
>  sound/soc/intel/skylake/skl-topology.h       |  307 +++++++
>  sound/soc/intel/skylake/skl-tplg-interface.h |  166 ++++
>  sound/soc/intel/skylake/skl.c                |   29 +-
>  sound/soc/intel/skylake/skl.h                |   11 +
>  8 files changed, 2636 insertions(+), 68 deletions(-)
>  create mode 100644 sound/soc/intel/skylake/skl-topology.c
>  create mode 100644 sound/soc/intel/skylake/skl-topology.h
>  create mode 100644 sound/soc/intel/skylake/skl-tplg-interface.h
> 
> -- 
> 2.4.3
> 

-- 
