From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: [PATCH] ALSA Support for Wolfson WM9703,5,8,9,10,11,12,17
Date: 05 May 2003 10:56:30 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1052128590.2980.17.camel@caernarfon>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: perex@suse.cz
Cc: ALSA Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi Jaroslav,

I've attached a patch for ALSA support of Wolfson AC97 codecs:- 

- removed broken wolfson00 patch.
- added support for WM9703,WM9705,WM9708,WM9709,WM9710,WM9711,WM9712 and
WM9717.


Index: pci/ac97/ac97_codec.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ac97/ac97_codec.c,v
retrieving revision 1.85
diff -u -r1.85 ac97_codec.c
--- pci/ac97/ac97_codec.c       11 Apr 2003 07:45:23 -0000      1.85
+++ pci/ac97/ac97_codec.c       5 May 2003 09:53:39 -0000
@@ -143,10 +143,12 @@
 { 0x54584e20, 0xffffffff, "TLC320AD9xC",       NULL,           NULL },
 { 0x56494161, 0xffffffff, "VIA1612A",          NULL,           NULL },
// modified ICE1232 with S/PDIF
 { 0x57454301, 0xffffffff, "W83971D",           NULL,           NULL },
-{ 0x574d4c00, 0xffffffff, "WM9701A",           patch_wolfson00,NULL },
-{ 0x574d4c03, 0xffffffff, "WM9703/9707",       patch_wolfson03,NULL },
-{ 0x574d4c04, 0xffffffff, "WM9704/quad",       patch_wolfson04,NULL },
-{ 0x574d4c05, 0xffffffff, "WM9705",            NULL,           NULL },
// patch?
+{ 0x574d4c00, 0xffffffff, "WM9701A",           NULL,   NULL },
+{ 0x574d4C03, 0xffffffff, "WM9703/WM9707/WM9708/WM9717",
patch_wolfson03, NULL},
+{ 0x574d4C04, 0xffffffff, "WM9704M/WM9704Q",   patch_wolfson04, NULL},
+{ 0x574d4C05, 0xffffffff, "WM9705/WM9710", patch_wolfson05, NULL},
+{ 0x574d4C09, 0xffffffff, "WM9709",    NULL,           NULL},
+{ 0x574d4C12, 0xffffffff, "WM9711/WM9712",  patch_wolfson11, NULL},
 { 0x594d4800, 0xffffffff, "YMF743",            NULL,           NULL },
 { 0x594d4802, 0xffffffff, "YMF752",            NULL,           NULL },
 { 0x594d4803, 0xffffffff, "YMF753",            patch_yamaha_ymf753,   
NULL },
Index: pci/ac97/ac97_patch.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ac97/ac97_patch.c,v
retrieving revision 1.11
diff -u -r1.11 ac97_patch.c
--- pci/ac97/ac97_patch.c       7 Apr 2003 15:26:27 -0000       1.11
+++ pci/ac97/ac97_patch.c       5 May 2003 09:53:39 -0000
@@ -51,55 +51,65 @@
        return 0;
 }
  
-int patch_wolfson00(ac97_t * ac97)
-{
-       /* This sequence is suspect because it was designed for
-          the WM9704, and is known to fail when applied to the
-          WM9707.  If you're having trouble initializing a
-          WM9700, this is the place to start looking.
-          Randolph Bentson <bentson@holmsjoen.com> */
-
-       // WM9701A
-       snd_ac97_write_cache(ac97, 0x72, 0x0808);
-       snd_ac97_write_cache(ac97, 0x74, 0x0808);
-
-       // patch for DVD noise
-       snd_ac97_write_cache(ac97, 0x5a, 0x0200);
-
-       // init vol
-       snd_ac97_write_cache(ac97, 0x70, 0x0808);
-
-       snd_ac97_write_cache(ac97, AC97_SURROUND_MASTER, 0x0000);
-       return 0;
-}
+/*
+ * May 2, 2003 Liam Girdwood <liam.girdwood@wolfsonmicro.com>
+ *  removed broken wolfson00 patch.
+ *  added support for WM9705,WM9708,WM9709,WM9710,WM9711,WM9712 and
WM9717.
+ */
+
+#define AC97_WM97XX_FMIXER_VOL 0x72
+#define AC97_WM9704_RMIXER_VOL 0x74
+#define AC97_WM9704_TEST 0x5a
+#define AC97_WM9704_RPCM_VOL 0x70
+#define AC97_WM9711_OUT3VOL 0x16
  
 int patch_wolfson03(ac97_t * ac97)
 {
        /* This is known to work for the ViewSonic ViewPad 1000
           Randolph Bentson <bentson@holmsjoen.com> */
  
-       // WM9703/9707
-       snd_ac97_write_cache(ac97, 0x72, 0x0808);
-       snd_ac97_write_cache(ac97, 0x20, 0x8000);
+       // WM9703/9707/9708/9717
+       snd_ac97_write_cache(ac97, AC97_WM97XX_FMIXER_VOL, 0x0808);
+       snd_ac97_write_cache(ac97, AC97_GENERAL_PURPOSE, 0x8000);
        return 0;
 }
  
 int patch_wolfson04(ac97_t * ac97)
 {
-       // WM9704
-       snd_ac97_write_cache(ac97, 0x72, 0x0808);
-       snd_ac97_write_cache(ac97, 0x74, 0x0808);
+       // WM9704M/9704Q
+       // set front and rear mixer volume
+       snd_ac97_write_cache(ac97, AC97_WM97XX_FMIXER_VOL, 0x0808);
+       snd_ac97_write_cache(ac97, AC97_WM9704_RMIXER_VOL, 0x0808);
  
        // patch for DVD noise
-       snd_ac97_write_cache(ac97, 0x5a, 0x0200);
+       snd_ac97_write_cache(ac97, AC97_WM9704_TEST, 0x0200);
  
        // init vol
-       snd_ac97_write_cache(ac97, 0x70, 0x0808);
+       snd_ac97_write_cache(ac97, AC97_WM9704_RPCM_VOL, 0x0808);
  
+       // set rear surround volume
        snd_ac97_write_cache(ac97, AC97_SURROUND_MASTER, 0x0000);
        return 0;
 }
  
+
+int patch_wolfson05(ac97_t * ac97)
+{
+       // WM9705, WM9710
+       // set front mixer volume
+       snd_ac97_write_cache(ac97, AC97_WM97XX_FMIXER_VOL, 0x0808);
+       return 0;
+}
+
+int patch_wolfson11(ac97_t * ac97)
+{
+       // WM9711, WM9712
+       // set out3 volume
+       snd_ac97_write_cache(ac97, AC97_WM9711_OUT3VOL, 0x0808);
+       return 0;
+}
+
+
 int patch_tritech_tr28028(ac97_t * ac97)
 {
        snd_ac97_write_cache(ac97, 0x26, 0x0300);
@@ -406,4 +416,3 @@
  
        return 0;
 }
-

Cheers

Liam

-- 
Liam Girdwood <liam.girdwood@wolfsonmicro.com>



Wolfson Microelectronics plc
http://www.wolfsonmicro.com
t: +44 131 272-7000
f: +44 131 272-7001
Registered in Scotland 89839

This message may contain confidential or proprietary information. If you receive this message in error, please
immediately delete it, destroy all copies of it and notify the sender. Any views expressed in this message are those of the individual sender,
except where the message states otherwise. We take reasonable precautions to ensure our Emails are virus free.
However, we cannot accept responsibility for any virus transmitted by us
and recommend that you subject any incoming Email to your own virus
checking procedures.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
