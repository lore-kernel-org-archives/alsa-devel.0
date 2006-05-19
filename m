From: Giuliano Pochini <pochini@shiny.it>
Subject: Crash on playback with x86_64
Date: Fri, 19 May 2006 23:37:12 +0200
Message-ID: <20060519233712.9ceb39b3.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


An Athlon 64 user (Asus A8V-deluxe VIA K8T800 PCI/AGP chipset) is having
problems with ALSA and my driver for the Mia-midi sound card. The system
hangs solid when he tries to play something. The weird thing is that
capture works. 99% of the code paths are the same for both capture and
playback. The same card works on another (32 bits) box. After having tried
all usual voodoo, I still don't know what &%$@# is happening. Is there any
known or suspect problem with ALSA on 64 bits systems ?


--
Giuliano.


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
