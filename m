From: "Tellman, Steven" <Steven.Tellman@idt.com>
Subject: Re: 1.0.15: volume levels drift on HDA with
	STAC92XXcodec
Date: Mon, 5 Nov 2007 11:33:44 -0600
Message-ID: <135FE052CEEDBF409E353B14F6BD015E0161BE7F@ausexch1.na.ads.idt.com>
References: <472A113B.7030406@redhat.com>
	<200711051653.23338.maximlevitsky@gmail.com>
	<135FE052CEEDBF409E353B14F6BD015E0161BE5D@ausexch1.na.ads.idt.com>
	<200711051908.43276.maximlevitsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mxout2.mainstreet.net (mxout2.mainstreet.net [204.69.220.25])
	by alsa0.perex.cz (Postfix) with ESMTP id C3CFB24432
	for <alsa-devel@alsa-project.org>; Mon,  5 Nov 2007 18:33:58 +0100 (CET)
Content-class: urn:content-classes:message
In-Reply-To: <200711051908.43276.maximlevitsky@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Chuck Ebbert <cebbert@redhat.com>, mranostay@embeddedalley.com
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Maxim Levitsky [mailto:maximlevitsky@gmail.com]
> Sent: Monday, November 05, 2007 11:09 AM
> To: Tellman, Steven
> Cc: Takashi Iwai; alsa-devel@alsa-project.org; Chuck Ebbert;
> mranostay@embeddedalley.com
> Subject: Re: [alsa-devel] 1.0.15: volume levels drift on HDA with
> STAC92XXcodec
> 
> On Monday 05 November 2007 18:39:39 Tellman, Steven wrote:
> > > On Monday 05 November 2007 13:40:48 Takashi Iwai wrote:
> > > > At Thu, 1 Nov 2007 20:17:30 +0200,
> > > > Maxim Levitsky wrote:
> > > > >
> > > > > On Thursday 01 November 2007 19:47:39 Chuck Ebbert wrote:
> > > > > > We have two reports now of unstable volume levels:
> > > > > >
> > > > > > https://bugzilla.redhat.com/show_bug.cgi?id=361051
> > > > > > https://bugzilla.redhat.com/show_bug.cgi?id=354981
> > > > > >
> > > > > > This is with kernel 2.6.23 plus the two ALSA merge patches
from
> > > > > > 2.6.23-rc1.
> > > > > > _______________________________________________
> > > > > > Alsa-devel mailing list
> > > > > > Alsa-devel@alsa-project.org
> > > > > > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> > > > > >
> > > > > Probably this isn't a software bug.
> > > > > Probably this chip country to datasheet doesn't have usable
> > "Master
> > > >  > Volume" (volume knob) control.
> > > > >
> > > > >
> > > > > The master volume control wasn't present before, I added
support
> > for
> > > >  > it, using data-sheets.
> > > > > I need to know what exactly sigmatel codec was used in both
cases.
> > > >
> > > > Yes, the latter case seems with STAC9205 but the former one
(361051)
> > > > isn't clear.  Please check /proc/asound/card0/codec#* entries.
> > > >
> > > >
> > > > thanks,
> > > >
> > > > Takashi
> > > >
> > >
> > > The former is also STAC9205/04/ since it is the only one with
analog
> > > loopback and two ADCs
> > >
> > > I have question, I talked with the reporter of 354981, and I don't
> > know
> > > why but his amixer
> > > gives very strange results:
> > >
> > > [root@itse68482 ~]# cat amixer-contents-kernel-2.6.23.2-36
> > > numid=0,iface=MIXER,name='Master Playback Switch'
> > >   ; type=BOOLEAN,access=rw------,values=1
> > >   : values=on
> > > numid=0,iface=MIXER,name='Master Playback Volume'
> > >   ; type=INTEGER,access=rw------,values=2,min=0,max=65536,step=1
> > >   : values=65536,65536
> > > numid=0,iface=MIXER,name='Capture Switch'
> > >   ; type=BOOLEAN,access=rw------,values=1
> > >   : values=on
> > > numid=0,iface=MIXER,name='Capture Volume'
> > >   ; type=INTEGER,access=rw------,values=2,min=0,max=65536,step=1
> > >   : values=34953,34953
> > >
> > > How can that be?
> > >
> > > According to his  lspci, he doesn't have a second sound card.
> > >
> > > Any ideas?
> > >
> > > Besides that it seems that VolumeKnob is physically broken on
> > STAC9205s,
> > > Can anybody here with STAC9205/STAC9204/STAC9254/STAC9255 test it?
> > >
> > > And last question, about STAC9254/STAC9255
> > > There is no datasheet for that chip on the web, is this just
STAC9205
> > +
> > > modem?
> > >
> > > Best regards,
> > > 	Maxim Levitsky
> > > _______________________________________________
> > > Alsa-devel mailing list
> > > Alsa-devel@alsa-project.org
> > > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> >
> > [Tellman, Steven]
> >
> > The STAC9254/55 lines are not available anymore. Yes, they were
> > basically 9204/5 + Modem.
> >
> > - Steven
> >
> >
> Hi,
> 
> Thanks a lot,
> 
> Just one more question,
> are data-sheets for STAC9872 aviable?
> I don't even see a page describing those chips on IDT website.

No, datasheets are not available.

> Furthermore, recently IDT sent a patch for STAC92HD71BXX,
> thus I want to ask whenever datasheets for it will be available.

Datasheets are available on IDT.com

http://www.idt.com/?catID=18442398

> 
> Best regards,
> 	Maxim Levitsky
