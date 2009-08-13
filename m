From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [RFC] Break up the patch_sigmatel.c
Date: Thu, 13 Aug 2009 18:05:39 +0300
Message-ID: <1250175939.29682.14.camel@maxim-laptop>
References: <1250109345.7974.10.camel@localhost.localdomain>
	<s5hd47046zr.wl%tiwai@suse.de>
	<1250148877.8641.19.camel@localhost.localdomain>
	<s5h1vngywp8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 733E224550
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Aug 2009 17:05:44 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id e21so230347fga.21
	for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2009 08:05:43 -0700 (PDT)
In-Reply-To: <s5h1vngywp8.wl%tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 2009-08-13 at 09:55 +0200, Takashi Iwai wrote:
> At Thu, 13 Aug 2009 10:34:37 +0300,
> Maxim Levitsky wrote:
> > 
> > On Thu, 2009-08-13 at 07:28 +0200, Takashi Iwai wrote: 
> > > At Wed, 12 Aug 2009 23:35:45 +0300,
> > > Maxim Levitsky wrote:
> > > > 
> > > > Hi folks,
> > > > 
> > > > I own an stac9227 and with latest kernel, it doesn't output any sound
> > > > via front headphones. (this a is desktop)
> > > 
> > > OK, that could be my recent changes.
> > > Could you give alsa-info.sh output, at best, on the working and
> > > non-working states?
> > 
> > Oh, its was my mistake.
> > in short I thought that I installed the alsa git tree, but it turns out
> > that I was using the kernel drivers. alsa git drivers doesn't have this
> > bug anymore.
> > 
> > The long explanation of this my mistake was that I first installed alsa
> > drivers, but forgot, and installed kernel, which overwrite them.
> 
> Heh, good to hear that it's OK :)
> 
> > > > I don't want to bother you with details, etc, I will fix that myself. I
> > > > have good knowledge of the device.
> > > > 
> > > > However, the mess that is patch_sigmatel.c seems to be doubled. 
> > > > its huge file, and there are loads on new codecs added.
> > > > 
> > > > I have a suggestion, to break it up into smaller files.
> > > > I especially want to move all 'data' from it to header file, and sort it
> > > > by model. 
> > > 
> > > The "data" shouldn't be in header files in general...
> > > 
> > > > Maybe move pin configs to separate file.
> > > 
> > > This could be good.
> > > 
> > > > Also I know that stac9200 is quite old, and uses many different support
> > > > functions. I could move these in another file as well.
> > > > 
> > > > In other words, I want to break it up into several (5 maybe) files,
> > > > while not touching the code itself (I so that later maybe)
> > > > 
> > > > Since it is quite dirty and hard work, I want to ask if you agree.
> > > 
> > > It's open source, feel free to do it.
> > 
> > nice, I actually asked about this just for one reason, back when I send
> > my patches to this driver, I think I tried to do something similar, but
> > it was rejected or so.
> 
> Hm, I don't remember exactly, but splitting to files would be OK.
> But splitting to separate modules again would result in more exports,
> name space problems.  So, splitting to files and including from the
> main *.c is a reasonable compromise, I think.
Sure, I have never thought about creating separate modules.
Memory isn't scarce nowadays.

> 
> > And another note.
> > Back in time, when I knew that driver well, back and front outputs were
> > handled by same DAC, and it happened to be DAC0. This DAC is connected
> > via analog loopback to ADC0.
> > 
> > Now front output is connected to another DAC, so loopback works only for
> > back output. However I can control the volume of front and back channels
> > separately, and don't know which feature I need more now (I don't use my
> > tv card often any more nowadays)
> > 
> > Maybe add a codec hint for that?
> 
> Sounds like a good idea.
I''l hack on it.

> 
> 
> > > > Btw, half of static data can be retrieved from codec by querying it
> > > > (like dac,adc,pin node ids)
> > > 
> > > Yes.
> > > 
> > Indeed.
> > 
> > 
> > I think that the best solution to all hda problems, it once and for all
> > write a generic driver for all codecs, and put pin configs in, a
> > 'firmware' file (this is already done?)
> 
> Yeah, that's my dream.  The "firmware" stuff is already there, provided
> as "patch" parameter.
> 
> > Most of things can be retrieved from verb responses + pin configs
> > 
> > 
> > Why not?
> 
> Just because the parsing the all possible codec connections is no
> trivial task.  Many codecs have connections between pin and DAC
> through different multiple routes, one for direct, one over analog
> mixer, and SPDIF loopback, etc.  It's especially for older codecs
> that inherit the design from old days, such as ALC88x, CMI codecs
> and AD1986A / AD1988.

This is indeed a problem.
However, possible solution is not to  create a driver that replaces
everything, but rather a codec neutral driver, and make it support more
and more codecs. It also doesn't have to support every codec on earth,
just a subset of known codecs, that are well designed.


Such problems, also could be marked, in same firmware file, or so.
Direct connection can be preferred too.


Best regards,
	Maxim Levitsky

> 
> 
> thanks,
> 
> Takashi
