From: iriXx <m@iriXx.org>
Subject: quattro distortion under mandrake 9.0 - more details
Date: Fri, 17 Jan 2003 17:31:18 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E283DE6.6030508@iriXx.org>
Reply-To: m@iriXx.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-user@lists.sourceforge.net, linux-audio-user@music.columbia.edu, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

hi all...

firstly, please forgive me for crossposting - im trying to find the most 
appropriate list for the problems i've been experiencing with loud 
distorted noise running the usb quattro under mandrake 9.0....

i've ascertained now that it isnt a conflict with X, or with the mouse, 
as i booted into runlevel 3 and played a wav from the command line with 
exactly the same results. i had my doubts about this anyhow as i'm 
running this on a thinkpad 600e - it doesnt have much in the way of 
video acceleration from what i gather (NeoMagic 256 i think is the 
graphics chip)....

i've been messing around adding and subtracting stuff from sysvinit and 
loading modules manually to see what might be conflicting, i've tried 
the mwave modem as well, as modems have often been the culprit for 
device conflicts, but this doesnt seem to make any difference.
so far i've drawn a blank... it puzzles me, as i was happily running 
alsa for the usb quattro under mandrake 8.2 with no problems whatsoever.

before i wipe everything (again!) and go back to 8.2 in desperation....
does anyone know of any issues or differences between sound under mdk 
8.2 and 9.0? or any known issues with the quattro driver that might 
cause this kind of heavily distorted sound? i've checked it isnt a fault 
with my quattro as i ran it under windows (yuk!) and found that it ran fine.

the only difference in my setup that might be worth noting is that under 
8.2 i didnt realise that mandrake installed its own alsa - i grabbed a 
tarball from alsa-project.org and just installed it over the top and it 
seemed to work fine. with 9.0 i've decided to go with mandrake's alsa 
rpms, simply because i went through hell with conflicts between 9.0's 
rpms and the tarballs earlier... on this fresh install i kept things 
simple. maybe i should switch back to tarball? or maybe i should upgrade 
from the supplied alsa 0.9.rc2 ? were there changes in the way usb is 
treated in 9.0 as compared to 8.2 perhaps?...

i can also get the distortion down to a listenable level - although 
still very much present - by playing mp3s in alsaplayer with the volume 
level down to 1%.... this is hardly satisfactory though and doesnt seem 
to work in any other apps (doesnt work at all under oss emulation)...
sound level has always started out very loud with the quattro but never 
distorted like this... i've never had this problem at all until i 
installed mdk 9.0...

any suggestions would be very gratefully received!

thanks in advance,

m~

-- 
iriXx
www.iriXx.org

copyleft: creativity, technology and freedom?
info@copyleftmedia.org.uk
www.copyleftmedia.org.uk

  _
( )  ascii ribbon against html email
  X
/ \    cat /dev/sda1 > /dev/dsp


   *** stopping make sense ***



-------------------------------------------------------
This SF.NET email is sponsored by: Thawte.com - A 128-bit supercerts will
allow you to extend the highest allowed 128 bit encryption to all your 
clients even if they use browsers that are limited to 40 bit encryption. 
Get a guide here:http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0030en
