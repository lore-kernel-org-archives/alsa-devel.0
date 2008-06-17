From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: ALSA 1.0.17rc2 release
Date: Tue, 17 Jun 2008 13:42:40 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0806171341290.1798@tm8103-a.perex-int.cz>
References: <Pine.LNX.4.61.0806161121530.1798@tm8103-a.perex-int.cz>
	<200806171018.52879.gineera@aspect135.co.uk>
	<200806171116.27558.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-1463789724-2091289299-1213702960=:1798"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id D2D9C24759
	for <alsa-devel@alsa-project.org>;
	Tue, 17 Jun 2008 13:42:42 +0200 (CEST)
In-Reply-To: <200806171116.27558.gineera@aspect135.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alan Horstmann <gineera@aspect135.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463789724-2091289299-1213702960=:1798
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Tue, 17 Jun 2008, Alan Horstmann wrote:

> I have just confirmed that pasting
> 
> 	#define GFP_DMA32	((__force gfp_t)0x04u)
> 
> into /alsa-kernel/pci/emu10k1/memory.c (not a correct fix -just taken from 
> 2.6.24 headers) enables build to complete.  So there should be no other 
> hidden issues.

Could you try attached patch (also pasted bellow)?

				Thanks,
					Jaroslav


diff --git a/configure.in b/configure.in
index 1f24c7c..cf824be 100644
--- a/configure.in
+++ b/configure.in
@@ -2612,6 +2612,33 @@ if test "$CONFIG_HAVE_GFP_T" = "1"; then
   AC_DEFINE(CONFIG_HAVE_GFP_T)
 fi
 
+dnl Check for GFP_DMA32...
+AC_MSG_CHECKING(for GFP_DMA32)
+gfp_dma32="0"
+ac_save_CFLAGS="$CFLAGS"
+ac_save_CC="$CC"
+CFLAGS="$KERNEL_CHECK_CFLAGS"
+CC=$KCC
+AC_TRY_COMPILE([
+#define __KERNEL__
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/gfp.h>
+],[
+   int flags = GFP_DMA32;
+],
+    AC_MSG_RESULT(yes);gfp_dma32="1",
+    AC_MSG_RESULT(no);gfp_dma32="0",
+    AC_MSG_RESULT(unknown);gfp_dma32="0"
+)
+CFLAGS=$ac_save_CFLAGS
+CC=$ac_save_CC
+CONFIG_HAVE_GFP_DMA32=$gfp_dma32
+dnl AC_SUBST(CONFIG_HAVE_GFP_DMA32)
+if test "$CONFIG_HAVE_GFP_DMA32" = "1"; then
+  AC_DEFINE(CONFIG_HAVE_GFP_DMA32)
+fi
+
 dnl Check for init_utsname...
 if test "$kversion.$kpatchlevel" = "2.6" -a $ksublevel -ge 19; then
   CONFIG_HAVE_INIT_UTSNAME=1
diff --git a/include/adriver.h b/include/adriver.h
index 0c32d0d..3f5f8d6 100644
--- a/include/adriver.h
+++ b/include/adriver.h
@@ -274,6 +274,10 @@ static inline struct proc_dir_entry *PDE(const struct inode *inode)
 typedef unsigned __nocast gfp_t;
 #endif
 
+#ifndef CONFIG_HAVE_GFP_DMA32
+#define GFP_DMA32 GFP_DMA
+#endif
+
 #include <linux/wait.h>
 #ifndef wait_event_timeout
 #if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 0)
diff --git a/include/config.h.in b/include/config.h.in
index e5c4e02..23bee54 100644
--- a/include/config.h.in
+++ b/include/config.h.in
@@ -82,3 +82,4 @@
 #undef CONFIG_SND_HAS_DEVICE_CREATE_DRVDATA
 #undef CONFIG_HAVE_IS_POWER_OF_2
 #undef CONFIG_HAVE_DEPRECATED_CONFIG_H
+#undef CONFIG_HAVE_GFP_DMA32

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

---1463789724-2091289299-1213702960=:1798
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="a.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.61.0806171342400.1798@tm8103-a.perex-int.cz>
Content-Description: 
Content-Disposition: attachment; filename="a.patch"

