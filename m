From: Paul Davis <paul@linuxaudiosystems.com>
Subject: hdsp driver status
Date: Wed, 7 May 2003 22:04:08 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200305080204.h48248c05344@linuxaudiosystems.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: thomas@undata.org
List-Id: alsa-devel@alsa-project.org

i finally got the information from RME to enable the mixer on the
hdsp-9652. i updated CVS, and the hdsp driver is totally
incompilable. somebody ripped out the definition of HDSP_IO_Type, and
then we have stuff like this:

../../alsa-kernel/pci/rme9652/hdsp.c:403: `HDSP_MATRIX_MIXER_SIZE' undeclared he
re (not in a function)
../../alsa-kernel/pci/rme9652/hdsp.c: In function `hdsp_read_gain':
../../alsa-kernel/pci/rme9652/hdsp.c:655: `HDSP_MATRIX_MIXER_SIZE' undeclared (f
irst use in this function)
../../alsa-kernel/pci/rme9652/hdsp.c:655: (Each undeclared identifier is reporte
d only once
../../alsa-kernel/pci/rme9652/hdsp.c:655: for each function it appears in.)
../../alsa-kernel/pci/rme9652/hdsp.c: In function `hdsp_write_gain':
../../alsa-kernel/pci/rme9652/hdsp.c:692: `HDSP_MATRIX_MIXER_SIZE' undeclared (f
irst use in this function)
../../alsa-kernel/pci/rme9652/hdsp.c: In function `snd_hdsp_set_defaults':
../../alsa-kernel/pci/rme9652/hdsp.c:3029: `HDSP_MATRIX_MIXER_SIZE' undeclared (
first use in this function)
../../alsa-kernel/pci/rme9652/hdsp.c: In function `snd_hdsp_hwdep_ioctl':
../../alsa-kernel/pci/rme9652/hdsp.c:3729: `hdsp_firmware_t' undeclared (first u
se in this function)
../../alsa-kernel/pci/rme9652/hdsp.c:3729: `firmware' undeclared (first use in t
his

can some fill me in on what is going on? why is the driver so totally broken?


-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
