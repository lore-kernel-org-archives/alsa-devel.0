From: Martin Langer <martin-langer@gmx.de>
Subject: trying out usb hotplugs
Date: Thu, 28 Nov 2002 01:27:02 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021128002702.GA641@tuba.home>
Reply-To: martin-langer@gmx.de
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
To: alsa-devel@lists.sourceforge.net, perex@suse.cz
List-Id: alsa-devel@alsa-project.org


Hi,

usb hotplug works perfect if my usbmidi client isn't aconnected to another
midi client. But the aconnected usb midi device still remains in the clients
list, after hotpluging out. The next hotplug in of my usb device needs an
aconnect -x before or I won't see my card in /proc/asound/cards again.
But I haven't found a real problem during my tests of usb hotpluging. Thanks.


martin


-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
