From: pepe pepe <prmgdll@yahoo.com>
Subject: Involving EMU10K1x HOW-TO
Date: Sat, 30 Oct 2004 13:50:22 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041030205022.16741.qmail@web50001.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

I was recently helping a friend get his Dell Sound
Blaster Live! sound card. I found this site and told
him to follow step by step the how-to.
After he compiled everything and started modprobing
all the modules he got a error while loading
snd-emu10k1x, this is what dmesg said:

snd_emu10k1x: Unknown symbol snd_rawmidi_receive
snd_emu10k1x: Unknown symbol snd_rawmidi_transmit
snd_emu10k1x: Unknown symbol snd_rawmidi_new
snd_emu10k1x: Unknown symbol snd_rawmidi_set_ops

we could not find how to compile rawmidi anywhere
untill a friend in IRC found a forum that said to
compile it with emu10k1x by adding
--with-cards=emu10k1,mpu401.

It would be very usefull for other users if you could
include those extra 8 characters in the how-to.


Pepe.

irc.freenode.net @ #archlinux


	
		
__________________________________
Do you Yahoo!?
Yahoo! Mail - You care about security. So do we.
http://promotions.yahoo.com/new_mail


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
