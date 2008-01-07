From: forumjunk@comcast.net (Darryl House)
Subject: Re:
	snd-hda-intel	support	for	SPDIF-in	wiht	vt1708	card?
Date: Mon, 07 Jan 2008 18:40:33 +0000
Message-ID: <010720081840.4095.47827221000A2BAB00000FFF220702455305029A06039A9D0100@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from QMTA08.westchester.pa.mail.comcast.net
	(qmta08.westchester.pa.mail.comcast.net [76.96.62.80])
	by alsa0.perex.cz (Postfix) with ESMTP id DB68024991
	for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2008 19:40:35 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, john@stilen.com
List-Id: alsa-devel@alsa-project.org

Ok, here's the current state of affairs... both the compilation and driver seem to work well now, though I haven't tested SPDIF yet. I don't know why both John Stile and I were getting ioctl errors, perhaps if it is still happening to him he can elucidate, but it isn't happening to me any more with the latest build.

I obtained and built a clean mercurial clone this morning (07 Jan 08):

%> cd /usr/src
%> rm -rf alsa-driver
%> hg clone http://hg-mirror.alsa-project.org/alsa-driver alsa-driver
%> cd alsa-driver
%> hg clone http://hg-mirror.alsa-project.org/alsa-kernel alsa-kernel
%> hgcompile

[...] compilation proceeds cleanly...

%> make install

%> alsaconf
[...] select card and configure it via alsamixer

Lo and belold, it all worked! I have a clean compilation and good response from aplay and other user space tools.

I haven't applied any patches, and I haven't been able to test SPDIF input yet but I'm betting John Stile should be able to report that faster than I can get to it...

Thank you very much for your help with this and for all of the work you and the ALSA team do!

-- Darryl

 -------------- Original message ----------------------
From: Takashi Iwai <tiwai@suse.de>
> At Wed, 02 Jan 2008 22:31:19 +0000,
> Darryl House wrote:
> > 
> > 
> >  -------------- Original message ----------------------
> > [...]
> > > > I'd like to get this card's spdif working.  What else can I do to help?
> > > > Although the driver loads, the user space tools can't use the card any
> > > > more.  Thank you.
> > > > 
> > > Should I assume at this point no more work will be done on the
> > > snd-hda-intel driver to fixing SPDIF-in for the vt1708 sound card?
> > > Thank you for all your work so far.
> > > 
> > 
> > I think it is a bit early to make that assumption. There isn't a lot
> > of demand for this particular card, but it doesn't seem that it
> > will take too much work to get it going again... after all, it did
> > basically work before the last patch, and I am hoping that Takashi
> > will find some time soon to address the issues.
> 
> Hm, I see no obvious error in the patch.  Are you sure that the latest
> HG driver works properly if you don't apply the patch?
> 
> Let's begin with that.
> 
> 
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
