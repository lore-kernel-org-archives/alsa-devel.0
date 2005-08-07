From: Philip Prindeville <philipp_subx@redfish-solutions.com>
Subject: Fixes for identifying VT1617 codec and MSI-7142 mobo
Date: Sun, 07 Aug 2005 12:41:38 -0600
Message-ID: <42F655E2.5040504@redfish-solutions.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010607050607040807090702"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.redfish-solutions.com (mail.redfish-solutions.com [71.36.29.88])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 63A931D7
	for <alsa-devel@alsa-project.org>; Sun,  7 Aug 2005 20:41:40 +0200 (MEST)
Received: from [192.168.1.5] ([192.168.1.5])
	(authenticated bits=0)
	by mail.redfish-solutions.com (8.13.1/8.13.1) with ESMTP id j77Ifc8N008426
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <alsa-devel@alsa-project.org>; Sun, 7 Aug 2005 12:41:38 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------010607050607040807090702
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi.

Can we please commit this minor fixes to the tree?  I've been
using them and they seem to work fine.

Thanks,

-Philip


--------------010607050607040807090702
Content-Type: text/x-patch;
 name="vt1617.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vt1617.patch"

*** alsa-kernel/pci/via82xx.c.bak	2005-05-27 04:10:18.000000000 -0600
--- alsa-kernel/pci/via82xx.c	2005-07-25 20:33:51.000000000 -0600
***************
*** 2174,2179 ****
--- 2174,2180 ----
  		{ .vendor = 0x1462, .device = 0x5901, .action = VIA_DXS_NO_VRA }, /* MSI KT6 Delta-SR */
  		{ .vendor = 0x1462, .device = 0x7023, .action = VIA_DXS_NO_VRA }, /* MSI K8T Neo2-FI */
  		{ .vendor = 0x1462, .device = 0x7120, .action = VIA_DXS_ENABLE }, /* MSI KT4V */
+ 		{ .vendor = 0x1462, .device = 0x7142, .action = VIA_DXS_ENABLE }, /* MSI K8MM-V */
  		{ .vendor = 0x147b, .device = 0x1401, .action = VIA_DXS_ENABLE }, /* ABIT KD7(-RAID) */
  		{ .vendor = 0x147b, .device = 0x1411, .action = VIA_DXS_ENABLE }, /* ABIT VA-20 */
  		{ .vendor = 0x147b, .device = 0x1413, .action = VIA_DXS_ENABLE }, /* ABIT KV8 Pro */
*** alsa-kernel/pci/ac97/ac97_codec.c.bak	2005-04-25 04:22:20.000000000 -0600
--- alsa-kernel/pci/ac97/ac97_codec.c	2005-07-29 21:46:21.000000000 -0600
***************
*** 157,162 ****
--- 157,163 ----
  { 0x54524123, 0xffffffff, "TR28602",		NULL,		NULL }, // only guess --jk [TR28023 = eMicro EM28023 (new CT1297)]
  { 0x54584e20, 0xffffffff, "TLC320AD9xC",	NULL,		NULL },
  { 0x56494161, 0xffffffff, "VIA1612A",		NULL,		NULL }, // modified ICE1232 with S/PDIF
+ { 0x56494170, 0xffffffff, "VIA1617A",		patch_vt1617a,	NULL }, // modified VT1616 with S/PDIF
  { 0x57454301, 0xffffffff, "W83971D",		NULL,		NULL },
  { 0x574d4c00, 0xffffffff, "WM9701A",		NULL,		NULL },
  { 0x574d4C03, 0xffffffff, "WM9703,WM9707,WM9708,WM9717", patch_wolfson03, NULL},
*** alsa-kernel/pci/ac97/ac97_patch.c.bak	2005-05-27 03:42:45.000000000 -0600
--- alsa-kernel/pci/ac97/ac97_patch.c	2005-07-29 22:55:50.000000000 -0600
***************
*** 558,563 ****
--- 558,573 ----
  }
  
  /*
+  * VT1617A codec
+  */
+ int patch_vt1617a(ac97_t * ac97)
+ {
+ 	ac97->ext_id |= AC97_EI_SPDIF;	/* force the detection of spdif */
+ 	ac97->rates[AC97_RATES_SPDIF] = SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000;
+ 	return 0;
+ }
+ 
+ /*
   * Sigmatel STAC97xx codecs
   */
  static int patch_sigmatel_stac9700_3d(ac97_t * ac97)
*** alsa-kernel/pci/ac97/ac97_patch.h.bak	2005-04-07 08:53:20.000000000 -0600
--- alsa-kernel/pci/ac97/ac97_patch.h	2005-07-29 21:43:28.000000000 -0600
***************
*** 56,60 ****
--- 56,61 ----
  int patch_cm9761(ac97_t * ac97);
  int patch_cm9780(ac97_t * ac97);
  int patch_vt1616(ac97_t * ac97);
+ int patch_vt1617a(ac97_t * ac97);
  int patch_it2646(ac97_t * ac97);
  int mpatch_si3036(ac97_t * ac97);

--------------010607050607040807090702--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
