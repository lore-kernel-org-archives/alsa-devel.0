From: "Ivica Bukvic" <ico@fuse.net>
Subject: RE: Question regarding current ESS Maestro 3M soundcard support
Date: Sat, 16 Feb 2002 22:46:05 -0500
Message-ID: <000001c1b765$a0916e70$ac1f830a@ico>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Received: from mta02.fuse.net (mx2.fuse.net [216.68.1.120])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id EAA09126
	for <alsa-devel@alsa-project.org>; Sun, 17 Feb 2002 04:43:46 +0100
In-Reply-To: <s5hlmdz54vt.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: 'Takashi Iwai' <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi, I want to thank you very much for your comprehensive response. I've
written to the ess support e-mail pleading for more Linux support and
got no response (no surprise there). Is there any way that we can start
a petition or somehow force them to release the specs (even if needed
under NDA agreement to a few persons such as yourself who would be
capable of improving the driver)? Also, what are the chances for
reverse-engineering the Windows drivers to build a better Linux driver?

Ivica Ico Bukvic


> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Tuesday, February 12, 2002 6:14 AM
> To: Ivica Bukvic
> Cc: alsa-devel@alsa-project.org; alsa-user@alsa-project.org
> Subject: Re: [Alsa-devel] Question regarding current ESS Maestro 3M
> soundcard support
> 
> Hi,
> 
> At Mon, 11 Feb 2002 21:28:53 -0500,
> Ivica Bukvic wrote:
> >
> > Hi all!
> >
> > I have an Dell Inspiron 8K and my question is whether the current
> > Maestro M3 chip is fully supported or does it currently only furnish
> > SB16 compatibility mode (I might be talking nonsense here, but this
is
> > what I heard a while ago, or something like it and my understanding
is
> > that the current driver support is only partial due to incomplete
> > disclosure of the hw specs by the ESS, again, please correct me if I
am
> > wrong). Basically, from my understanding it seems that the M3
soundcard
> > is being classified as a "sound accelerator" (whatever that means),
and
> > as such I would expect it to be capable of mixing audio streams in
> > hardware (just as emu10k1 chip does, even though emu10k1 is much
more
> > powerful). So far, I was only able to get one stream out of the card
in
> > the latest ALSA driver, while I got 2 streams with the OSS-Free
drivers
> > (third stream would garble the two existing streams and return an
i/o
> > error).
> 
> So it is on ALSA, too.
> Theoretically more could be, but it seems that the (only one) DSP code
> provided from ESS has a bug.
> 
> 
> > So, is this the default behavior?
> 
> Yes.
> 
> 
> > I would assume that most of the modern-day cards should be capable
of
> > down-mixing at least 16 or 32 streams of sound, since that is what
they
> > are usually capable of reproducing in Windows at any given time
(unless
> > in Windows the down-mixing is done in software, which is certainly a
> > possibility and in many cases a known fact).
> >
> > So, my questions are:
> >
> > Is this a hardware limitation?
> 
> No.
> 
> > or
> >
> > Is this current driver's limitation?
> 
> Yes.
> 
> > If the second is the case, then what are the chances of improving
this
> > issue in the nearby future?
> 
> Only if we receive detailed information of DSP engine or better DSP
> codes from ESS.
> 
> 
> > Finally, what are the chances of getting the ESS to talk and give us
the
> > exact specs for this soundcard so that the driver can be finished?
> 
> Unfortunately ESS is famous to provide the only minimum information,
> so far.  I hope this will change in future..
> 
> 
> ciao,
> 
> Takashi



_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
