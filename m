From: =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: [PATCH] Interwave PCM name
Date: Sat, 11 May 2002 00:51:08 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020511005108.A16303@sci.fi>
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

I'm resending this since you didn't apply it from my previous patch.

Index: alsa-kernel/isa/gus/interwave.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/isa/gus/interwave.c,v
retrieving revision 1.11
diff -u -r1.11 interwave.c
--- alsa-kernel/isa/gus/interwave.c	18 Mar 2002 14:27:50 -0000
1.11
+++ alsa-kernel/isa/gus/interwave.c	10 May 2002 21:44:50 -0000
@@ -805,7 +805,7 @@
 		return err;
 	}
 	sprintf(pcm->name + strlen(pcm->name), " rev %c", gus->revision
+ 'A');
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
