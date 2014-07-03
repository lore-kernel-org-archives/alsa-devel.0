From: Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH v2 1/2] drm/i915: provide interface for
	audio	driver to query cdclk
Date: Thu, 03 Jul 2014 13:20:19 +0300
Message-ID: <874myyeobg.fsf@intel.com>
References: <1404363651-4388-1-git-send-email-mengdong.lin@intel.com>
 <87mwcqew2x.fsf@intel.com>
 <F46914AEC2663F4A9BB62374E5EEF8F82B590623@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces@lists.freedesktop.org>
In-Reply-To: <F46914AEC2663F4A9BB62374E5EEF8F82B590623@SHSMSX101.ccr.corp.intel.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
 <mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: intel-gfx-bounces@lists.freedesktop.org
Sender: "Intel-gfx" <intel-gfx-bounces@lists.freedesktop.org>
To: "Lin, Mengdong" <mengdong.lin@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 03 Jul 2014, "Lin, Mengdong" <mengdong.lin@intel.com> wrote:
> Hi Jani,
>
>> -----Original Message-----
>> From: Nikula, Jani
>> Sent: Thursday, July 03, 2014 3:33 PM
>  
>> I wrote this as a quick hack patch to try as an alternative to [1] which
>> ended up not working on Haswell. Please reassure me that this is going to
>> be a temporary solution until we get a more generic interface between the
>> audio and display drivers. I don't much like this, but at least it's isolated
>> and small.
>
> Sure. We'll clean up code when the generic interface is ready. 
> This is only a temporary solution, safer than the BIOS notifications.

Thanks.

> And would you like to further revise this patch? 
> But please keep this API not changed at the moment since the audio
> driver already queries the symbol name.

Please just take over the patch, and amend the commit message along the
lines of what I proposed. I think it's easiest if it gets merged through
the alsa tree - you have a dependency on it and your changes are much
bigger. The i915 changes are isolated and not expected to conflict.

But as I said, I'd like a Reviewed-by from another i915 developer
first. I don't like to push/ack my own patches without review from
others, no matter how small the patches.

Thanks,
Jani.



>
> Thanks
> Mengdong
>
>> I'd like the commit message amended with something like:
>> 
>> """
>> If the display power well has been disabled, the display audio controller
>> divider values EM4 MVALUE and EM5 NVALUE will have been lost. The
>> CDCLK frequency is required for reprogramming them. Provide a private
>> interface for the audio driver to query CDCLK.
>> 
>> This is a stopgap solution until a more generic interface between audio
>> and display drivers has been implemented.
>> """
>> 
>> I'd also like to have an additional Reviewed-by from the i915 side. After
>> that, I'm fine with merging this through alsa.

-- 
Jani Nikula, Intel Open Source Technology Center