ZGlmZiAtLWdpdCBhL2NvbmZpZ3VyZS5pbiBiL2NvbmZpZ3VyZS5pbg0KaW5k
ZXggMWYyNGM3Yy4uY2Y4MjRiZSAxMDA2NDQNCi0tLSBhL2NvbmZpZ3VyZS5p
bg0KKysrIGIvY29uZmlndXJlLmluDQpAQCAtMjYxMiw2ICsyNjEyLDMzIEBA
IGlmIHRlc3QgIiRDT05GSUdfSEFWRV9HRlBfVCIgPSAiMSI7IHRoZW4NCiAg
IEFDX0RFRklORShDT05GSUdfSEFWRV9HRlBfVCkNCiBmaQ0KIA0KK2RubCBD
aGVjayBmb3IgR0ZQX0RNQTMyLi4uDQorQUNfTVNHX0NIRUNLSU5HKGZvciBH
RlBfRE1BMzIpDQorZ2ZwX2RtYTMyPSIwIg0KK2FjX3NhdmVfQ0ZMQUdTPSIk
Q0ZMQUdTIg0KK2FjX3NhdmVfQ0M9IiRDQyINCitDRkxBR1M9IiRLRVJORUxf
Q0hFQ0tfQ0ZMQUdTIg0KK0NDPSRLQ0MNCitBQ19UUllfQ09NUElMRShbDQor
I2RlZmluZSBfX0tFUk5FTF9fDQorI2luY2x1ZGUgPGxpbnV4L2NvbmZpZy5o
Pg0KKyNpbmNsdWRlIDxsaW51eC90eXBlcy5oPg0KKyNpbmNsdWRlIDxsaW51
eC9nZnAuaD4NCitdLFsNCisgICBpbnQgZmxhZ3MgPSBHRlBfRE1BMzI7DQor
XSwNCisgICAgQUNfTVNHX1JFU1VMVCh5ZXMpO2dmcF9kbWEzMj0iMSIsDQor
ICAgIEFDX01TR19SRVNVTFQobm8pO2dmcF9kbWEzMj0iMCIsDQorICAgIEFD
X01TR19SRVNVTFQodW5rbm93bik7Z2ZwX2RtYTMyPSIwIg0KKykNCitDRkxB
R1M9JGFjX3NhdmVfQ0ZMQUdTDQorQ0M9JGFjX3NhdmVfQ0MNCitDT05GSUdf
SEFWRV9HRlBfRE1BMzI9JGdmcF9kbWEzMg0KK2RubCBBQ19TVUJTVChDT05G
SUdfSEFWRV9HRlBfRE1BMzIpDQoraWYgdGVzdCAiJENPTkZJR19IQVZFX0dG
UF9ETUEzMiIgPSAiMSI7IHRoZW4NCisgIEFDX0RFRklORShDT05GSUdfSEFW
RV9HRlBfRE1BMzIpDQorZmkNCisNCiBkbmwgQ2hlY2sgZm9yIGluaXRfdXRz
bmFtZS4uLg0KIGlmIHRlc3QgIiRrdmVyc2lvbi4ka3BhdGNobGV2ZWwiID0g
IjIuNiIgLWEgJGtzdWJsZXZlbCAtZ2UgMTk7IHRoZW4NCiAgIENPTkZJR19I
QVZFX0lOSVRfVVRTTkFNRT0xDQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9hZHJp
dmVyLmggYi9pbmNsdWRlL2Fkcml2ZXIuaA0KaW5kZXggMGMzMmQwZC4uM2Y1
ZjhkNiAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvYWRyaXZlci5oDQorKysgYi9p
bmNsdWRlL2Fkcml2ZXIuaA0KQEAgLTI3NCw2ICsyNzQsMTAgQEAgc3RhdGlj
IGlubGluZSBzdHJ1Y3QgcHJvY19kaXJfZW50cnkgKlBERShjb25zdCBzdHJ1
Y3QgaW5vZGUgKmlub2RlKQ0KIHR5cGVkZWYgdW5zaWduZWQgX19ub2Nhc3Qg
Z2ZwX3Q7DQogI2VuZGlmDQogDQorI2lmbmRlZiBDT05GSUdfSEFWRV9HRlBf
RE1BMzINCisjZGVmaW5lIEdGUF9ETUEzMiBHRlBfRE1BDQorI2VuZGlmDQor
DQogI2luY2x1ZGUgPGxpbnV4L3dhaXQuaD4NCiAjaWZuZGVmIHdhaXRfZXZl
bnRfdGltZW91dA0KICNpZiBMSU5VWF9WRVJTSU9OX0NPREUgPj0gS0VSTkVM
X1ZFUlNJT04oMiwgNiwgMCkNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2NvbmZp
Zy5oLmluIGIvaW5jbHVkZS9jb25maWcuaC5pbg0KaW5kZXggZTVjNGUwMi4u
MjNiZWU1NCAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvY29uZmlnLmguaW4NCisr
KyBiL2luY2x1ZGUvY29uZmlnLmguaW4NCkBAIC04MiwzICs4Miw0IEBADQog
I3VuZGVmIENPTkZJR19TTkRfSEFTX0RFVklDRV9DUkVBVEVfRFJWREFUQQ0K
ICN1bmRlZiBDT05GSUdfSEFWRV9JU19QT1dFUl9PRl8yDQogI3VuZGVmIENP
TkZJR19IQVZFX0RFUFJFQ0FURURfQ09ORklHX0gNCisjdW5kZWYgQ09ORklH
X0hBVkVfR0ZQX0RNQTMyDQo=

---1463789724-2091289299-1213702960=:1798
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

---1463789724-2091289299-1213702960=:1798--
