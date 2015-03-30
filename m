From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [PATCH] ALSA: hda_intel:
	add	AZX_DCAPS_I915_POWERWELL for skl
Date: Mon, 30 Mar 2015 02:47:45 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D1962E18F@SHSMSX103.ccr.corp.intel.com>
References: <1427440204-49331-1-git-send-email-libin.yang@intel.com>
 <s5hfv8q98lm.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D19622F1C@SHSMSX103.ccr.corp.intel.com>
 <s5hegoa97jj.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D19622F67@SHSMSX103.ccr.corp.intel.com>
 <s5ha8yy971s.wl-tiwai@suse.de>
 <96A12704CE18D347B625EE2D4A099D19622F84@SHSMSX103.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 9EB0B260459
 for <alsa-devel@alsa-project.org>; Mon, 30 Mar 2015 04:47:51 +0200 (CEST)
In-Reply-To: <96A12704CE18D347B625EE2D4A099D19622F84@SHSMSX103.ccr.corp.intel.com>
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
To: 'Takashi Iwai' <tiwai@suse.de>
Cc: "'alsa-devel@alsa-project.org'" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,


> -----Original Message-----
> From: Yang, Libin
> Sent: Friday, March 27, 2015 4:34 PM
> To: Takashi Iwai
> Cc: alsa-devel@alsa-project.org
> Subject: RE: [alsa-devel] [PATCH] ALSA: hda_intel: add
> AZX_DCAPS_I915_POWERWELL for skl
> 
> Hi Takashi,
> 
> 
> 
> > -----Original Message-----
> > From: Takashi Iwai [mailto:tiwai@suse.de]
> > Sent: Friday, March 27, 2015 4:30 PM
> > To: Yang, Libin
> > Cc: alsa-devel@alsa-project.org
> > Subject: Re: [alsa-devel] [PATCH] ALSA: hda_intel: add
> > AZX_DCAPS_I915_POWERWELL for skl
> >
> > At Fri, 27 Mar 2015 08:25:52 +0000,
> > Yang, Libin wrote:
> > >
> > > Hi Takashi,
> > >
> > >
> > > > -----Original Message-----
> > > > From: alsa-devel-bounces@alsa-project.org [mailto:alsa-devel-
> > > > bounces@alsa-project.org] On Behalf Of Takashi Iwai
> > > > Sent: Friday, March 27, 2015 4:19 PM
> > > > To: Yang, Libin
> > > > Cc: alsa-devel@alsa-project.org
> > > > Subject: Re: [alsa-devel] [PATCH] ALSA: hda_intel: add
> > > > AZX_DCAPS_I915_POWERWELL for skl
> > > >
> > > > At Fri, 27 Mar 2015 08:02:54 +0000,
> > > > Yang, Libin wrote:
> > > > >
> > > > > Hi Takashi,
> > > > >
> > > > >
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Takashi Iwai [mailto:tiwai@suse.de]
> > > > > > Sent: Friday, March 27, 2015 3:57 PM
> > > > > > To: Yang, Libin
> > > > > > Cc: alsa-devel@alsa-project.org
> > > > > > Subject: Re: [PATCH] ALSA: hda_intel: add
> > > > > > AZX_DCAPS_I915_POWERWELL for skl
> > > > > >
> > > > > > At Fri, 27 Mar 2015 15:10:04 +0800,
> > > > > > libin.yang@intel.com wrote:
> > > > > > >
> > > > > > > From: Libin Yang <libin.yang@intel.com>
> > > > > > >
> > > > > > > HDMI/DP codec on SKL is in the power well.
> > > > > > > The power well must be turned on before probing the
> > > > > > > HDMI/DP codec.
> > > > > > >
> > > > > > > Signed-off-by: Libin Yang <libin.yang@intel.com>
> > > > > >
> > > > > > So, was the previous question clarified?
> > > > >
> > > > > Yes, I have confirmed with our silicon team.
> > > > >
> > > > > >
> > > > > > This certainly sucks.  It means that the powerwell is on even
> > you
> > > > > > don't use the HDMI/DP at all.  If this is intended as a
> temporarily
> > > > > > workaround, it should be mentioned so.  Please give more
> > > > comments
> > > > > > and
> > > > > > backgrounds.
> > > > >
> > > > > Yes, as this is added in the skl audio controller, even there is no
> > > > HDMI/DP
> > > > > codec, we should also add this flag. Otherwise the HDMI/DP
> > codec
> > > > > may not be detected correctly.
> > > >
> > > > But it's possible to do it only at probing, not permanently.  If so,
> > > > we'll have another patch in future.
> > > >
> > > > Please write more information in the changelog and resubmit.
> > >
> > > Do you mean to add more description in the patch comments?
> >
> > Yes.  The hardware design is different from HSW/BDW, thus applying
> > this isn't straightforward but just a workaround.  I don't know
> > whether you think it's a temporary workaround or a permanent fix.
> > Such information must be written there, too.
> 
> OK. I see. It seems we need more input from our silicon team
> for this issue.

>From our silicon team's comment, it seems we need power on
the powerwell when detecting and probing the HDMI codec.

For the skl case (HDMI codec is in powerwell, while controller not),
my thinking is:

1. power on the power well
2. read STATESTS to determine the codec_mask
3. if codec is not present, power off the power well
    and remove the flag. (seems we need a new flag)
4. if codec is present, we will power on the power well
    when dealing with HDMI codec.

What do you think?

> 
> >
> >
> > Takashi
> 
> Regards,
> Libin

Regards,
Libin
