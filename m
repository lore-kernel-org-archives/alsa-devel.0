From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Re: RFC: OSS driver removal, a slightly
	different	approach
Date: Thu, 19 Jan 2006 22:09:33 +0000
Message-ID: <1137708573.8471.65.camel@localhost.localdomain>
References: <20060119174600.GT19398@stusta.de>
	 <1137694944.32195.1.camel@mindpipe> <20060119182859.GW19398@stusta.de>
	 <1137696885.32195.12.camel@mindpipe>  <s5hk6cw9h07.wl%tiwai@suse.de>
	 <1137697269.32195.14.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 76C4F13E
	for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2006 23:09:41 +0100 (MET)
Received: from lxorguk.ukuu.org.uk (unknown [81.2.110.250])
	by gate.perex.cz (Perex's E-mail Delivery System) with ESMTP id DD6A699212
	for <alsa-devel@alsa-project.org>; Thu, 19 Jan 2006 23:09:40 +0100 (MET)
In-Reply-To: <1137697269.32195.14.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Takashi Iwai <tiwai@suse.de>, Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

On Iau, 2006-01-19 at 14:01 -0500, Lee Revell wrote:
> > > Hmm.  From sound/oss/kahlua.c:
> > > 
> > > /*
> > >  *      Initialisation code for Cyrix/NatSemi VSA1 softaudio
> > >  *
> > >  *      (C) Copyright 2003 Red Hat Inc <alan@redhat.com>
> > >  *
> > > 
> > > Why was a new OSS driver written and accepted at such a late date, when
> > > OSS was already deprecated?
> > 
> > You'll find out that it must be pretty easy to write kahlua driver for
> > ALSA, too, if you look at kahlua.c.  Just need a hardware to certify
> > if this is really demanded...
> 
> Yes, it looks simple enough to write a driver without the hardware, as
> long as someone volunteers to test it...

Most of the Kahlua logic is in the SB driver. It was a wrapper added
later to make autoconfiguration simple for end users. CS55x0 (VSA1
variants) are generic sound blaster 16 emulation via SMI traps. There
are certain things you must not do

1.	Use a 64K or 128K in 16bit ring buffer
2.	Disable/Enable DMA on the sound channel while audio is running

#1 causes the box to hang dead (firmware emulation bug)
#2 mistakenly flushes the FIFOs so breaks up the audio

Otherwise its SB16 compatible.




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
