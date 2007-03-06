From: "Joachim Deguara" <joachim.deguara@amd.com>
Subject: [PATCH] hda empty modelname comparison
Date: Tue, 06 Mar 2007 15:59:10 +0100
Message-ID: <45ED81BE.4080606@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary=------------020104080005080509020604
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

This is a multi-part message in MIME format.
--------------020104080005080509020604
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

This patch prevents a comparison between a possibly empty modelname
string in the hda code.

-Joachim

--------------020104080005080509020604
Content-Type: text/x-patch;
 name=hda_empty_modelname_comparison.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename=hda_empty_modelname_comparison.patch

Only in alsa-kernel/include: version.h
diff -rup /mnt/alsa/alsa-kernel/pci/hda/hda_codec.c alsa-kernel/pci/hda/hda_codec.c
--- /mnt/alsa/alsa-kernel/pci/hda/hda_codec.c	2007-03-01 14:50:24.000000000 +0100
+++ alsa-kernel/pci/hda/hda_codec.c	2007-03-06 15:37:03.000000000 +0100
@@ -573,7 +573,7 @@ int snd_hda_codec_new(struct hda_bus *bu
 							 0);
 	}
 
-	if (strcmp(codec->bus->modelname, "generic"))
+	if ( codec->bus->modelname && strcmp(codec->bus->modelname, "generic"))
 		codec->preset = find_codec_preset(codec);
 	if (! *bus->card->mixername)
 		snd_hda_get_codec_name(codec, bus->card->mixername,
Only in alsa-kernel/pci/hda: .hda_codec.c.swp

--------------020104080005080509020604
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------020104080005080509020604
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--------------020104080005080509020604--
