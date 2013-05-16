From: "Wang, Xingchao" <xingchao.wang@intel.com>
Subject: Re: [PATCH 0/2 V3] Power-well API implementation for
	Haswell
Date: Thu, 16 May 2013 12:06:00 +0000
Message-ID: <46B810F6945F7C4788E11DCE57EC489010E6AFEB@SHSMSX102.ccr.corp.intel.com>
References: <1368690757-2856-1-git-send-email-xingchao.wang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <1368690757-2856-1-git-send-email-xingchao.wang@linux.intel.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: "daniel@ffwll.ch" <daniel@ffwll.ch>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Zanoni,
	Paulo R" <paulo.r.zanoni@intel.com>, "Li,
	Jocelyn" <jocelyn.li@intel.com>, "Lin, Mengdong" <mengdong.lin@intel.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, Wang Xingchao <xingchao.wang@linux.intel.com>, "tiwai@suse.de" <tiwai@suse.de>, "Barnes,
	Jesse" <jesse.barnes@intel.com>, "Girdwood,
	Liam R" <liam.r.girdwood@intel.com>, "david.henningsson@canonical.com" <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Hi Daniel,

Do you have further comments on this patchset?

thanks
--xingchao


> -----Original Message-----
> From: Wang Xingchao [mailto:xingchao.wang@linux.intel.com]
> Sent: Thursday, May 16, 2013 3:53 PM
> To: tiwai@suse.de; daniel@ffwll.ch; Girdwood, Liam R
> Cc: david.henningsson@canonical.com; Lin, Mengdong; Li, Jocelyn;
> alsa-devel@alsa-project.org; intel-gfx@lists.freedesktop.org; Barnes, Jesse;
> Zanoni, Paulo R; Wang, Xingchao; Wang Xingchao
> Subject: [PATCH 0/2 V3] Power-well API implementation for Haswell
> 
> Hi all,
> 
>    This is V3 and some fixes after Takashi's review.
>    change between V2-->V3:
>    - make SND_HDA_I915 selectable
>    - use snd_printdd to output message
>    - add return error code check
>    - use symbol_request to replace symbol_get
>    - release power_well at azx_free
>    - some typo fixes
> 
>    changes between V1-->V2:
>    - use reference count to track power-well usage
>    - remove external module, compiled into snd-hda-intel instead
>    - manage symbols and module loading properly
>    - remove IS_HSW macro, use flag instead
>    - remove audio callback for gfx driver to avoid dependency
>    - split whole patch into two pieces for easy review
>    - more typo fixes
> 
> Wang Xingchao (2):
>   drm/915: Add private api for power well usage
>   ALSA: hda - Add power-welll support for haswell HDA
> 
>  drivers/gpu/drm/i915/intel_pm.c |   76
> +++++++++++++++++++++++++++++++++++----
>  include/drm/i915_powerwell.h    |   36 +++++++++++++++++++
>  sound/pci/hda/Kconfig           |   10 ++++++
>  sound/pci/hda/Makefile          |    3 ++
>  sound/pci/hda/hda_i915.c        |   75
> ++++++++++++++++++++++++++++++++++++++
>  sound/pci/hda/hda_i915.h        |   35 ++++++++++++++++++
>  sound/pci/hda/hda_intel.c       |   41 +++++++++++++++++++--
>  7 files changed, 262 insertions(+), 10 deletions(-)  create mode 100644
> include/drm/i915_powerwell.h  create mode 100644
> sound/pci/hda/hda_i915.c  create mode 100644 sound/pci/hda/hda_i915.h
> 
> --
> 1.7.9.5
