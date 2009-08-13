From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [RFC] Break up the patch_sigmatel.c
Date: Thu, 13 Aug 2009 10:34:37 +0300
Message-ID: <1250148877.8641.19.camel@localhost.localdomain>
References: <1250109345.7974.10.camel@localhost.localdomain>
	<s5hd47046zr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f214.google.com (mail-fx0-f214.google.com
	[209.85.220.214])
	by alsa0.perex.cz (Postfix) with ESMTP id C0355243D9
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Aug 2009 09:34:42 +0200 (CEST)
Received: by fxm10 with SMTP id 10so502928fxm.45
	for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2009 00:34:42 -0700 (PDT)
In-Reply-To: <s5hd47046zr.wl%tiwai@suse.de>
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

On Thu, 2009-08-13 at 07:28 +0200, Takashi Iwai wrote: 
> At Wed, 12 Aug 2009 23:35:45 +0300,
> Maxim Levitsky wrote:
> > 
> > Hi folks,
> > 
> > I own an stac9227 and with latest kernel, it doesn't output any sound
> > via front headphones. (this a is desktop)
> 
> OK, that could be my recent changes.
> Could you give alsa-info.sh output, at best, on the working and
> non-working states?

Oh, its was my mistake.
in short I thought that I installed the alsa git tree, but it turns out
that I was using the kernel drivers. alsa git drivers doesn't have this
bug anymore.

The long explanation of this my mistake was that I first installed alsa
drivers, but forgot, and installed kernel, which overwrite them.


> 
> > I don't want to bother you with details, etc, I will fix that myself. I
> > have good knowledge of the device.
> > 
> > However, the mess that is patch_sigmatel.c seems to be doubled. 
> > its huge file, and there are loads on new codecs added.
> > 
> > I have a suggestion, to break it up into smaller files.
> > I especially want to move all 'data' from it to header file, and sort it
> > by model. 
> 
> The "data" shouldn't be in header files in general...
> 
> > Maybe move pin configs to separate file.
> 
> This could be good.
> 
> > Also I know that stac9200 is quite old, and uses many different support
> > functions. I could move these in another file as well.
> > 
> > In other words, I want to break it up into several (5 maybe) files,
> > while not touching the code itself (I so that later maybe)
> > 
> > Since it is quite dirty and hard work, I want to ask if you agree.
> 
> It's open source, feel free to do it.

nice, I actually asked about this just for one reason, back when I send
my patches to this driver, I think I tried to do something similar, but
it was rejected or so.


And another note.
Back in time, when I knew that driver well, back and front outputs were
handled by same DAC, and it happened to be DAC0. This DAC is connected
via analog loopback to ADC0.

Now front output is connected to another DAC, so loopback works only for
back output. However I can control the volume of front and back channels
separately, and don't know which feature I need more now (I don't use my
tv card often any more nowadays)

Maybe add a codec hint for that?




> 
> > Btw, half of static data can be retrieved from codec by querying it
> > (like dac,adc,pin node ids)
> 
> Yes.
> 
Indeed.


I think that the best solution to all hda problems, it once and for all
write a generic driver for all codecs, and put pin configs in, a
'firmware' file (this is already done?)

Most of things can be retrieved from verb responses + pin configs


Why not?


Thanks,
	Best regards,
		Maxim Levitsky

> 
> 
> thanks,
> 
> Takashi
