From: Kristof vansant <de_lupus@pandora.be>
Subject: plz fix this before alsa 1.0.0 get's released
Date: Mon, 15 Dec 2003 01:38:15 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1071448695.2358.6.camel@d51521F3E.kabel.telenet.be>
Mime-Version: 1.0
Content-Type: text/plain
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

alsa won't compile on kernel 2.6 
removing sndversions.h in vxp440.c and vxpocket.c does the trick. 

/home/lupus/alsa-driver-1.0.0rc2/pcmcia/vx/vxp440.c:6:31:
linux/modversions.h: Onbekend bestand of map
/home/lupus/alsa-driver-1.0.0rc2/pcmcia/vx/vxp440.c:7:25: sndversions.h:
Onbekend bestand of map
make[3]: *** [/home/lupus/alsa-driver-1.0.0rc2/pcmcia/vx/vxp440.o] Fout
1
make[2]: *** [/home/lupus/alsa-driver-1.0.0rc2/pcmcia/vx] Fout 2
make[1]: *** [/home/lupus/alsa-driver-1.0.0rc2/pcmcia] Fout 2
make[1]: Weggaan uit map `/lib/modules/2.6.0-0.test11.1.102/build'
make: *** [compile] Fout 1




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
