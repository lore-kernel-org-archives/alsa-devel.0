From: =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: [PATCH] GUS PCM fixes
Date: Fri, 10 May 2002 04:20:42 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020510042042.A8147@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: perex@suse.cz
List-Id: alsa-devel@alsa-project.org

Here's a fix for gus pcm rate limits and interwave pcm name.

Index: alsa-kernel/isa/gus/gus_pcm.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/isa/gus/gus_pcm.c,v
retrieving revision 1.8
diff -u -r1.8 gus_pcm.c
--- alsa-kernel/isa/gus/gus_pcm.c	18 Feb 2002 13:21:15 -0000
1.8
+++ alsa-kernel/isa/gus/gus_pcm.c	10 May 2002 01:13:43 -0000
@@ -38,7 +38,7 @@
 
 /* maximum rate */
 
-#define SNDRV_GF1_PCM_RATE		48000
+#define SNDRV_GF1_PCM_RATE		44100
 
 #define SNDRV_GF1_PCM_PFLG_NONE		0
 #define SNDRV_GF1_PCM_PFLG_ACTIVE	(1<<0)
@@ -624,7 +624,7 @@
 				 SNDRV_PCM_FMTBIT_S16_LE |
SNDRV_PCM_FMTBIT_U16_LE),
 	rates:			SNDRV_PCM_RATE_CONTINUOUS |
SNDRV_PCM_RATE_8000_44100,
 	rate_min:		5510,
-	rate_max:		48000,
+	rate_max:		44100,
 	channels_min:		1,
 	channels_max:		2,
 	buffer_bytes_max:	(128*1024),
Index: alsa-kernel/isa/gus/interwave.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/isa/gus/interwave.c,v
retrieving revision 1.11
diff -u -r1.11 interwave.c
--- alsa-kernel/isa/gus/interwave.c	18 Mar 2002 14:27:50 -0000
1.11
+++ alsa-kernel/isa/gus/interwave.c	10 May 2002 01:13:44 -0000
@@ -805,7 +805,7 @@
 		return err;
 	}
 	sprintf(pcm->name + strlen(pcm->name), " rev %c", gus->revision +
'A');
-	strcat(pcm->name, " (chip)");
+	strcat(pcm->name, " (codec)");
 	if ((err = snd_cs4231_timer(cs4231, 2, NULL)) < 0) {
 		snd_card_free(card);
 		return err;

-- 
Ville Syrjälä
syrjala@sci.fi
http://www.sci.fi/~syrjala/

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
