From: Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH v6 4/4] drm/i915: set proper N/CTS in
	modeset
Date: Mon, 19 Oct 2015 11:25:22 +0300
Message-ID: <8737x71czx.fsf@intel.com>
References: <1441174301-144177-1-git-send-email-libin.yang@intel.com>
 <1441174301-144177-4-git-send-email-libin.yang@intel.com>
 <8737yx44hh.fsf@intel.com>
 <96A12704CE18D347B625EE2D4A099D196F88C1@SHSMSX103.ccr.corp.intel.com>
 <87twrd2nyl.fsf@intel.com> <s5h7fo9osh0.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 52F0126572A
 for <alsa-devel@alsa-project.org>; Mon, 19 Oct 2015 10:21:56 +0200 (CEST)
In-Reply-To: <s5h7fo9osh0.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "Yang, Libin" <libin.yang@intel.com>, "daniel.vetter@ffwll.ch" <daniel.vetter@ffwll.ch>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "ville.syrjala@linux.intel.com" <ville.syrjala@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 02 Sep 2015, Takashi Iwai <tiwai@suse.de> wrote:
> On Wed, 02 Sep 2015 11:02:42 +0200,
> Jani Nikula wrote:
>> 
>> >> Nitpick. I'd prefer some sharing with the similar blocks from the
>> >> earlier patch. Also a debug message on n == 0 would be nice; you
>> >> probably didn't notice your audio_config_get_rate() wasn't working
>> >> right
>> >> because this silently fell back to the automatic mode here.
>> >
>> > OK, I will add the msg. As you and Ville are insisting on
>> > sharing code, I will do it in next version.
>> 
>> Well, really, I'm fine with having that part duplicated as-is for now,
>> we can fix it later. More important to focus on getting
>> audio_config_get_rate() right.
>> 
>> I don't know if you're still targeting v4.3 with this (up to Takashi I
>> guess) we'll really need to wrap this up soon.
>
> I'm in favor of merging this into 4.3, so it'd be appreciated if Libin
> can prepare the fixed version soonish, indeed.

Takashi, just to double check, none of this made it into v4.3 after all?

BR,
Jani.



>
>
> thanks,
>
> Takashi

-- 
Jani Nikula, Intel Open Source Technology Center
