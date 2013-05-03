From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH] ALSA: hda - delay resume haswell hdmi
 codec in system resume
Date: Fri, 3 May 2013 07:30:17 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F839C5C8@SHSMSX101.ccr.corp.intel.com>
References: <1364321572-2634-1-git-send-email-mengdong.lin@intel.com>
 <5162AB7D.40103@canonical.com>	<s5hzjx9z10c.wl%tiwai@suse.de>
 <5162B60C.6000509@canonical.com>	<s5htxnhyzvu.wl%tiwai@suse.de>
 <5162C671.90405@canonical.com>	<s5hhajhyvww.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F83789F5@SHSMSX101.ccr.corp.intel.com>
 <5163B90C.20107@canonical.com>	<s5hhajg175u.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F837A47F@SHSMSX101.ccr.corp.intel.com>
 <5163DC21.9020702@canonical.com>	<s5hmwt8xdf2.wl%tiwai@suse.de>
 <5164F8CF.6040905@canonical.com>	<s5h7gkb0wfa.wl%tiwai@suse.de>
 <5165006F.5070207@canonical.com>	<s5hzjx6zxld.wl%tiwai@suse.de>
 <5165412C.7050306@canonical.com>
 <F46914AEC2663F4A9BB62374E5EEF8F83826C6@SHSMSX101.ccr.corp.intel.com>
 <516BA618.5050104@canonical.com>
 <F46914AEC2663F4A9BB62374E5EEF8F8382D3B@SHSMSX101.ccr.corp.intel.com>
 <516E3873.5020507@canonical.com> <s5h61zld6s6.wl%tiwai@suse.de>
 <F46914AEC2663F4A9BB62374E5EEF8F839C586@SHSMSX101.ccr.corp.intel.com>
 <5183653D.90003@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A9352616BF
 for <alsa-devel@alsa-project.org>; Fri,  3 May 2013 09:32:16 +0200 (CEST)
In-Reply-To: <5183653D.90003@canonical.com>
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
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, "Li, Jocelyn" <jocelyn.li@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Wang,
 Xingchao" <xingchao.wang@intel.com>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: David Henningsson [mailto:david.henningsson@canonical.com]
> Sent: Friday, May 03, 2013 3:20 PM
> To: Lin, Mengdong
> Cc: Takashi Iwai; alsa-devel@alsa-project.org; Girdwood, Liam R; Wang,
> Xingchao; Li, Jocelyn
> Subject: Re: [alsa-devel] [PATCH] ALSA: hda - delay resume haswell hdmi codec
> in system resume
> 
> On 05/03/2013 08:56 AM, Lin, Mengdong wrote:
> > Hi Takashi and David,
> >
> >> -----Original Message-----
> >> From: Takashi Iwai [mailto:tiwai@suse.de]
> >> Sent: Wednesday, April 17, 2013 2:13 PM
> >> To: David Henningsson
> >> Cc: Lin, Mengdong; alsa-devel@alsa-project.org; Girdwood, Liam R
> >> Subject: Re: [alsa-devel] [PATCH] ALSA: hda - delay resume haswell
> >> hdmi codec in system resume
> >>
> >> At Wed, 17 Apr 2013 07:51:47 +0200,
> >> David Henningsson wrote:
> >>>>> The dependency on the Gfx driver, is it both codec-wide and per
> >>>>> pin? It seems to be at least per pin, which means that whenever we
> >>>>> plug something in, we need to redo our initialization of that pin
> >>>>> after the Gfx driver has finished, is that correct?
> >
> > It was confirmed that this a per pin dependency, not codec-wide.
> >
> > For Haswell, every pin is in D3 with amplifier muted by default.
> > The audio driver must program the pin to D0 and unmute the pin, after
> > the gfx driver connect the GPU pipe and port, and enable the transcoder (The
> transcoder is the component where audio is mixed with video).
> > Otherwise, the pin's default power and mute state will not change, by
> checking the Gfx side audio register, although audio codec does not report
> error.
> >
> > In addition, HDMI/DP cable hot plug will trigger Gfx driver to
> disconnect/connect the pipeline, and port may be connected to a new
> transcoder.
> > If the transcoder has changed, the pin can return to D3 and muted again.
> There are 3 pipelines in GPU, a pipe/port connection only affects one pin, not
> the other pins and convertors.
> > So our previous patch to delay powering up the whole codec once is not
> enough and not suitable.
> 
> This makes me a bit worried actually. If the transcoder to port connection can
> be changed at runtime, how does this affect the default pin config on the audio
> codec pin node?
> 
> E g, if the machine only has one physical HDMI output, it would be a good thing
> to mark only one of the pin nodes as a "jack" and the other two as "not
> connected".
> 
> Now, if the transcoder used for this HDMI output is varying, it can be sometimes
> not matching the audio codec pin node set to "jack", and then we have a
> problem...!
> 
> Or is the gfx engine taking the default pin config of the audio codec into
> account somehow?

I think the pin configuration default should not be affected, as it's for BIOS programming.

The DDI port is bound to a HDMI or DP connector on the board.
And although the transcoder can be changed at runtime, the pin report the eld info does not change.

Anyway, we'll double check this issue. 

Thanks for reminding!
Mengdong
