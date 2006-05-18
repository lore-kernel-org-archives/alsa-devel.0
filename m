From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Compile warnings, sound.c
Date: Thu, 18 May 2006 22:44:04 +0100
Message-ID: <200605182244.04516.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

For quite a while (including prior to 1.0.11) I have noticed these compile 
warnings.  Are they harmless?  Kernel is 2.4.21-99.


sound.c: In function `snd_open':
sound.c:175: warning: assignment discards qualifiers from pointer target type
sound.c:180: warning: assignment discards qualifiers from pointer target type
/usr/share/alsa1.0.11/alsa-driver-1.0.11/include/platform_device_compat.h: At 
top level:
sound.c:43: warning: `device_mode' defined but not used
rm -f snd.o
ld  -r -o snd.o sound.o init.o memory.o info.o control.o misc.o device.o 
isadma.o sound_oss.o info_oss.o wrappers.o mis

Thanks   Alan



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
