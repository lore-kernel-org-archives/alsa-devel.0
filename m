From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] fix alsa-lib doxygen errors
Date: Mon, 01 Mar 2004 18:35:09 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0403011834010.5532-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


fix alsa-lib doxygen errors


Index: alsa-lib/doc/doxygen.cfg
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/doc/doxygen.cfg,v
retrieving revision 1.25
diff -u -r1.25 doxygen.cfg
--- alsa-lib/doc/doxygen.cfg	8 Jan 2004 14:05:55 -0000	1.25
+++ alsa-lib/doc/doxygen.cfg	1 Mar 2004 16:36:01 -0000
@@ -94,7 +94,13 @@
 JAVADOC_AUTOBRIEF = NO
 INHERIT_DOCS	 = YES
 ENABLED_SECTIONS = ""
-PREDEFINED	 = DOXYGEN PIC "DOC_HIDDEN" "ATTRIBUTE_UNUSED=" ALSA_PCM_NEW_HW_PARAMS_API
+MACRO_EXPANSION  = YES
+EXPAND_ONLY_PREDEF = YES
+PREDEFINED	 = DOXYGEN PIC "DOC_HIDDEN" \
+		   "ATTRIBUTE_UNUSED=" \
+		   ALSA_PCM_NEW_HW_PARAMS_API \
+		   "use_default_symbol_version(x,y,z)=" \
+		   "link_warning(x,y)="

 OPTIMIZE_OUTPUT_FOR_C = YES	# doxygen 1.2.6 option

Index: alsa-lib/src/pcm/pcm.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/pcm/pcm.c,v
retrieving revision 1.272
diff -u -r1.272 pcm.c
--- alsa-lib/src/pcm/pcm.c	1 Mar 2004 08:53:50 -0000	1.272
+++ alsa-lib/src/pcm/pcm.c	1 Mar 2004 16:36:02 -0000
@@ -314,7 +314,7 @@

 The timestamp mode specifies, if timestamps are activated. Currently, only
 #SND_PCM_TSTAMP_NONE and #SND_PCM_TSTAMP_MMAP
-\endlink modes are known. The mmap mode means that timestamp is taken
+modes are known. The mmap mode means that timestamp is taken
 on every period time boundary.

 \par Minimal sleep
@@ -408,7 +408,7 @@
 The #snd_pcm_hw_params() function brings the stream state
 to #SND_PCM_STATE_SETUP
 if successfully finishes, otherwise the state #SND_PCM_STATE_OPEN
-\endlink is entered.
+is entered.
 When it is brought to SETUP state, this function automatically
 calls #snd_pcm_prepar() function to bring to the PREPARE state
 as below.
@@ -1221,7 +1221,7 @@
  * \link ::snd_pcm_poll_descriptors_count() \endlink function.
  *
  * For reading the returned events of poll descriptor after poll() system
- * call, use \link ::snd_pcm_poll_descriptors_revent() \endlink function.
+ * call, use \link ::snd_pcm_poll_descriptors_revents() \endlink function.
  * The field values in pollfd structs may be bogus.
  */
 int snd_pcm_poll_descriptors(snd_pcm_t *pcm, struct pollfd *pfds, unsigned int space)
Index: alsa-lib/src/pcm/pcm_dsnoop.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/pcm/pcm_dsnoop.c,v
retrieving revision 1.16
diff -u -r1.16 pcm_dsnoop.c
--- alsa-lib/src/pcm/pcm_dsnoop.c	3 Feb 2004 14:44:48 -0000	1.16
+++ alsa-lib/src/pcm/pcm_dsnoop.c	1 Mar 2004 16:36:03 -0000
@@ -663,7 +663,7 @@

 /*! \page pcm_plugins

-\section pcm_plugins_snoop Plugin: dsnoop
+\section pcm_plugins_dsnoop Plugin: dsnoop

 This plugin splits one capture stream to more.
 It works the reverse way of \ref pcm_plugins_dmix "dmix plugin",
Index: alsa-lib/src/seq/seq.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/seq/seq.c,v
retrieving revision 1.87
diff -u -r1.87 seq.c
--- alsa-lib/src/seq/seq.c	22 Oct 2003 14:25:55 -0000	1.87
+++ alsa-lib/src/seq/seq.c	1 Mar 2004 16:36:03 -0000
@@ -77,7 +77,7 @@
 but in general it is nothing but the access point between other clients.
 Each port may have capability flags, which specify the read/write
 accessbility and subscription permissions of the port.
-For creation of a port, call #snd_seq_create_port() \endlink
+For creation of a port, call #snd_seq_create_port()
 with the appropirate port attribute specified in #snd_seq_port_info_t
 reocrd.





-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
