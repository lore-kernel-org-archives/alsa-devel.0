From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: usb-audio Quattro
Date: Mon, 28 Jun 2004 01:37:56 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40DEF7E4.70700@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

There is something very strange happening with the latest cvs code for 
the usb-audio driver.

I've upgraded my music machine to demudi-1.1.0 which uses gcc-3.3 and 
installed a 2.4.26 kernel.

The machine has the ohci interface.

Unfortunately I encountered the following bugs:

- input channels 1 and 3 are permanently maxed.
- I cannot record stereo with two versions of arecord at the same time.
- I cannot get access to all four channels at the same time via the 
route plugin (q4b).

Essentially this means I can only get input from one channel at a time, 
and then only 2 or 4.

It's strange because the driver appeared to work very well on my main 
machine which has gcc-2.2, kernel-2.4.19, a uhci interface and the 
patched driver code from last weekend.

Is there any more info needed to debug the problem?

-- 
Patrick Shirkey - Boost Hardware Ltd.
Http://www.boosthardware.com
Http://www.djcj.org/LAU/guide/ - The Linux Audio Users guide
Http://www.djcj.org/gigs/ - Gigs guide Korea
Http://www.nana7.net - Bar Nana - Itaewon, Seoul, Sth Corea
========================================


Apparently upon the beginning of the barrage, the donkey broke 
discipline and panicked, toppling the cart. At that point, the rockets 
disconnected from the timer, leaving them strewn around the street. 
Tethered to the now toppled cart, the donkey was unable to escape before 
the arrival of U.S. troops.

United Press International
Rockets on donkeys hit major Baghdad sites

By P. MITCHELL PROTHERO
Published 11/21/2003 11:13 AM



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
