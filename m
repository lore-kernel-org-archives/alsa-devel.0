From: Axel Thimm <Axel.Thimm@ATrpms.net>
Subject: Problems building alsa-driver on FC6 (2.6.18)
Date: Sun, 22 Oct 2006 11:54:59 +0200
Message-ID: <20061022095459.GA8377@neu.nirvana>
Reply-To: alsa-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2053460778=="
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


--===============2053460778==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I can't build alsa-driver on FC6. Comparing to FC5, which is also
2.6.18 based I see the following differences during configure:

@@ -109,4 +109,4 @@
 checking for kernel linux/autoconf.h... yes
-checking for kernel version... 2.6.18-1.2200.fc5smp
-checking for GCC version... Kernel compiler:  Used compiler: gcc
(GCC) 4.1.1 20060525 (Red Hat 4.1.1-1)
+checking for kernel version... 2.6.18-1.2798.fc6
+checking for GCC version... Kernel compiler:  Used compiler: gcc
(GCC) 4.1.1 20061011 (Red Hat 4.1.1-30)
=20
@@ -158,3 +158,3 @@
 checking for input subsystem in kernel... yes
-checking for directory to store kernel
modules... /lib/modules/2.6.18-1.2200.fc5smp/updates/sound
+checking for directory to store kernel
modules... /lib/modules/2.6.18-1.2798.fc6/updates/sound
 checking for verbose procfs... on
@@ -176,21 +176,20 @@
 checking for sscanf... no
-checking for vmalloc_to_page... yes
-checking for old kmod... no
-checking for PDE... yes
-checking for pci_set_consistent_dma_mask... yes
-checking for pci_dev_present... yes
-checking for msleep... yes
-checking for msleep_interrupt... yes
-checking for msecs_to_jiffies... yes
+checking for vmalloc_to_page... no
+checking for old kmod... yes
+checking for PDE... no
+checking for pci_set_consistent_dma_mask... no
+checking for pci_dev_present... no
+checking for msleep... no
+checking for msecs_to_jiffies... no
 checking for tty->count is the atomic type... no
-checking for video_get_drvdata... yes
+checking for video_get_drvdata... no
 checking for V4L1 layer... yes
-checking for io_remap_pfn_range... yes
-checking for kcalloc... yes
-checking for kstrdup... yes
-checking for kzalloc... yes
+checking for io_remap_pfn_range... no
+checking for new io_remap_page_range... no
+checking for kcalloc... no
+checking for kstrdup... no
+checking for kzalloc... no
 checking for create_workqueue with flags... no
-checking for saved_config_space in pci_dev... yes
-checking for new pci_save_state... yes
-checking for register_sound_special_device... yes
+checking for saved_config_space in pci_dev... no
+checking for register_sound_special_device... no
 checking for driver version... 1.0.13
@@ -199,3 +198,3 @@
 checking for OSS PCM plugin system inclusion... yes
-checking for RTC callback support in kernel... yes
+checking for RTC callback support in kernel... no
 checking for HPET support... yes
@@ -208,5 +207,5 @@
 checking for removal of page-reservation for nopage/mmap... no
-checking for nested class_device... yes
-checking for PnP suspend/resume... yes
-checking for new unlocked/compat_ioctl... yes
+checking for nested class_device... no
+checking for PnP suspend/resume... no
+checking for new unlocked/compat_ioctl... no
 checking for PC-Speaker hook... no
@@ -230,3 +229,2 @@
 config.status: creating include/config1.h
-config.status: include/config1.h is unchanged
 config.status: creating include/version.h
@@ -234,3 +232,2 @@
 config.status: creating include/autoconf-extra.h
-config.status: include/autoconf-extra.h is unchanged
 Hacking autoconf.h...

This leads to

  CC [M]  /builddir/alsa-driver-1.0.13/acore/hwdep.o
In file included from
/builddir/alsa-driver-1.0.13/include/sound/driver.h:46,
                 from
		 /builddir/alsa-driver-1.0.13/acore/hwdep.c:22:
/builddir/alsa-driver-1.0.13/include/adriver.h:742:
error: redefinition of 'jiffies_to_msecs'
include/linux/jiffies.h:253: error: previous definition of
'jiffies_to_msecs' was here

One thing I know is different is the absence of <linux/config.h>. I
tried commenting all includes to it, and the configure output changed
a bit, but still the same error. The following diff is both on FC6,
the second time w/o including <linux/config>.

@@ -171,9 +173,9 @@
 checking for Kernel ISA-PnP support... yes
-checking for strlcpy... no
-checking for snprintf... no
-checking for vsnprintf... no
-checking for scnprintf... no
-checking for sscanf... no
+checking for strlcpy... yes
+checking for snprintf... yes
+checking for vsnprintf... yes
+checking for scnprintf... yes
+checking for sscanf... yes
 checking for vmalloc_to_page... no
-checking for old kmod... yes
+checking for old kmod... no
 checking for PDE... no
@@ -189,3 +191,3 @@
 checking for kcalloc... no
-checking for kstrdup... no
+checking for kstrdup... yes
 checking for kzalloc... no

Thanks!
--=20
Axel.Thimm at ATrpms.net

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFOz/zQBVS1GOamfERArcGAJ0bljEXgDJmjAfs3IevkM0RdR4O/wCeICIt
V315/nB6pkRWwsYG2GPzv/Y=
=VdMa
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--


--===============2053460778==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============2053460778==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============2053460778==--
