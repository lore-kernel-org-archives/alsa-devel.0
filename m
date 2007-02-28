From: Nicolas GRAZIANO <nicolas.graziano@wanadoo.fr>
Subject: [PATCH] model name can be null in hda-intel
Date: Thu, 01 Mar 2007 00:19:31 +0100
Message-ID: <45E60E03.3090309@wanadoo.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080002030607090803080605"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from smtp6-g19.free.fr (smtp6-g19.free.fr [212.27.42.36])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id AA16C398
	for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2007 00:19:33 +0100 (MET)
Received: from grazy.hd.free.fr (rob92-2-82-66-38-107.fbx.proxad.net
	[82.66.38.107])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 586AD496F
	for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2007 00:19:33 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1])
	by grazy.hd.free.fr with esmtp (Exim 4.63)
	(envelope-from <nicolas.graziano@wanadoo.fr>) id 1HMY56-0001oM-Ew
	for alsa-devel@alsa-project.org; Thu, 01 Mar 2007 00:19:32 +0100
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080002030607090803080605
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

This patch fix a bug when no model is set in hda-intel module parameters.
Introduce by model "generic"

Signed-off-by: Nicolas Graziano <nicolas.graziano@wanadoo.fr>



--------------080002030607090803080605
Content-Type: text/x-patch;
 name="modelNameCanBeNull.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="modelNameCanBeNull.patch"

diff -r bf193701a812 pci/hda/hda_codec.c
--- a/pci/hda/hda_codec.c	Mon Feb 26 16:07:42 2007 +0100
+++ b/pci/hda/hda_codec.c	Thu Mar 01 00:06:57 2007 +0100
@@ -573,7 +573,7 @@ int snd_hda_codec_new(struct hda_bus *bu
 							 0);
 	}
 
-	if (strcmp(codec->bus->modelname, "generic"))
+	if (! codec->bus->modelname || strcmp(codec->bus->modelname, "generic"))
 		codec->preset = find_codec_preset(codec);
 	if (! *bus->card->mixername)
 		snd_hda_get_codec_name(codec, bus->card->mixername,

--------------080002030607090803080605
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------080002030607090803080605
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--------------080002030607090803080605--
