From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH][alsa-lib] topology: fix
	unused-const-variable warning
Date: Tue, 27 Dec 2016 09:57:08 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F881A0D340@shsmsx102.ccr.corp.intel.com>
References: <20161129154432.8299-1-o-takashi@sakamocchi.jp>
 <09494b18-b653-12c5-1213-e6681c6b4d09@sakamocchi.jp>
 <1482482964.24233.51.camel@loki>
 <F46914AEC2663F4A9BB62374E5EEF8F881A09C9B@shsmsx102.ccr.corp.intel.com>
 <fd274637-f92f-b4aa-0f48-13e844ce9721@sakamocchi.jp>
 <1482506626.24233.71.camel@loki>
 <6e6431cf-b498-f79b-f4dc-ab3aa78f6e1f@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 5DF83266569
 for <alsa-devel@alsa-project.org>; Tue, 27 Dec 2016 10:57:14 +0100 (CET)
In-Reply-To: <6e6431cf-b498-f79b-f4dc-ab3aa78f6e1f@sakamocchi.jp>
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
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "mengdong.lin" <mengdong.lin@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Sakamoto [mailto:o-takashi@sakamocchi.jp]
> Sent: Friday, December 23, 2016 11:34 PM
> >>>
> >>> Hi Liam,
> >>>
> >>> This "widget_control_map" is still unused now.
> >>>
> >>> Could you remember why we define this map in the early phase?
> >>> I guess previously we want to distinguish stand-alone controls from
> controls embedded in widgets. But now we process them in the same way,
> both in user space and kernel.
> >>>
> >>> So I feel we can remove this structure.
> >>
> >> Additionally, would you check this post to fix some warnings which
> >> you added into alsa-lib, please.
> >> [alsa-devel] [PATCH][alsa-lib] topology: fix sign-compare warning
> >> introduced to set_link_hw_config() and tplg_add_link_object()
> >> http://mailman.alsa-project.org/pipermail/alsa-devel/2016-December/11
> >> 5896.html
> >>
> >>
> >
> > Both look good to me. Apologies that I missed them.
> >
> > You may want to resend them both with my Ack (maybe wait for until
> > after Christmas though).
> 
> No need. Iwai-san already reviewed them. Next year, I'll request him to apply
> them.
> http://mailman.alsa-project.org/pipermail/alsa-devel/2016-
> December/115725.html
> 
> I request Mengdong-Lin to care of compiler warnings again. Her patches
> frequently bring this kind of mistakes, and I have no motivations to fix them
> anymore.

Sorry for this. I'll be careful on the warnings.

To avoid the same issue for UCM, I submitted patches to add '-Wall' to the AM_CPPFLAGS for topology, so we can always see the warnings and fix them.
If this is acceptable for ucm, I'll also enable all warnings for topology as well.

Thanks
Mengdong
