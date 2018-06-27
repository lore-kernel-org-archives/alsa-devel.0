From: Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCH 0/3] ALSA: PM-related fixes/cleanups
Date: Wed, 27 Jun 2018 14:57:15 +0100
Message-ID: <153010783573.8693.14699907396659337523@mail.alporthouse.com>
References: <20180627091034.22724-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fireflyinternet.com (mail.fireflyinternet.com [109.228.58.192])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C05D2676FD
 for <alsa-devel@alsa-project.org>; Wed, 27 Jun 2018 15:58:08 +0200 (CEST)
In-Reply-To: <20180627091034.22724-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc: =?utf-8?b?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Quoting Takashi Iwai (2018-06-27 10:10:31)
> Hi,
> 
> this is a patch set addressing some minor issues found in PM-related
> stuff, as well as the Intel HDMI fallback issue.  The first patch
> covers the unusual error paths from runtime PM, the second one is a
> code refactoring and the last one fixes the superfluous (rather
> harmful) binding with the generic HDMI driver as fallback of i915
> component binding.

Hmm, our CI casts a shade of doubt over these.

https://intel-gfx-ci.01.org/tree/drm-tip/combined-issues-by-run.html

>From CI_DRM_4385 onwards, a small explosion

79527147382a drm-tip: 2018y-06m-27d-13h-05m-01s UTC integration manifest
67ca07e7ac10 drm/i915/icl: Add power well support
828e10e61e0a drm-tip: 2018y-06m-27d-12h-10m-06s UTC integration manifest
43c489277bdd ALSA: hda/hdmi - Don't fall back to generic when i915
binding fails
bd0afa8b3573 ALSA: hda - Move in_pm accessors to HDA core
644a790aed11 ALSA: hda - Handle error from snd_hda_power_up*()
401caff70cd3 ALSA: hda - Kill snd_hda_codec_update_cache()

I haven't ruled out the icl patch, but I presume that was run past CI
for pre-merge checking.

Just a heads up,
-Chris
