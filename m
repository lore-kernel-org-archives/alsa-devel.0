From: =?iso-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: [PATCH] Add snd_seq_subscribe_set_voices()
Date: Sun, 12 May 2002 03:33:18 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020512033318.B16784@sci.fi>
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

I need this function for my MikMod driver.

Index: alsa-lib/include/seq.h
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/include/seq.h,v
retrieving revision 1.47
diff -u -r1.47 seq.h
--- alsa-lib/include/seq.h	17 Apr 2002 08:50:56 -0000	1.47
+++ alsa-lib/include/seq.h	12 May 2002 00:24:25 -0000
@@ -309,6 +309,7 @@
 void snd_seq_port_subscribe_set_sender(snd_seq_port_subscribe_t *info,
const snd_seq_addr_t *addr);
 void snd_seq_port_subscribe_set_dest(snd_seq_port_subscribe_t *info,
const snd_seq_addr_t *addr);
 void snd_seq_port_subscribe_set_queue(snd_seq_port_subscribe_t *info, int
q);
+void snd_seq_port_subscribe_set_voices(snd_seq_port_subscribe_t *info,
unsigned int voices);
 void snd_seq_port_subscribe_set_exclusive(snd_seq_port_subscribe_t *info,
int val);
 void snd_seq_port_subscribe_set_time_update(snd_seq_port_subscribe_t
*info, int val);
 void snd_seq_port_subscribe_set_time_real(snd_seq_port_subscribe_t *info,
int val);
Index: alsa-lib/src/seq/seq.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/seq/seq.c,v
retrieving revision 1.79
diff -u -r1.79 seq.c
--- alsa-lib/src/seq/seq.c	12 Mar 2002 20:14:34 -0000	1.79
+++ alsa-lib/src/seq/seq.c	12 May 2002 00:24:32 -0000
@@ -1456,6 +1456,17 @@
 }
 
 /**
+ * \brief Set the voices of a port_subscribe container
+ * \param info port_subscribe container
+ * \param voices voices to be allocated (0 = don't care)
+ */
+void snd_seq_port_subscribe_set_voices(snd_seq_port_subscribe_t *info,
unsigned int voices)
+{
+	assert(info);
+	info->voices = voices;
+}
+
+/**
  * \brief Set the exclusive mode of a port_subscribe container
  * \param info port_subscribe container
  * \param val non-zero to enable

-- 
Ville Syrjälä
syrjala@sci.fi
http://www.sci.fi/~syrjala/

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
