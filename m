From: =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: [PATCH] GUS module usage count
Date: Fri, 10 May 2002 04:25:02 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020510042502.B8147@sci.fi>
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

I was unable to unload some of the gus modules. Here's my fix. I hope it's
correct.

Index: alsa-kernel/isa/gus/gus_synth.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/isa/gus/gus_synth.c,v
retrieving revision 1.5
diff -u -r1.5 gus_synth.c
--- alsa-kernel/isa/gus/gus_synth.c	14 Feb 2002 17:40:32 -0000
1.5
+++ alsa-kernel/isa/gus/gus_synth.c	10 May 2002 01:20:40 -0000
@@ -66,6 +66,7 @@
 		voice = snd_gf1_alloc_voice(gus,
SNDRV_GF1_VOICE_TYPE_SYNTH, info->sender.client, info->sender.port);
 		if (voice == NULL) {
 			snd_gus_synth_free_voices(gus,
info->sender.client, info->sender.port);
+			snd_gus_use_dec(gus);
 			up(&gus->register_mutex);
 			return -EBUSY;
 		}
@@ -82,6 +83,7 @@
 
 	down(&gus->register_mutex);
 	snd_gus_synth_free_voices(gus, info->sender.client,
info->sender.port);
+	snd_gus_use_dec(gus);
 	up(&gus->register_mutex);
 	return 0;
 }

-- 
Ville Syrjälä
syrjala@sci.fi
http://www.sci.fi/~syrjala/

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
