From: Siegfried Kettlitz <alsa@siegfried-kettlitz.de>
Subject: Terratec Phase88 (Producer) (repost)
Date: Fri, 18 Jun 2004 19:37:36 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200406181937.36533.alsa@siegfried-kettlitz.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
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

Hi,
i bought a Phase88 and got it to work under Linux with dat dirty trick:

--- ews.h
//#define ICE1712_SUBDEVICE_EWS88MT_NEW 0x3b152511
#define ICE1712_SUBDEVICE_EWS88MT_NEW   0x3b155111
---

Recording and Playing and all other stuff reported by envy24control seem to 
work properly.

Now the question:
* Has someone already begun to develop a special driver for the Phase88?
* Or is there already a clean solution?


---

This was a repost because of wrong sender-address in first mail.


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
