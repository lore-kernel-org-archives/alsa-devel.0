From: asd <asd@marian1000.go.ro>
Subject: This patch is for hearing sound separate on channels
Date: Sun, 18 May 2014 19:59:44 +0300
Message-ID: <1645296.iOC1z10K5Z@marian1000.go.ro>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7599966270745004541=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from marian1000.go.ro (5-14-228-197.residential.rdsnet.ro
 [5.14.228.197]) by alsa0.perex.cz (Postfix) with ESMTP id 29A89265004
 for <alsa-devel@alsa-project.org>; Sun, 18 May 2014 18:59:47 +0200 (CEST)
Received: from localhost ([127.0.0.1] helo=marian1000.go.ro)
 by marian1000.go.ro with esmtp (Exim 4.82)
 (envelope-from <asd@marian1000.go.ro>) id 1Wm4R6-0000vw-Gt
 for alsa-devel@alsa-project.org; Sun, 18 May 2014 19:59:44 +0300
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

--===============7599966270745004541==
Content-Type: text/x-patch; charset="UTF-8"; name="test.patch"
Content-Transfer-Encoding: 7Bit
Content-Disposition: attachment; filename="test.patch"

--- a/hda_codec.c
+++ b/hda_codec.c
@@ -5375,6 +5375,7 @@
 	int chs = substream->runtime->channels;
 	struct hda_spdif_out *spdif;
 	int i;
+	//mout->no_share_stream = 1;
 	mout->no_share_stream = 1;
 
 	mutex_lock(&codec->spdif_mutex);

--===============7599966270745004541==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7599966270745004541==--
