From: Mark Knecht <markknecht@comcast.net>
Subject: Re: M-Audio firewire device
Date: Tue, 02 Sep 2003 09:10:08 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1062519008.28470.19.camel@Wizard.knechthome.com>
References: <20030902085428.GA29782@ecs.soton.ac.uk>
	 <1062506521.27592.5.camel@Wizard.knechthome.com>
	 <20030902134842.GK29782@ecs.soton.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030902134842.GK29782@ecs.soton.ac.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Steve Harris <S.W.Harris@ecs.soton.ac.uk>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 2003-09-02 at 06:48, Steve Harris wrote:
> On Tue, Sep 02, 2003 at 05:42:01 -0700, Mark Knecht wrote:
> > On Tue, 2003-09-02 at 01:54, Steve Harris wrote:
> > > http://www.m-audio.com/products/m-audio/fw410.php
> > > 
> > > Maybe the first supported firewire audio device for alsa? If M-Audio give
> > > up the details. Could be a better option for laptop use than USB.
> > 
> > I'm going to guess that the issue is that this is probably an MLAN
> > device. The MLAN spec comes under NDA from Yamaha. I have a copy at
> > work. The problem is how do we get a driver to support it?
> 
> I was assuming it would be a radom proprietary format - maudio werent very
> good at sticking to th USB specs either IIRC.
> 
> If it is mLAN its only the service discovery stuff thats under NDA - and
> they've been trying to get that standardised too, so it might be free-able
> by now.
> 
> - Steve

OK, so I'm a glutton for punishment. I just tried installing their
drivers on my XP Pro system here at work, just to see what would happen,
and to see what sort of drivers get loaded. The driver installation
doesn't seem to require the device be hooked up. Actually, if it is
hooked up it tells you to remove it.

What happened is that the machine didn't reboot cleanly. This machine
can be a bit testy as it has 3 OHCI controllers in it. So it then had to
go through a scandisk which wasted some time. The machine's back up at
this point. 

So far I don't see what got installed. The 5 standard Windows drivers
are there. (1394bus, arp1394, enum1394, nic1394 and ohci1394) There is
no device under Sound, video and game controllers.

Maybe they did handle this as just a generic 1394 device, or maybe the
drivers don't get all the way installed until you plug the device in. I
can't tell.

There is a menu item for the device. It has an uninstall program and a
README. The README doesn't say much, other than NEC 1394 controllers are
not recommended. (My machine has 2 TI and 1 Via.) The Firewire410 will
operate under cable power, which is nice.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
