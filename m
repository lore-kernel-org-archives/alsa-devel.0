From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: Why analog loopback of sigmatel devices got
 removed?
Date: Fri, 19 Jun 2009 14:36:39 +0300
Message-ID: <1245411399.9708.3.camel@localhost>
References: <1245369035.6830.27.camel@localhost>
	<s5h1vpgg2d6.wl%tiwai@suse.de> <1245399701.8549.2.camel@localhost>
	<s5hfxdweioc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f226.google.com (mail-fx0-f226.google.com
	[209.85.220.226])
	by alsa0.perex.cz (Postfix) with ESMTP id B5B9E244EA
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Jun 2009 13:36:43 +0200 (CEST)
Received: by fxm26 with SMTP id 26so1051780fxm.32
	for <alsa-devel@alsa-project.org>; Fri, 19 Jun 2009 04:36:43 -0700 (PDT)
In-Reply-To: <s5hfxdweioc.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Maxim Levitsky <maximlevitsky@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2009-06-19 at 10:23 +0200, Takashi Iwai wrote:
> At Fri, 19 Jun 2009 11:21:41 +0300,
> Maxim Levitsky wrote:
> > 
> > On Fri, 2009-06-19 at 08:32 +0200, Takashi Iwai wrote:
> > > At Fri, 19 Jun 2009 02:50:35 +0300,
> > > Maxim Levitsky wrote:
> > > > 
> > > > Hi,
> > > > 
> > > > Due to lack of time, I didn't update kernel on my desktop system.
> > > > Now I notice that analog loopback go removed. Why?
> > > 
> > > Because it harms than helps more often.  I've got tons of bug reports
> > > and been upset just because users blindly set "Analog Loopback" mixer
> > > switch and lost their sound output.  This is no mixer element that
> > > behaves intuitively -- it shuts out PCM output instead of adding the
> > > analog loopback like other hardwares.
> > 
> > Here it doesn't shut PCM.
> > I just hear input in headphones, mixed with output.
> > I suspect that this feature might not work correctly on newer devices
> > that ones I have added.
> 
> Possibly...

Probably IDT removed the analog mixer in quest for better quality.

I think it should work fine for "STAC..." parts.

Anyway lets put it back at least for my STAC9227, OK?

Best regards,
	Maxim Levitsky
