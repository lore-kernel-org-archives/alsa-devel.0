From: asd <asd@marian1000.go.ro>
Subject: On HD codec valid command working only on hwdep
	hda-verb and embedded on function snd_hda_multi_out_analog_open
Date: Sat, 07 Jun 2014 13:10:20 +0300
Message-ID: <2900340.PkFpOr51gc@marian1000.go.ro>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart2548077.fLWg0B4XBu"
Content-Transfer-Encoding: 7Bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from marian1000.go.ro (5-14-228-204.residential.rdsnet.ro
 [5.14.228.204]) by alsa0.perex.cz (Postfix) with ESMTP id F1E742619FB
 for <Alsa-devel@alsa-project.org>; Sat,  7 Jun 2014 12:10:21 +0200 (CEST)
Received: from localhost ([127.0.0.1] helo=marian1000.go.ro)
 by marian1000.go.ro with esmtp (Exim 4.82)
 (envelope-from <asd@marian1000.go.ro>) id 1WtDZs-0000ui-SX
 for Alsa-devel@alsa-project.org; Sat, 07 Jun 2014 13:10:20 +0300
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

--nextPart2548077.fLWg0B4XBu
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi

On patch_realtek can't run snd_hda_write.Only situations when run 
snd_hda_write is to run inside off snd_hda_multi_out_analog_open function 
(suppose to when sream is on codec is weak up and become online.
--nextPart2548077.fLWg0B4XBu
Content-Disposition: attachment; filename="set_param.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="set_param.patch"

Index: hda/hda_codec.c
===================================================================
--- hda.orig/hda_codec.c	2014-06-07 12:38:24.000000000 +0300
+++ hda/hda_codec.c	2014-06-07 12:51:16.173510291 +0300
@@ -5420,6 +5420,8 @@
 		}
 		mutex_unlock(&codec->spdif_mutex);
 	}
+	snd_hda_codec_write(codec, 0x14, 0,
+		AC_VERB_SET_PIN_WIDGET_CONTROL, 0xc0);
 	return snd_pcm_hw_constraint_step(substream->runtime, 0,
 					  SNDRV_PCM_HW_PARAM_CHANNELS, 2);
 }

--nextPart2548077.fLWg0B4XBu
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--nextPart2548077.fLWg0B4XBu--
