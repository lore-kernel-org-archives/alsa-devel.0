From: Frank Barknecht <fbar@footils.org>
Subject: Soundcard matrix: removing some M-Audio USB devices
Date: Mon, 1 Mar 2004 00:26:21 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040229232621.GB10518@fliwatut.scifi>
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
List-Id: alsa-devel@alsa-project.org

Hallo,

I'd like to propose changing the status of three M-Audio USB
devices in the soundcard matrix to "unsupported on 2.6". The Quattro,
Audiophile USB and reportedly the Duo all don't comply to the USB
specification, as has been discussed here and on linux-usb-dev in the
recent past.

Thus they are not useable on 2.6 kernels anymore and should be removed
from the list of supported cards - or at least should have a red
WARNING sticker applied. It would be - and already is - really anoying
to someone who buys such a device and later finds out, that it is not
supported, although the website say differently.

ciao
-- 
 Frank Barknecht                               _ ______footils.org__


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
