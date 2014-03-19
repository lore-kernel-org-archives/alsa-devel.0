From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH] ALSA: hda - verify pin:cvt connection on
 preparing a stream for Intel HDMI codec
Date: Wed, 19 Mar 2014 14:58:33 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F82B32761E@SHSMSX101.ccr.corp.intel.com>
References: <c8336299f64f1fda9e0d0488fbef5e90a67e287b.1395135128.git.mengdong.lin@intel.com>
 <s5h7g7rsu8i.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F82B319E23@SHSMSX151.ccr.corp.intel.com>
 <s5ha9cnpmw8.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F82B31AE02@SHSMSX151.ccr.corp.intel.com>
 <s5hbnx2d6ew.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A4E02650D1
 for <alsa-devel@alsa-project.org>; Wed, 19 Mar 2014 15:58:45 +0100 (CET)
In-Reply-To: <s5hbnx2d6ew.wl%tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Wednesday, March 19, 2014 2:55 PM
> To: Lin, Mengdong
> Cc: alsa-devel@alsa-project.org
> Subject: Re: [PATCH] ALSA: hda - verify pin:cvt connection on preparing a
> stream for Intel HDMI codec
> 
> At Wed, 19 Mar 2014 04:00:41 +0000,
> Lin, Mengdong wrote:
> >
> > Hi Takashi,
> >
> > > -----Original Message-----
> > > From: Takashi Iwai [mailto:tiwai@suse.de]
> > > Sent: Tuesday, March 18, 2014 11:06 PM
> >
> > > > > > The pin:converter connection may get reset after S3 on Intel
> > > > > > Broadwell HDMI codec. And this can cause multiple pins share a
> > > > > > same convertor and mute control will affect each other. We
> > > > > > observed a resumed audio playback become silent after S3.
> > > > > >
> > > > > > This patch verifies pin:cvt connection on preparing a stream,
> > > > > > to assure the pin selects the right convetor and an assigned
> > > > > > convertor is not shared by other unused pins. Apply this
> > > > > > fix-up on Haswell,
> > > > > Broadwell and Baytrail.
> > > > > >
> > > > > > Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>
> > > > >
> > > > > Hm, it's still not clear to me why this happens.  The
> > > > > connections are recorded via snd_hda_codec_write_cache(), and
> > > > > these values should be restored in the resume.  Where the things
> went wrong?
> > > >
> > > > I don't think it's the problem of snd_hda_codec_write_cache().
> > > >
> > > > When the pcm stream is opened, the convertor to pin connection is
> > > > configured by the driver, not interrupted by S3, and then playback
> start.
> > >
> > > Yes.  And at this moment, the connection was already saved in the
> > > cache via snd_hda_codec_write_cache().
> > >
> > > > But after S3, HW forgets this configuration and pin can select the
> > > > default convertor.
> > >
> > > ... but the driver restores the old connection read from the cache.
> > > So, after S3 resume, this connection should have been already
> restored.
> > > Also the connections of other converters should be also covered, as
> > > they are set with snd_hda_codec_write_cache() in
> > > intel_not_share_assigned_cvt().
> > >
> > > > Thus a used pin and an unused pin can share a same convertor and a
> > > muted pin can make the other used pin no sound output.
> > > > As a result, a resumed playback after S3 can have no sound output.
> > >
> > > I'm afraid that there is a big missing piece here.
> > > Check whether the cached values are really restored properly in the
> > > resume.  snd_hda_codec_resume_cache() does it.
> >
> > Thanks for your tips!
> > snd_hda_codec_resume_cache() works well as expected, it does apply
> the convertor selections for all pins with the right cached value.
> >
> > So the big missing piece here is the audio driver restores things earlier
> than gfx side is ready, and such connect selection is overlooked by HW.
> > After Gfx is ready, the pins make the default selection again.
> 
> That explains.  Thanks for finding out.
> 
> > I think the better solution is to let gfx driver tell audio when it's ready by
> the new communication channel as we discussed before.
> > And probably we could delay generic_hdmi_resume until gfx notify it's
> ready.
> >
> > Not only the pin:cvt connection, but pin's power state/muting status
> also depend on gfx status as we observed before.
> > Unsolicited event is not reliable and will be lost when the audio
> controller in D3 and ELD in HW buffer can be broken if the display power
> well has on/off.
> > A SW channel will be more reliable than using unsol event and checking
> ELD by pin_sense.
> 
> Right, this should be the best way to go.  But the question is what we can
> do for now.  I find your patch OK as a temporary workaround.  The only
> problem was to understand why it was really needed.
> 
> > Sorry that the implementation on audio/gfx channel has been pending
> so long due to other internal tasks.
> > But now we'd better do this asap since several features is blocked by
> this.
> 
> Yes, but I'm afraid this won't be in 3.15.  As a temporary fix, could you
> resubmit the patch with a more correct description and a patch
> mentioning that it's a temporary fix?

Okay, I'll do this tomorrow.

Thanks
Mengdong
