From: 017623780966@o2online.de
Subject: Re: [ALSA - driver 0002339]: No sound with ALC260 chip
Date: Wed, 9 Aug 2006 13:27:29 +0100 (BST)
Message-ID: <2600097.1155126449877.JavaMail.root@tintin.london.ongenie.net>
Reply-To: 017623780966@o2online.de
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

At Wed, 9 Aug 2006 09:05:33 +0930 (CST),
Jonathan Woithe wrote:
> 
> Hi Takashi
> 
> > > "Lubomir" posted via the bugtracker:
> > > > I own an Acer c204 and am the only one person who use linux on 
it. I can
> > > > not get sound out of my headphone or the normal speaker. ...
> :
> > > It sounds like this particular Acer laptop needs more than the basic
> > > ALC260 model. ...
> > 
> > It seems that his laptop has a problem with with communication to
> > HD-audio codec, too, according to his recent post to alsa-devel ML:
> > 
> > > To: alsa-devel@lists.sourceforge.net
> > > Subject: [Alsa-devel] No chance to get the soundcard working
> > > From: 017623780966@o2online.de
> > > 
> > > Hello, i have a big problem with my soundcard. It have a Realtek alc260 
> > > chip (intel-hda) and its build in an Acer c204tmi notebook. I can 
not get 
> > > that card working with linux. I tried over 20 linux live cds and 
have installed 
> > > now gentoo linux on it. The problem i have is: the sound card is 
been found 
> > > by alsaconf and can be configured. Alsamixer also found the card 
and can 
> > > configure it. I have unmuted every channel and set it up to max. 
I have 
> > > always tired the headphone. I never could get sound of that notebook. 
In 
> > > dmesg i found that -> ALSA /var/tmp/portage/alsa-driver-1.0.12_rc1-r1/work/alsa-
> > > driver-1.0.12rc1/pci/hda/..
> > > /../alsa-kernel/pci/hda/hdaintel.c:525: hda_intel: azx_get_response 
timeout, 
> > > switching to single_cmd mode...
> > > i do not know is that the reason why i have no sound. I have testet 
the 
> > > sound with xmms,KsCD,Noatun, and other. xmms and noatun do not start 
playing 
> > > and KsCD start playing, but i can not hear anything.
> > > I also cant ask someone who got alsa running, because i am the only 
person 
> > > who use that notebook under linux.
> > > I do not know what i could do. Can you help me?
> 
> Interesting.  For what it's worth, I also see the azx_get_response timeout
> message every so often on my ALC260-equipped laptop, but its presence
> doesn't appear to prevent the sound system from working.  The last kernel 
I
> definitely saw the message was one of the 2.6.16-rt kernels.  I recently put
> 2.6.17-rt8 on there but haven't checked for the message lately.

This should be independent from the kernel version.
It's an error that the controller couldn't get a response for the
requested verb from the codec chip.  Usually something wrong in the
interrupt, and RIRB counter wasn't checked.

Well, now another idea came to my mind.  We can implement a polling
mode for such a case.  I'll create a test patch later.

> One thing which would be interesting to know is whether the original poster
> sees this timeout message on every boot or not.  Given that the message
> doesn't appear to stop alsa from functioning in my case, it may be worth
> trying the model settings from my previous post anyway.

Yes.


Takashi

----------

I get that message every boot. I have addet alsasound to boot so it starts always when 
i start the system.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
