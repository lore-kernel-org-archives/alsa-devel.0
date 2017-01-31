From: John Frankish <john.frankish@outlook.com>
Subject: Re: Intel alsa sound request for Laptops
Date: Tue, 31 Jan 2017 06:40:06 +0000
Message-ID: <DBXPR04MB334CB0697FA122A169717A0F34A0@DBXPR04MB334.eurprd04.prod.outlook.com>
References: <DBXPR04MB334548B939F29F8E6E24790F3490@DBXPR04MB334.eurprd04.prod.outlook.com>
 <s5hwpdf9nzt.wl-tiwai@suse.de>
 <DBXPR04MB334D7AB20A0F4C15ADD0CB2F3490@DBXPR04MB334.eurprd04.prod.outlook.com>
 <s5htw8j9bsu.wl-tiwai@suse.de>
 <DBXPR04MB334707A6AE3893371F3297DF3480@DBXPR04MB334.eurprd04.prod.outlook.com>
 <s5hr33m9ugc.wl-tiwai@suse.de>
 <DBXPR04MB334ED59C445FC8FA14DC8EEF3480@DBXPR04MB334.eurprd04.prod.outlook.com>
 <s5hmvea9sbm.wl-tiwai@suse.de>
 <DBXPR04MB3345B50F2D5C5CED7B57554F3480@DBXPR04MB334.eurprd04.prod.outlook.com>
 <s5hefzm9hp4.wl-tiwai@suse.de>
 <DBXPR04MB3340B7837734E0527D14872F3480@DBXPR04MB334.eurprd04.prod.outlook.com>
 <s5ha8aa9dvu.wl-tiwai@suse.de>
 <DBXPR04MB33417B9CE4D0D7E238AA53EF3480@DBXPR04MB334.eurprd04.prod.outlook.com>
 <s5hinow8fjk.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from BLU004-OMC1S3.hotmail.com (blu004-omc1s3.hotmail.com
 [65.55.116.14]) by alsa0.perex.cz (Postfix) with ESMTP id 89604267128
 for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2017 07:40:17 +0100 (CET)
In-Reply-To: <s5hinow8fjk.wl-tiwai@suse.de>
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
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

> > > > > That said, if you boot without i915, drop the index option.
> > > > >
> > > > I booted without i915 and did not set any index options (the 
> > > > default behaviour of tinycorelinux is to boot clean like a live-CD 
> > > > distro)
> > > > 
> > > Ah OK, that's the way the current HD-audio driver behaves.
> > > It takes the card at first, then it leaves when the i915 component binding fails (like nomodeset).
> > > It's good to keep the device assignment consistent.  OTOH, it may leave the card#0 empty as a result.
> > > So this is the expected behavior.
> > > 
> > Great - so the expected behaviour is for it to fail :P
> 
> Yeah, "fail" to your expectation, unfortunately.
> 
>The nomodeset or whatever disabling KMS itself is already the hackish workaround, and it's in a sort of abnormal state.
>
I disagree - in fact I was wrong to state that Xorg was using the modesetting driver, further down Xorg.0.log I see that the modesetting driver is unloaded and the vesa driver is used instead.

The use of the vesa driver is not hackish and especially not when i915 has a serious bug and the Intel driver is not stable.

> > Is there any chance of that being fixed in the future?
> >
> As already mentioned, the "fix" is to use PA.
>
Using pulseaudio is not going to fix the broken analogue sound when the i915 driver is not loaded
