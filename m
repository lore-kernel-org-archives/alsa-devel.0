From: Alexandr <spiro@demiart.ru>
Subject: kernel 2.6.14 and alsamixer problems
Date: Sat, 19 Nov 2005 21:13:59 +0200
Message-ID: <437F7977.7060902@demiart.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Hello !

I'm update alsa-drivers (-libs, -utils) to 1.0.10 and when use alsamixer
got next message:

bash-3.00# alsamixer
ALSA lib simple_none.c:1216:(simple_add1) helem (MIXER,'Front Playback 
Volume',0,0,0) appears twice or more

alsamixer: function snd_mixer_load failed: Invalid argument

Early used kernel-module emu10k1 from 2.6.14 work with alsa-libs and 
-utils 1.0.9 (to -10rc2)
without problems. Now i leave in kernel only soundcore and separate 
compile driver and other
from last alsa release.




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
