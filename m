From: Axel Braun <axel.braun@gmx.de>
Subject: New attempt: Sound problem with AC97 chipset
Date: Tue, 1 Feb 2005 20:01:08 +0100
Message-ID: <200502012001.08481.axel.braun@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: alsa-user-admin@lists.sourceforge.net
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: alsa-user@lists.sourceforge.net
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I have a ASRock Motherboard (K7VTA4+) which has a VIA Chipset on board:

0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 50)
        Subsystem: ASRock Incorporation: Unknown device 9761

The system runs SuSE 9.2 with alsa 1.0.8. Unfortunately it gives no sound at 
all, even if the mixer is turned on. I tried various options for ac97_quirk, 
from -1 to 4, without success, e.g.

options snd-via82xx ac97_quirk=4 enable=1 index=0 joystick=1
(Strange enough, YaST does not recognize these settings when changing the 
parameters with the hardware-sound module)

Is there a way I can force alsa to issue debug output?
What is the difference to Knoppix 3.7, where the sound works out of the box?
Any other hint what I could try?

Thanks
Axel


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
