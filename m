From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: Enable display power well management in HD-A
 driver on Baytrail platform (Valleyview SOC)
Date: Fri, 25 Oct 2013 15:08:13 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F8013D7B37@SHSMSX101.ccr.corp.intel.com>
References: <F46914AEC2663F4A9BB62374E5EEF8F8013CBF2B@SHSMSX101.ccr.corp.intel.com>
 <s5h8uxhmx2h.wl%tiwai@suse.de> <s5h4n85mvb6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 03C8926562E
 for <alsa-devel@alsa-project.org>; Fri, 25 Oct 2013 17:08:17 +0200 (CEST)
In-Reply-To: <s5h4n85mvb6.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: "Li, Jocelyn" <jocelyn.li@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Barnes,
 Jesse" <jesse.barnes@intel.com>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>, "David Henningsson (david.henningsson@canonical.com)" <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Friday, October 25, 2013 7:42 PM

> > > We want to enable display power well management on Batrail platform
> (Valleyview SOC), similar to what we did on Haswell.
> > > Would you please check if our ideas are ok and give some advice?
> > >
> > > For Valleyview/VLV the display controller has a power well island. When
> display is off, the display island can be power gated.
> > > Unlike Haswell, the VLV HD-A controller is not in the display power well. The
> controller is in south bridge and shared by multiple codecs, same as the
> predecessors of Haswell.
> >
> > But the power is still controlled based on the usage of HD-audio
> > controller, not per codec, isn't it?  If so, we can keep using the
> > runtime PM implementation.
> 
> Reading again your mail, it sounds like we need the i915 power up/down *just
> for HDMI codec*, not for onboard audio, while both of them are connected
> over the same HD-audio bus (i.e. controller).  If it's the case, an easiest way is
> to put i915_request_power_well*() at set_power_state callback as you pointed.
> 
> I don't like an idea to add pre_resume and post_suspend opts again.

Yes, the i915 power up/down is just for the HDMI codec. The audio controller and on-board codec are not affected.
So we'll try the 1st option and see if it can work as we expected.

Thanks for your advice!
Mengdong
