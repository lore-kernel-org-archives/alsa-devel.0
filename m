From: Jon <jgrosshart@gmail.com>
Subject: kernel 2.6.14.x and alsamixer problems
Date: Sat, 19 Nov 2005 00:11:02 -0500
Message-ID: <437EB3E6.6030205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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

Greetings all. Ever since I upgraded to linux-2.6.14 and up, I get this
error when running 'alsamixer'


ALSA lib simple_none.c:1216:(simple_add1) helem (MIXER,'Front Playback
Volume',0,0,0) appears twice or more
alsamixer: function snd_mixer_load failed: Invalid argument


It does it with alsa-1.0.9 and 1.0.10... I use alsa
{driver,lib,oss,utils} on my box and leave the kernel sound section
alone. As soon as I switch back to 2.6.13.4 it plays nice once again
which is confusing to me...... I'm using the emu10k1 chip (SB Live!
Value 5.1). Any insight on this matter would be greatly appreciated...

Jon


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
