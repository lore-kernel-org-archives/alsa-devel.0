From: Werner Schweer <ws@seh.de>
Subject: tascam us-122 midi in does not work
Date: Sun, 13 Jun 2004 13:07:20 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200406131307.21072.ws@seh.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
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

Hello,

Some strange effect occurs on my tascam us-122 audio/midi usb
device:
   After starting JACK the midi input does not work anymore. Not even
the midi in led on the us-122 flashes. Midi output is always fine. 
After stopping JACK midi input still does not work. Midi input works 
again after disconnect/reconnect the usb cable.
I'm using current ALSA cvs and kernel 2.6.7rc3. 

Can anyone confirm this to work on a normal system?

Regards,
Werner




-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
