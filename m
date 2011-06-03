From: Greg KH <greg@kroah.com>
Subject: Re: AudioArduino - an ALSA soundcard driver for
	FTDI-based Arduinos
Date: Fri, 3 Jun 2011 14:37:28 +0900
Message-ID: <20110603053728.GA20937@kroah.com>
References: <4DE31FE4.4040807@imi.aau.dk> <20110530074204.GA7806@kroah.com>
	<4DE3B7B4.8000805@imi.aau.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 0ACB91037F2
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Jun 2011 07:39:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4DE3B7B4.8000805@imi.aau.dk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: sdaau <sd@imi.aau.dk>
Cc: alsa-devel@alsa-project.org, linux-usb@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, May 30, 2011 at 05:28:52PM +0200, sdaau wrote:
> >It could just be an option to the existing ftdi_sio driver that is
> >enabled somehow for a specific device, right?
> >
> 
> Well, I wish it was so - but unfortunately, it is not that way currently.
> 
> The thing is, I'm not really an expert in programming, and even less
> in kernel drivers. So, for the time that I had at my disposal, the
> only thing I could have done is try to understand ALSA driver
> architecture a bit better - while the USB part is completely
> "abstracted".
> 
> What I mean by that, is that the main driver file
> (ftdi_sio-audard.c) is first and foremost a copy of ftdi_sio.c from
> 2.6.32 kernel; then it includes a 'snd_ftdi_audard.h' file, which is
> here not a traditional header; it simply contains additional
> functions which 'add' the ALSA interface to ftdi_sio.c.
> 
> Finally, the two architectures are connected, such that the ftdi's
> callbacks also call the ALSA related callbacks, in particular:
> 
> * ftdi_sio's ftdi_process_packet (raised on incoming USB data) calls
> ALSA-related audard_xfer_buf function (and so the audio capture
> direction is handled)
> * ALSA related snd_card_audard_pcm_timer_function calls ftdi_sio's
> ftdi_write function (which controls outgoing USB data - and so the
> audio playback direction is handled).
> 
> I've just posted a diff on the SVN repository between the current
> ftdi_sio-audard.c and the original ftdi_sio.c from kernel 2.6.32:
> 
> http://sdaaubckp.svn.sourceforge.net/viewvc/sdaaubckp/audard/snd_ftdi_audard-an8m/sio2.6.32-audard.diff?revision=211&view=markup
> 
> ... the link should show syntax coloring, so it maybe gets easier to
> see what's going on there.

Care to email it?  That way we can review it here and see how to
structure it.

> In essence, this driver keeps everything ftdi_sio has (so you still
> get a /dev/ttyUSB0; you can still 'cat' from or 'echo' to this
> device node as usual) - except that, additionally, data is passed
> also to the ALSA-related memory structures (i.e. the dma_area of a
> particular ALSA substream).
> 
> Initially, I really wanted to essentially keep ftdi_sio as is, so
> that I wouldn't have to worry about changes to its code; but as the
> ALSA interface requires new functions, I couldn't find a way how to
> selectively #include these functions based on a driver option. One
> could use #defines, maybe, but that's still compile-time handling,
> not run-time handling. And so, I decided to focus instead on
> problems that I had a chance of solving (such as wrapping data for
> the ALSA ring buffers). And just today I discovered that the driver
> needs a couple of changes, that were implemented in ftdi_sio.c since
> 2.6.32, so that it would compile for 2.6.38 (I have now added
> comments related to this is the source file up on SVN).
> 
> 
> However, if there is some sort of a tutorial/guide (or even a
> specific existing driver file example) that I could refer to, so as
> to turn the current architecture into an option-based one, such that
> I avoid messing with ftdi_sio.c directly -- I'd definitely love to
> try and do that; so please let me know if there is some sort of a
> recommended reading for this.

I don't think there is a "tutorial" for something like this, but we
would be glad to help you out here to do this.

So, care to post the code here?

thanks,

greg k-h
