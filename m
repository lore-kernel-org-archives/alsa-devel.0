From: =?iso-8859-15?q?Z=E9bulon?= <zeb@zebulon.org.uk>
Subject: unresolved symbols in snd.o after compiling cvs
Date: Sat, 7 Jun 2003 12:33:13 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200306071233.13554.zeb@zebulon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi
I tried the latest cvs for testing latest envy24HT patches, unfortunately, 
even if compilation works ok :

/sbin/depmod -a 2.4.21-0.19mm-mdk
depmod: *** Unresolved symbols in 
/lib/modules/2.4.21-0.19mm-mdk/kernel/sound/acore/snd.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.21-0.19mm-mdk/kernel/sound/drivers/vx/snd-vx-lib.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.21-0.19mm-mdk/kernel/sound/pcmcia/vx/snd-vxp440.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.21-0.19mm-mdk/kernel/sound/pcmcia/vx/snd-vxpocket.o

It prevents module snd-ice1724 to be loaded.
I am sure about my kernel source and paths.

Any idea ?
Thanks
Zeb


-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
