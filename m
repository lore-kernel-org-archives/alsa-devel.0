Return-Path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id F21152614C4
 for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2015 13:57:47 +0200 (CEST)
Date: Wed, 10 Jun 2015 16:56:28 +0530
From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Message-ID: <20150610112624.GA4355@vinod.koul@linux.intel.com>
References: <1433936016-446-1-git-send-email-vinod.koul@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1433936016-446-1-git-send-email-vinod.koul@intel.com>
Subject: Re: [alsa-devel] [PATCH v7 0/3] HDA: add extended HDA
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, patches.audio@intel.com
List-ID: <alsa-devel@alsa-project.org>

There is an error in this series. Vinod will resend shortly.

On Wed, Jun 10, 2015 at 05:03:33PM +0530, Vinod Koul wrote:
> New HDA controllers from Intel have extended HDA capabilities like multilink,
> pipe processing, SPIB, GTS etc In order to use them we create an extended
> HDA bus, controller and stream which uses the extended configuration
> 
> Changes in v7:
> - Feedback from Takashi
> - removed the macros for register read/writes
> - add new macros for reg update
> - fix bus pointer macro
> - header cleanup on c/h files
> - new device name ehdaudioiDn
> - removed flags for ext caps, use pointer only
> - moved module info to patch 1
> - sparse check on series
> - remove codec name in link
> 
> Jeeja KP (3):
>   ALSA: hdac_ext: add extended HDA bus
>   ALSA: hdac_ext: add hdac extended controller
>   ALSA: hdac_ext: add extended stream capabilities
> 
>  include/sound/hdaudio_ext.h         | 129 ++++++++++++
>  sound/hda/Kconfig                   |   4 +
>  sound/hda/Makefile                  |   3 +
>  sound/hda/ext/Makefile              |   3 +
>  sound/hda/ext/hdac_ext_bus.c        | 116 +++++++++++
>  sound/hda/ext/hdac_ext_controller.c | 297 ++++++++++++++++++++++++++
>  sound/hda/ext/hdac_ext_stream.c     | 402 ++++++++++++++++++++++++++++++++++++
>  7 files changed, 954 insertions(+)
>  create mode 100644 include/sound/hdaudio_ext.h
>  create mode 100644 sound/hda/ext/Makefile
>  create mode 100644 sound/hda/ext/hdac_ext_bus.c
>  create mode 100644 sound/hda/ext/hdac_ext_controller.c
>  create mode 100644 sound/hda/ext/hdac_ext_stream.c
> 
> -- 
> 1.9.1
> 

-- 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
