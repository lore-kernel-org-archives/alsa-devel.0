From: Paulo Zanoni <przanoni@gmail.com>
Subject: Re: [PATCH 0/4 V7] Power-well API implementation for
	Haswell
Date: Thu, 4 Jul 2013 10:24:15 -0300
Message-ID: <CA+gsUGR+xOEa5b7XnTWWwRYyyVxO6hNAVv6EJXAvtKUfuabb1w@mail.gmail.com>
References: <1369922831-727-1-git-send-email-xingchao.wang@linux.intel.com>
	<20130606153441.GI7827@phenom.ffwll.local>
	<CA+gsUGSBf5hit=fmjcrcy=fKJPNaFe02VkkM_=pYkVUwVyvG2Q@mail.gmail.com>
	<20130704082314.GA2393@wxc-intel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <20130704082314.GA2393@wxc-intel>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: Wang xingchao <xingchao.wang@linux.intel.com>
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com, tiwai@suse.de, daniel.vetter@ffwll.ch, intel-gfx@lists.freedesktop.org, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

2013/7/4 Wang xingchao <xingchao.wang@linux.intel.com>:
> On Wed, Jul 03, 2013 at 05:00:51PM -0300, Paulo Zanoni wrote:
>> 2013/6/6 Daniel Vetter <daniel@ffwll.ch>:
>> > On Thu, May 30, 2013 at 10:07:07PM +0800, Wang Xingchao wrote:
>> >> Hi all,
>> >>
>> >>    This is V7 and here're some changes notes:
>> >>    change from V6-->V7:
>> >>    - rename variable
>> >>    - use HAS_POWER_WELL instead of IS_HASWELL
>> >>    - put structure inside drm_i915_private
>> >>    - use WARN_ON for global pointer check
>> >>
>> >>    change from V5-->V6:
>> >>    - Remove duplication code in new introduced probe work
>> >>    - move duplication code in azx_probe_continue
>> >>    - remove unused #ifdef
>> >>    - replace request_module with symbol_request
>> >>    - replace spin_lock_irq with spin_lock_irqsave in gfx side
>> >>    - other typo fixes
>> >>    (review by Takashi)
>> >>
>> >>    change from V4-->V5:
>> >>    - fix reference count bug
>> >>    - new patch on general runtime pm support for audio pci device
>> >>    - new patch to avoid request_module() deadlock
>> >>
>> >>    change between V3-->V4:
>> >>    - add new structure i915_power_well
>> >>    - initialize drm_device pointer at module init time
>> >>    - change function name
>> >>
>> >>    change between V2-->V3:
>> >>    - make SND_HDA_I915 selectable
>> >>    - use snd_printdd to output message
>> >>    - add return error code check
>> >>    - use symbol_request to replace symbol_get
>> >>    - release power_well at azx_free
>> >>    - some typo fixes
>> >>
>> >>    changes between V1-->V2:
>> >>    - use reference count to track power-well usage
>> >>    - remove external module, compiled into snd-hda-intel instead
>> >>    - manage symbols and module loading properly
>> >>    - remove IS_HSW macro, use flag instead
>> >>    - remove audio callback for gfx driver to avoid dependency
>> >>    - split whole patch into two pieces for easy review
>> >>    - more typo fixes
>> >>
>> >>
>> >> Takashi Iwai (1):
>> >>   ALSA: hda - Move azx_first_init() into azx_probe_continue()
>> >>
>> >> Wang Xingchao (3):
>> >>   ALSA: hda - Fix runtime PM check
>> >>   ALSA: hda - Add power-welll support for haswell HDA
>> >>   i915/drm: Add private api for power well usage
>> >
>> > After discussion with Dave and Takashi I've merged the entire series to
>> > drm-intel-next. I'll show up in the next linux-next and I'll forward it to
>> > Dave for mergin into drm-next in roughly 2 weeks.
>>
>> So today I unblacklisted the audio modules on one of my Haswell
>> machines and booted it with i915.disable_power_well=1. I only have an
>> eDP output (it doesn't have audio) and I see the power well is
>> enabled. This is wrong, the power well should be disabled since we
>
> right, if no application using audio it should be in runtime suspend mode.
> And maybe your system didnot enable runtime suspend by default, would you
> tell me the output below?
> cat /sys/devices/pci0000:00/0000:00:03.0/power/control

It says "on".


>
> thanks
> --xingchao
>> only have an eDP panel, and we don't support audio on eDP. I checked
>> on dmesg and the audio driver requests the power well but never
>> releases it.
>>
>> So I decided to do the same test on another Haswell machine, and on
>> that specific machine the audio driver gets the power well and then
>> releases it at azx_runtime_suspend. This machine is also eDP-only
>>
>> I was expecting that on both cases the audio driver would release the
>> power well as soon as it sees there's no connected output capable of
>> HD audio.
>>
>> How can I help debugging this?
>>
>> Thanks,
>> Paulo
>>
>> >
>> > Thanks, Daniel
>> >
>> >>
>> >>  drivers/gpu/drm/i915/i915_dma.c  |    6 +++
>> >>  drivers/gpu/drm/i915/i915_drv.h  |   12 ++++++
>> >>  drivers/gpu/drm/i915/intel_drv.h |    4 ++
>> >>  drivers/gpu/drm/i915/intel_pm.c  |   81 ++++++++++++++++++++++++++++++++---
>> >>  include/drm/i915_powerwell.h     |   36 ++++++++++++++++
>> >>  sound/pci/hda/Kconfig            |   10 +++++
>> >>  sound/pci/hda/Makefile           |    2 +
>> >>  sound/pci/hda/hda_i915.c         |   75 ++++++++++++++++++++++++++++++++
>> >>  sound/pci/hda/hda_i915.h         |   35 +++++++++++++++
>> >>  sound/pci/hda/hda_intel.c        |   87 ++++++++++++++++++++++++++++++--------
>> >>  10 files changed, 324 insertions(+), 24 deletions(-)
>> >>  create mode 100644 include/drm/i915_powerwell.h
>> >>  create mode 100644 sound/pci/hda/hda_i915.c
>> >>  create mode 100644 sound/pci/hda/hda_i915.h
>> >>
>> >> --
>> >> 1.7.9.5
>> >>
>> >
>> > --
>> > Daniel Vetter
>> > Software Engineer, Intel Corporation
>> > +41 (0) 79 365 57 48 - http://blog.ffwll.ch
>> > _______________________________________________
>> > Intel-gfx mailing list
>> > Intel-gfx@lists.freedesktop.org
>> > http://lists.freedesktop.org/mailman/listinfo/intel-gfx
>>
>>
>>
>> --
>> Paulo Zanoni



-- 
Paulo Zanoni
