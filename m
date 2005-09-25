From: Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: EMU10K1 ac3 passthrough broken since 2.6.14-rc1
Date: Sun, 25 Sep 2005 13:08:13 +0200
Message-ID: <4336851D.7000809@roarinelk.homelinux.net>
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

Hello,

beginning with linux 2.6.14-rc1, mplayer's and xine's ac3 passthrough
with EMU10K1 stopped working. Mplayer says:

mplayer -ac hwac3 lost.201.hrhd.avi
...
alsa-init: 1 soundcard found, using: iec958:{CARD 0 AES0 0x02 AES1 0x82 AES2 0x00 AES3 0x02}
ALSA lib setup.c:549:(add_elem) Cannot obtain info for CTL elem(MIXER,'IEC958 Playback Default',0,0,0): No such file or directory
alsa-init: playback open error: No such file or directory
Could not open/initialize audio device -> no sound.
..

Card is a SB Live! CT4620,
alsa-lib 1.0.9


Any ideas?

Thanks,

-- 
  Manuel Lauss


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
