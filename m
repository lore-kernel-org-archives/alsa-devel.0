From: "Edward Wildgoose" <ed@wildgooses.com>
Subject: Re: Is a complete Alsa restart possibly without rebooting?
Date: Fri, 8 Aug 2003 21:25:02 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <05ca01c35deb$290ecf40$0369a8c0@BigMotha>
References: <Pine.HPX.4.33n.0308081705390.5071-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>, Alsa-Devel <Alsa-Devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

> Edward Wildgoose wrote:
> > Actually perhaps this is the problem that I am seeing as well on a
P4P800
> > board with a hyperthreaded P4.  I have a dual P3 which starts and stops
alsa
> > fine, at least up to about alsa 0.9.4.  However, with this board if I do
an
> > alsa restart, modules reload, but no sound until reboot, and this
happens
> > with various builds at least as far back as 0.9.2
> >
> > The main soundcard is an RME 96/8 PAD, but I also have an onboard intel
> > compatible thing which seems to suffer the same issues.
>
> My P4P800 with a HT P4 runs just fine after reloading the ALSA
> drivers, with onboard and other soundcards. Maybe you didn't run
> "alsactl restore"?

OK, assume that I didn't (although in my case it is part of the script, so
it probably is getting called).  Why would that cause the /dev/dsp OSS
entries not to be created?



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
