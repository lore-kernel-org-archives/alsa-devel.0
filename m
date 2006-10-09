From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Issue with Intel HDA Sound card
	82801G	(laptop	Medion)
Date: Mon, 09 Oct 2006 10:55:12 -0700
Message-ID: <1160416513.17297.135.camel@razman>
References: <1160262039.45283197cf7cd@imp5-g19.free.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-bOi65FDMp++a6wVanChI"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1160262039.45283197cf7cd@imp5-g19.free.fr>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: albox@free.fr
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-bOi65FDMp++a6wVanChI
Content-Type: multipart/alternative; boundary="=-rX+KtKSoRUDNhPcTiBPL"


--=-rX+KtKSoRUDNhPcTiBPL
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Here is a test patch.  Try it against a clean alsa-driver-1.0.13 tree
and let me know the results.  I based this on Remy's tarball from
Medion, using other Medion subvendor id configs as a basis.

If it doesn't work, could you also try the tarball that Remy posted last
weekend?  I'd be interested in knowing if that works.  If it does, I'd
like to see the output from dmesg with debug=detect enabled, along with
the /proc/asound/card0/codec#0 output.


-- 
Tobin Davis <tdavis@dsl-only.net>

--=-rX+KtKSoRUDNhPcTiBPL
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.6.2">
</HEAD>
<BODY>
Here is a test patch.&nbsp; Try it against a clean alsa-driver-1.0.13 tree and let me know the results.&nbsp; I based this on Remy's tarball from Medion, using other Medion subvendor id configs as a basis.<BR>
<BR>
If it doesn't work, could you also try the tarball that Remy posted last weekend?&nbsp; I'd be interested in knowing if that works.&nbsp; If it does, I'd like to see the output from dmesg with debug=detect enabled, along with the /proc/asound/card0/codec#0 output.<BR>
<BR>
<BR>
<TABLE CELLSPACING="0" CELLPADDING="0" WIDTH="100%">
<TR>
<TD>
-- <BR>
Tobin Davis &lt;<A HREF="mailto:tdavis@dsl-only.net">tdavis@dsl-only.net</A>&gt;
</TD>
</TR>
</TABLE>
</BODY>
</HTML>

--=-rX+KtKSoRUDNhPcTiBPL--

--=-bOi65FDMp++a6wVanChI
Content-Disposition: attachment; filename=medion-test.patch
Content-Type: text/x-patch; name=medion-test.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- alsa-driver/alsa-kernel/pci/hda/patch_realtek.c.orig	2006-10-08 10:58:28.000000000 -0700
+++ alsa-driver/alsa-kernel/pci/hda/patch_realtek.c	2006-10-09 10:50:03.000000000 -0700
@@ -112,6 +112,7 @@
 	ALC883_6ST_DIG,
 	ALC888_DEMO_BOARD,
 	ALC883_ACER,
+	ALC883_MEDION,
 	ALC883_AUTO,
 	ALC883_MODEL_LAST,
 };
@@ -5080,6 +5081,8 @@
 	  .config = ALC883_ACER },
 	{ .pci_subvendor = 0x1025, .pci_subdevice = 0x009f,
 	  .config = ALC883_ACER },
+	{ .pci_subvendor = 0x161f, .pci_subdevice = 0xd82b,
+	  .modelname = "medion", .config = ALC883_MEDION }
 	{ .modelname = "auto", .config = ALC883_AUTO },
 	{}
 };
@@ -5167,6 +5170,20 @@
 		.channel_mode = alc883_3ST_2ch_modes,
 		.input_mux = &alc883_capture_source,
 	},
+	[ALC883_MEDION] = {
+		.mixers = { alc883_base_mixer,
+			    alc883_chmode_mixer },
+		.init_verbs = { alc883_init_verbs,
+				alc882_eapd_verbs },
+		.num_dacs = ARRAY_SIZE(alc883_dac_nids),
+		.dac_nids = alc883_dac_nids,
+		.num_adc_nids = ARRAY_SIZE(alc883_adc_nids),
+		.adc_nids = alc883_adc_nids,
+		.num_channel_mode = ARRAY_SIZE(alc883_sixstack_modes),
+		.channel_mode = alc883_sixstack_modes,
+		.input_mux = &alc883_capture_source,
+	}
+
 };
 
 

--=-bOi65FDMp++a6wVanChI
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-bOi65FDMp++a6wVanChI
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-bOi65FDMp++a6wVanChI--
