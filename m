From: Jose Alberto Reguero <jareguero@telefonica.net>
Subject: VIA 8237 AD1980 Surround 5.1
Date: Thu, 4 Nov 2004 10:18:13 +0100
Message-ID: <200411041018.13924.jareguero@telefonica.net>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

MB: K8V SE Deluxe
CPU: AMD64
Asla driver from cvs.
Alsa lib from cvs.
The channel center and LFE ar swapped in surround 5.1.
I apply the patch:
        ttable.1.1 1
        ttable.2.4 1
        ttable.3.5 1
-       ttable.4.2 1
-       ttable.5.3 1
+       ttable.4.3 1
+       ttable.5.2 1
        slave.pcm {
                type hooks
                slave.pcm {
in the file:
/etc/alsa/cards/VIA8237.conf
and it works.
Also the mixer controls Center an LFE ar swapped.
Thanks.
Jose Alberto Reguero


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
