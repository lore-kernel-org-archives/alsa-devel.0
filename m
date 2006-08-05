From: Giorgio Padrin <giorgio@mandarinlogiq.org>
Subject: [PATCH] pxa2xx-i2sound
Date: Sat, 5 Aug 2006 19:37:13 +0200
Message-ID: <200608051937.13845.giorgio@mandarinlogiq.org>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_JdN1EtBcpEtHGH4"
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
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>
Cc: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_JdN1EtBcpEtHGH4
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

This is minimal patch updating the pxa2xx-i2sound code in alsa-driver.

Giorgio

--Boundary-00=_JdN1EtBcpEtHGH4
Content-Type: text/x-diff; charset="utf-8";
	name="pxa2xx-i2sound-20060805.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="pxa2xx-i2sound-20060805.patch"

diff -up a/arm/pxa2xx-i2sound.c b/arm/pxa2xx-i2sound.c
--- a/arm/pxa2xx-i2sound.c	2006-08-05 17:13:43.000000000 +0200
+++ b/arm/pxa2xx-i2sound.c	2006-05-04 14:33:35.000000000 +0200
@@ -730,9 +730,7 @@ static int snd_pxa2xx_i2sound_card_creat
 			continue;
 		s = &card.engine.streams[s_id];
 		s->id = s_id;
-		s->ahw.info		= SNDRV_PCM_INFO_MMAP |
-					  SNDRV_PCM_INFO_INTERLEAVED |
-					  SNDRV_PCM_INFO_MMAP_VALID |
+		s->ahw.info		= SNDRV_PCM_INFO_INTERLEAVED |
 					  SNDRV_PCM_INFO_BLOCK_TRANSFER;
 		s->ahw.formats		= SNDRV_PCM_FMTBIT_S16_LE;
 		s->ahw.channels_min		= 2;

--Boundary-00=_JdN1EtBcpEtHGH4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--Boundary-00=_JdN1EtBcpEtHGH4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--Boundary-00=_JdN1EtBcpEtHGH4--
