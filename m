From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: 'unresolved symbol lock_kernel' on 2.4 kernel
Date: Tue, 22 Nov 2011 11:43:37 +0000
Message-ID: <201111221143.37582.gineera@aspect135.co.uk>
References: <201111211554.50134.gineera@aspect135.co.uk>
	<s5hmxbo38kx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.ip04ir2.opaltelecom.net (out1.ip04ir2.opaltelecom.net
	[62.24.128.240])
	by alsa0.perex.cz (Postfix) with ESMTP id BC7A8103936
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2011 12:38:17 +0100 (CET)
In-Reply-To: <s5hmxbo38kx.wl%tiwai@suse.de>
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tuesday 22 November 2011 07:44, you wrote:
> At Mon, 21 Nov 2011 15:54:50 +0000, Alan Horstmann wrote:
> > As part of recent testing I attempted to build current 1.0.24 alsa-driver
> > on an older machine with 2.4.21-99 kernel .
> >
> > 'configure' and 'make' proceeded uneventfully, but 'rcalsasound start'
> > gave following error:-
> >
> > "Starting sound driver: snd-ice1712 /lib/modules/2.4.21-99-athlon/kernel/
> > sound/acore/snd.o: unresolved symbol lock_kernel
> > /lib/modules/2.4.21-99-athlon/kernel/sound/acore/snd.o: unresolved symbol
> > unlock_kernel
> > /lib/modules/2.4.21-99-athlon/kernel/sound/acore/snd.o: insmod /lib/
> > modules/2.4.21-99-athlon/kernel/sound/acore/snd.o failed
> > /lib/modules/2.4.21-99-athlon/kernel/sound/acore/snd.o: insmod
> > snd-ice1712 failed"
> >
> > This does not occur on 1.0.23 (or previous builds that I have tested).
> >
> > I am aware that there was discussion about ditching 2.2/2.4 support, but
> > my understanding was that 1.0.24 should build and work, but may be the
> > last to do so - is that correct?
>
> Well, I don't think any developers actually tested 2.2/2.4 with the
> real machine.  We usually test the builds, but no more than that.
> So it's not unsurprising if 1.0.24 doesn't work with 2.4 kernel.
>
> > Is there a simple fix for this problem?
>
> Stick with 1.0.23 :)  There are no big changes regarding ice1712
> driver since 1.0.23.  The only change is the support of delta66e.

Well, I only showed the ice1712 failures since the others duplicated.

> Or, just adding #include <linux/smp_lock.h> in include/adriver.h
> might fix the problem.

Thanks for the pointers; I have tracked this down now.  The includes were 
removed in Nov 2010.  pcm_native.patch and info.patch add lock_kernel() etc 
back in.  Adjustments to pcm_native.patch effectively added the include, but 
info.patch is missing it.

Adding  #include <linux/smp_lock.h>  to the first hunk of acore/info.patch 
fixed the build and load of the modules fine.

I realize there is not much interest from core devels in these sort of fixes.  
But if support for older kernels is to be formally abandoned, it would be 
nice to have a branch somewhere that represents the proper end-of-the-line 
where small fixes can be added - a quiet siding with buffers etc rather than 
just the track going over a cliff edge!

Regards

Alan
