From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: usb-midi
Date: Mon, 09 Sep 2002 13:41:07 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D7C88D3.9DD9DB53@ladisch.de>
References: <3D77A319.3010703@boosthardware.com>
 <DAELIEGDPLDDCIJPAICBGEHNCDAA.annabellesgarden@yahoo.de>
 <s5hvg5jwgvk.wl@alsa2.suse.de> <3D7912A2.1000908@boosthardware.com>
 <3D791A82.7040704@boosthardware.com> <3D797DF2.6050001@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Patrick Shirkey wrote:
> I missed the merge of the drivers.
> 
> Do we still have a usb-midi module or is everything usb-audio now?

Both. :-)

All USB devices are handled by snd-usb-audio.
The snd-usb-midi module still exists, but is loaded automatically
by snd-usb-audio. For the user, only snd-usb-audio matters.


HTH
Clemens


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
