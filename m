From: "Tellman, Steven" <Steven.Tellman@idt.com>
Subject: Re: HDMI v. ICH8 on Dell XPS M1330
Date: Fri, 29 Feb 2008 07:04:24 -0800
Message-ID: <16A430A423D62246A24C9A892622FE66048C11@CORPEXCH1.na.ads.idt.com>
References: <1204152070.12914.18.camel@localhost><s5hablls40f.wl%tiwai@suse.de><16A430A423D62246A24C9A892622FE66048B88@CORPEXCH1.na.ads.idt.com><1204248546.12914.86.camel@localhost><s5h63w8q8lt.wl%tiwai@suse.de><16A430A423D62246A24C9A892622FE66048C09@CORPEXCH1.na.ads.idt.com>
	<s5htzjrq0a4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mxout2.mainstreet.net (mxout2.mainstreet.net [204.69.220.25])
	by alsa0.perex.cz (Postfix) with ESMTP id EB7C110387B
	for <alsa-devel@alsa-project.org>; Fri, 29 Feb 2008 16:04:59 +0100 (CET)
Content-class: urn:content-classes:message
In-Reply-To: <s5htzjrq0a4.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Armando Di Cianno <armando@goodship.net>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I remember there being some work that the graphics guys had to do on the
Windows side to get HDMI audio working for us. We have no control over
the HDMI, we just enable our SPDIF pin and pump the bits.

I can see if I can get a contact over at NVidia/ATI to help us out a bit
if you want.

IDT PC Audio Demo/Linux/Test
(512) 330-3127


-----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de] 
Sent: Friday, February 29, 2008 8:56 AM
To: Tellman, Steven
Cc: Armando Di Cianno; alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] HDMI v. ICH8 on Dell XPS M1330

At Fri, 29 Feb 2008 06:48:12 -0800,
Tellman, Steven wrote:
> 
> Takashi,
> 
> 	On the XPS M1330 (and XPS M1530) the SPDIF pin of the 9228 is
> hooked to the HDMI as these laptops were made before the HDMI portion
> had their own audio codec portion of the transceiver. So technically,
it
> should be pretty simple ;) 

Thanks, that's good to know.

Do you know any other issues that stop HDMI audio working?  IIRC, ATI
board has a h/w switch in the video side to enable/disable its
graphic-board HDMI, for example...

Also, does STAC9228 codec support verbs for controlling HDMI,
e.g. converter channel count (F2Dh, 72Dh) ?


Takashi

> 
> IDT PC Audio Demo/Linux/Test
> 
> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de] 
> Sent: Friday, February 29, 2008 5:57 AM
> To: Armando Di Cianno
> Cc: Tellman, Steven; alsa-devel@alsa-project.org
> Subject: Re: [alsa-devel] HDMI v. ICH8 on Dell XPS M1330
> 
> At Thu, 28 Feb 2008 20:29:06 -0500,
> Armando Di Cianno wrote:
> > 
> > 
> > On Thu, 2008-02-28 at 12:55 -0800, Tellman, Steven wrote:
> > > Notice we use the "Other Digital" as the jack. Is that possibly
> > > causing
> > > a problem? IEC958 shows up, but doesn't provide output to HDMI
> devices
> > > (that I've tested).
> > 
> > At a user level, this is definitely what I've experienced.
> > 
> > Are there any suggestions for testing if my current ALSA
> > install /should/ work, or how to find out if something is
> misconfigured,
> > or will simply not work?
> > 
> > I will gladly try any suggestions, thoroughly.  Thanks.
> 
> It's a bit hard to judge right now.  So far, many HDMI devices seem
> not working even though it appears set up properly.  I've heard that
> ATI HDMI devices are working, but others are not well, e.g. on some
> devices only left channel is output and on others silent.
> 
> Moreover, I'm not pretty sure whether HDMI is connected from the
> digital out of STAC codec.  On many devices (e.g. ASUS ones), there is
> a dedicated codec for the HDMI transmitter.
> 
> So, right now, it's total lack of (hardware) information,
> unfortuantely.
> 
> We may try some verbs for HDMI that are not used in the current ALSA
> code, at least.  These verbs were extended later...
> 
> 
> Takashi
> 
