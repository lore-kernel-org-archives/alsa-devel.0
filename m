From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Opti 931: Med931 ver.2.0
Date: Tue, 13 Aug 2002 15:05:46 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D59042A.60BB8CFB@ladisch.de>
References: <20020813101600.YKOU12516.fep06-svc.mail.telepac.pt@[127.0.0.1]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate.uni-halle.de (mlucom8.urz.Uni-Halle.DE [141.48.10.118])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id PAA21861
	for <alsa-devel@alsa-project.org>; Tue, 13 Aug 2002 15:05:50 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: hugo.ferreira@mail.telepac.pt
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

hugo.ferreira@mail.telepac.pt wrote:
> > > 1. How may I compile/make and install just the modules that I am 
> > > interested in (--with-card ?)
> > 
> > You can use --with-cards or edit a file in the root directory of the alsa
> > kernel source. sorry, can't remember the name and I'm not on my home
> > computer right now.
> 
> You mean I can do a "./cvscompile --with-cards=snd-opti93x" ?
> 
> > Seems like I did "make modules" and "make modules
> > install" just like
> 
> I'll try this and see what happens. Takashi said
> a "make install" would suffice though.

I'm using the following commands to compile and install the USB MIDI
driver:

~/alsa-driver/usb# make snd-usb-midi.o
~/alsa-driver/usb# cp snd-usb-midi.o /lib/modules/2.4.18/kernel/sound/usb/

(modify file/directory names appropriately)

This only works if the package already had been installed, and if the
changes only affect one module, but this seems to be just what you want
to do.


HTH
Clemens


-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
