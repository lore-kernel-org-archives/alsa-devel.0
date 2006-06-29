From: Henrik Kretzschmar <henrik.kretzschmar@gmx.net>
Subject: pdplus driver registration fails with EPERM
Date: Thu, 29 Jun 2006 09:52:19 +0200
Message-ID: <44A386B3.7000108@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Thanks for applying the patch.

I played a little bit with the driver and everytime I got ENODEV from modprobe.
Later I found out that the module_init() function returns ENODEV when
pci_register_driver() return an error or zero(huh!(which is the retval for sucess)).

After fixing that in my sourves I get a EPERM from pci_register_driver(), but the driver structure looks well to me.

Any ideas?

Greets,
Henrik Kretzschmar

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
