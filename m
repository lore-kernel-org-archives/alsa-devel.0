From: "Mark Knecht" <mknecht@controlnet.com>
Subject: Is a complete Alsa restart possibly without rebooting?
Date: Wed, 6 Aug 2003 08:44:08 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <NDBBLGIKBJENLAMOLFHGEEKGCOAB.mknecht@controlnet.com>
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
To: Alsa-Devel <Alsa-Devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,
   I am debugging a problem that seems to require me to reboot the machine
after it happens as Alsa cannot recover. I am wondering whether there is any
known way to script a complete Alsa restart, like I can do with networking
or other drivers, so that I wouldn't have to do this reboot?

   I've tried /etc/init.d/alsasound stop and then start. This doesn't work.
I've tried the stop/start with an rmmod of everything I can see in lsmod,
but this doesn't work either.

   I suspect that a big part of the problem is that the sound card itself is
getting into a state that the drivers and Alsa do not have the capabilities
to get it out of and possibly what's happening is the reboot fixes it via a
PCI reset operation.

   Can anyone recommend a method that might actually work? This is a bit
painful because right now a simple adjustment even in alsamixer requires me
to reboot the machine.

Thanks in advance,
Mark




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
