From: Orm Finnendahl <finnendahl@folkwang-hochschule.de>
Subject: alsa-utils make error
Date: Tue, 22 Jul 2003 16:38:04 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030722143803.GA20096@finnendahl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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

Hi,

trying to compile alsa-utils from 2003-07-22.tar.bz2 cvs-snapshot
stops at amixer.c and gives the following error:

make[1]: Entering directory `/root/install/alsa/alsa-utils/amixer'
gcc -DHAVE_CONFIG_H -I. -I. -I../include -I../include    -g -O2 -c amixer.c
gcc: Internal error: Speicherzugriffsfehler (program cc1)
Please submit a full bug report.

./configure went well.

any ideas (anybody needs any screendumps for troubleshooting)?

--
Orm


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
