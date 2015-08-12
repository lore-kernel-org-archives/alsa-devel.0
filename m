From: Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [Intel-gfx] [PATCH v2 1/4] drm/i915: Add audio
	set_ncts callback
Date: Wed, 12 Aug 2015 09:14:08 +0300
Message-ID: <87pp2tt4nj.fsf@intel.com>
References: <1439191931-25705-1-git-send-email-libin.yang@intel.com>
 <87a8tz8iya.fsf@intel.com>
 <96A12704CE18D347B625EE2D4A099D196E1DB9@SHSMSX103.ccr.corp.intel.com>
 <96A12704CE18D347B625EE2D4A099D196E35B2@SHSMSX103.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 9052626062B
 for <alsa-devel@alsa-project.org>; Wed, 12 Aug 2015 08:11:16 +0200 (CEST)
In-Reply-To: <96A12704CE18D347B625EE2D4A099D196E35B2@SHSMSX103.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Yang, Libin" <libin.yang@intel.com>, "'alsa-devel@alsa-project.org'" <alsa-devel@alsa-project.org>, "'tiwai@suse.de'" <tiwai@suse.de>, "'intel-gfx@lists.freedesktop.org'" <intel-gfx@lists.freedesktop.org>, "'daniel.vetter@ffwll.ch'" <daniel.vetter@ffwll.ch>
List-Id: alsa-devel@alsa-project.org

On Wed, 12 Aug 2015, "Yang, Libin" <libin.yang@intel.com> wrote:
> Hi,
>
>> -----Original Message-----
>> From: Yang, Libin
>> Sent: Tuesday, August 11, 2015 10:41 AM
>> To: Jani Nikula; alsa-devel@alsa-project.org; tiwai@suse.de; intel-
>> gfx@lists.freedesktop.org; daniel.vetter@ffwll.ch
>> Subject: RE: [Intel-gfx] [PATCH v2 1/4] drm/i915: Add audio set_ncts
>> callback
>> 
>> Hi Jani,
>> 
>> Thanks for reviewing, please see my comments
>> 
>> > -----Original Message-----
>> > From: Jani Nikula [mailto:jani.nikula@linux.intel.com]
>> > Sent: Monday, August 10, 2015 7:46 PM
>> > To: Yang, Libin; alsa-devel@alsa-project.org; tiwai@suse.de; intel-
>> > gfx@lists.freedesktop.org; daniel.vetter@ffwll.ch
>> > Subject: Re: [Intel-gfx] [PATCH v2 1/4] drm/i915: Add audio set_ncts
>> > callback
>> >
>> > On Mon, 10 Aug 2015, libin.yang@intel.com wrote:
>> > > From: Libin Yang <libin.yang@intel.com>
>> > >
>> > > Add the set_ncts callback.
>> > >
>> > > With the callback, audio driver can trigger
>> > > i915 driver to set the proper N/CTS
>> > > based on different sample rates.
>> > >
>> > > Signed-off-by: Libin Yang <libin.yang@intel.com>
>> > > ---
>> > >  include/drm/i915_component.h | 2 ++
>> > >  1 file changed, 2 insertions(+)
>> > >
>> > > diff --git a/include/drm/i915_component.h
>> > b/include/drm/i915_component.h
>> > > index c9a8b64..7305881 100644
>> > > --- a/include/drm/i915_component.h
>> > > +++ b/include/drm/i915_component.h
>> > > @@ -33,6 +33,8 @@ struct i915_audio_component {
>> > >  		void (*put_power)(struct device *);
>> > >  		void (*codec_wake_override)(struct device *, bool
>> > enable);
>> > >  		int (*get_cdclk_freq)(struct device *);
>> > > +		int (*set_ncts)(struct device *, int port, int dev_entry,
>> > > +					int rate);
>> >
>> > I'd rather call this set_audio_rate or similar, and dropping the
>> > references to N and CTS. The caller does not need to know.
>> 
>> But it seems the set_audio_rate will confuse the user. From the
>> literal meaning, it is setting the rate of audio, such as sample rate,
>> which will make audio driver developers confused.
>> And the function is just setting N/CTS which is defined from
>> HDMI SPEC.
>
> What about the name sync_audio_rate()?

I'm fine with that.

BR,
Jani.

>
>> 
>> BTW: your comment reminds me that get_cdclk_freq() seems
>> to need change the name as cdclk is not in the open spec.
>> 
>> >
>> > I'm also not fond of adding a dev_entry parameter and leaving it
>> > unused. I do not think we know specifically how we're going to
>> identify
>> > MST sinks, and the interface may need to be changed anyway. Let's
>> > force
>> > an update in the caller side as well when there's actually sensible
>> > support in our side.
>> 
>> The device entry is a concept in HDA spec. For driver implementation,
>> I think we can use an int variable or a struct device to represent it.
>> A int variable is an easy way. There is some place in audio driver using
>> int variable to represent the deivce entry. And audio driver will not
>> care how gfx driver supports the DP1.2 MST, I mean audio driver will
>> not know the structures inside gfx driver.
>> 
>> I will remove this parameter in this version if you are thinking the
>> MST interface is indeterminate.
>> 
>> BTW: do you know when gfx will normally support MST?
>> 
>> Best Regards,
>> Libin
>> 
>> >
>> > BR,
>> > Jani.
>> >
>> > >  	} *ops;
>> > >  };
>> > >
>> > > --
>> > > 1.9.1
>> > >
>> > > _______________________________________________
>> > > Intel-gfx mailing list
>> > > Intel-gfx@lists.freedesktop.org
>> > > http://lists.freedesktop.org/mailman/listinfo/intel-gfx
>> >
>> > --
>> > Jani Nikula, Intel Open Source Technology Center

-- 
Jani Nikula, Intel Open Source Technology Center
