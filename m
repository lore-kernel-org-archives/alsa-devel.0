From: Martin Langer <martin-langer@gmx.de>
Subject: usx2y dependencies
Date: Sat, 24 Jan 2004 01:23:28 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040124002328.GA1946@tuba.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: annabellesgarden@yahoo.de
List-Id: alsa-devel@alsa-project.org


Hi,

usx2y build by "./configure --with-cards=usb-usx2y" has a dependency problem:

depmod: *** Unresolved symbols in
/lib/modules/2.4.23/kernel/sound/usb/usx2y/snd-usb-usx2y.o
depmod:         snd_usbmidi_disconnect_Rc1a56322
depmod:         snd_hack_usb_set_interface_R5b6905b8
depmod:         snd_usb_create_midi_interface_R5a5eff3a

./configure --with-cards=usb-usx2y,usb-audio fix this problem, but OTOH it
looks fine in /alsa-driver/utils/Modules.dep -- usx2y depends there on 
snd-usb-audio and that seems to be ok.

Any hints?

martin


-- 
The only nice thing about spam is that it doesn't ring.


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
