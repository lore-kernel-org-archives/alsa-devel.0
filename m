From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH RFC 0/4] HDA/i915 jack handling using
	component
Date: Thu, 12 Nov 2015 17:44:04 +0100
Message-ID: <5644C1D4.6060101@canonical.com>
References: <1447345214-7212-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C0F12606B7
 for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2015 17:44:05 +0100 (CET)
In-Reply-To: <1447345214-7212-1-git-send-email-tiwai@suse.de>
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
Cc: Libin Yang <libin.yang@linux.intel.com>, mengdong.lin@linux.intel.com
List-Id: alsa-devel@alsa-project.org



On 2015-11-12 17:20, Takashi Iwai wrote:
> Hi,
>
> after the previous discussion ([RFC PATCH 0/2] ALSA: hda - DP MST
> audio for Jack support), I thought it'd be even easier to give a
> concrete code for further discussion; so here we go, it's a patchset
> to implement the jack via audio component.
>
> In the end, I added a new audio component ops to fetch the current
> ELD, since the state is unknown at the time the audio driver starts.
> The other two patches are just a cleanup.
>
> This series is submitted just as an RFC, basically for a better
> understanding, not seriously considered to be merged as is.
> (That's why no intel-gfx is Cc'ed yet.)
>
> Note that the i915 patches are applied to the latest Linus tree, while
> patch_hdmi.c patch is to my for-linus branch.  The patches are found
> in test/hdmi-jack branch of sound git tree.

Right; maybe you got tired of waiting for me to make that patch set, 
sorry. :-/

I looked at it a while ago, but got a bit stuck in figuring out how to 
properly lock things to ensure that the ELD info is not being written to 
(by another kernel thread) at the same time as we read it.

I'm not sure whether your patch resolves that or not. But if av_mutex is 
always held whenever your audio_enabled flag is changed (and ELD is 
never changed while audio_enabled=true), that might do it though.

We might also need to send audio_enabled itself over too, not sure if we 
can have audio enabled without valid ELD - in some cases when we have 
monitors not giving us any ELD info.

>
>
> Takashi
>
> ===
>
> Takashi Iwai (4):
>    drm/i915: Add get_eld audio component
>    drm/i915: Remove superfluous NULL check
>    drm/i915: refactoring audio component functions
>    ALSA: hda - Use component ops for i915 HDMI/DP audio jack handling
>
>   drivers/gpu/drm/i915/intel_audio.c | 73 ++++++++++++++++++++++++---------
>   drivers/gpu/drm/i915/intel_drv.h   |  1 +
>   include/drm/i915_component.h       |  4 ++
>   sound/pci/hda/patch_hdmi.c         | 83 +++++++++++++++++++++++++++++++++++++-
>   4 files changed, 141 insertions(+), 20 deletions(-)
>

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
