From: Doug McLain <nostar@comcast.net>
Subject: S/PDIF broken on Delta 1010LT  (ice1712)
Date: Sun, 19 Dec 2004 21:37:39 -0500
Message-ID: <41C63AF3.9080002@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
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

S/PDIF appears to be broken in the ice1712 driver on recent versions of 
alsa.  I used to use it fine on 2.4 kernels (alsa 1.0 - 1.0.3), then I 
quit using it for a while.  Now on 2.6 / 1.0.7 (cvs) I can't get S/PDIF 
to work. I get silence untill I start screwing with Master Clock 
settings in envy24control, then I get loud white noise.  I was able to 
get correct sound once, by doing the following:

Revert from 1.0.7(cvs) to 1.0.4 (driver, lib, and envy24control).  I 
load the driver, then I start jack, then I play a file via xmms (using 
xmms-jack of course), then run envy24control, and click 'Word Clock' as 
Master Clock.  If I do this in exactly this order I get sound.  If I 
click any other Clock setting I get white noise that cant be reversed 
untill I unload the driver.

I went back to 1.0.7 (cvs) to do the same thing, but when I click Word 
Clock it doesnt stay, it immediately jumps back to its original state 
(usually Internal 48000).  I can hear the audio for a split second 
everytime I click Word Clock.

Doug

-- 
http://nostar.isa-geek.com/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
