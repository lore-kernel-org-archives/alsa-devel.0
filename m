From: Bernhard Walle <bernhard.walle@gmx.de>
Subject: XMMS will not proceed to the next song in a playlist of music files.
Date: Sat, 16 Aug 2003 23:03:48 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030816210348.GA7287@mail1.bwalle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

I have the same bug as described here:

http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=75776

XMMS doesn't play until the end of the file so that the next file in the
playlist is not played. It are just a few 1/10 seconds so that you don't
see this with large files but only with small files.

It occurs on SuSE 8.1 and on Debian 3.0 with ALSA 0.9.4. I have a k7s5a
board with onboard sound. If I use the kernel driver i810_audio, there's
no problem with XMMS (but with RealPlayer so that I must use ALSA).

Using the ALSA plugin in XMMS doesn't work here. A example file is at
http://www.bwalle.de/temp/audacity/a.mp3 .

So it seems to be a bug in the OSS emulation of ALSA.


Regards,
Bernhard

-- 



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
