From: Kristof vansant <de_lupus@pandora.be>
Subject: alsa-drivers can't make on kernel 2.6 because of broken vx driver
Date: Tue, 06 Jan 2004 13:30:02 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1073392202.2633.4.camel@d51528079.kabel.telenet.be>
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

I don't know how alsa patches drivers when it has to compile on kernel
2.6, so I don't know how to fix it. 

I think lot of kernel 2.6 users would be gratefull if you fixed this
issue. 

  CC [M]  /home/lupus/alsa-driver-1.0.0rc2/pcmcia/vx/vxp440.o
/home/lupus/alsa-driver-1.0.0rc2/pcmcia/vx/vxp440.c:6:31:
linux/modversions.h: Onbekend bestand of map
/home/lupus/alsa-driver-1.0.0rc2/pcmcia/vx/vxp440.c:7:25: sndversions.h:
Onbekend bestand of map
make[3]: *** [/home/lupus/alsa-driver-1.0.0rc2/pcmcia/vx/vxp440.o] Fout
1
make[2]: *** [/home/lupus/alsa-driver-1.0.0rc2/pcmcia/vx] Fout 2
make[1]: *** [/home/lupus/alsa-driver-1.0.0rc2/pcmcia] Fout 2
make[1]: Weggaan uit map `/lib/modules/2.6.0-1.104/build'
make: *** [compile] Fout 1

Lupus (Kristof Vansant)



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
