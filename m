From: Dirk Aust <dirk_aust@gmx.de>
Subject: intek8x0 driver
Date: Sun, 20 Jul 2003 13:04:51 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200307201304.51654.dirk_aust@gmx.de>
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

Hello all,
I have some difficulties using the /dev/dsp devices, when trying to use the 
call: 

mmap2(NULL, 16384, PROT_READ, MAP_SHARED, 5, 0) = -1 EIO (Input/output error)

I can open the device:
open("/dev/dsp", O_RDONLY|O_LARGEFILE) = 5

and make use of a lots ioctl.

If I'm not root, I even can't read() from that device, even though I'm the 
owner of /dev/dsp0.

Any ideas?

Best Regards



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
