From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Is a complete Alsa restart possibly without rebooting?
Date: Mon, 11 Aug 2003 11:57:22 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0308111133090.26488-100000@studcom.urz.uni-halle.de>
References: <05ca01c35deb$290ecf40$0369a8c0@BigMotha>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <05ca01c35deb$290ecf40$0369a8c0@BigMotha>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Edward Wildgoose <ed@wildgooses.com>
Cc: Alsa-Devel <Alsa-Devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Edward Wildgoose wrote:
> > Edward Wildgoose wrote:
> > > Actually perhaps this is the problem that I am seeing as well on a P4P800
> > > board with a hyperthreaded P4.  I have a dual P3 which starts and stops alsa
> > > fine, at least up to about alsa 0.9.4.  However, with this board if I do an
> > > alsa restart, modules reload, but no sound until reboot, and this happens
> > > with various builds at least as far back as 0.9.2
> > >
> > > The main soundcard is an RME 96/8 PAD, but I also have an onboard intel
> > > compatible thing which seems to suffer the same issues.
> >
> > My P4P800 with a HT P4 runs just fine after reloading the ALSA
> > drivers, with onboard and other soundcards. Maybe you didn't run
> > "alsactl restore"?
>
> OK, assume that I didn't (although in my case it is part of the script, so
> it probably is getting called).  Why would that cause the /dev/dsp OSS
> entries not to be created?

It wouldn't, alsactl and the OSS device files aren't related.

I guess /dev/dsp is missing because your alsa script doesn't load the
OSS emulation modules (the standard alsasound script in
alsa-driver/utils/ certainly doesn't). Please try to add the following
lines somewhere in the start function:
  /sbin/modprobe snd-pcm-oss
  /sbin/modprobe snd-mixer-oss
  /sbin/modprobe snd-seq-oss


HTH
Clemens




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
