From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [patch] alsa-lib pcm-doc typo fixes
Date: Wed, 8 Dec 2004 19:31:28 +0300
Message-ID: <200412081930.50484.kirr@mns.spb.ru>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_gxytBo6vc4VzD5H"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.mns.spb.ru (mns.spb.ru [195.131.16.6])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 3A5E23C2
	for <alsa-devel@alsa-project.org>; Wed,  8 Dec 2004 17:32:46 +0100 (MET)
Received: from [192.168.0.127] (helo=tugrik.volcano)
	by mail.mns.spb.ru with esmtp id 1Cc4k8-00066y-HV
	for <alsa-devel@alsa-project.org>; Wed, 08 Dec 2004 19:32:44 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_gxytBo6vc4VzD5H
Content-Type: text/plain;
  charset="koi8-r"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

While reading alsa-lib pcm documentation i've descovered a few typos and =
an=20
ambiguity in snd_pcm_wait description.

trivial patch attached.

--=20
    =EB=C9=D2=C9=CC=CC =F3=CD=C5=CC=CB=CF=D7




--Boundary-00=_gxytBo6vc4VzD5H
Content-Type: text/x-diff;
  charset="us-ascii";
  name="alsa-lib-pcm-doc-tweaks.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="alsa-lib-pcm-doc-tweaks.patch"

Index: alsa-lib/src/pcm/pcm.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/pcm/pcm.c,v
retrieving revision 1.290
diff -u -r1.290 pcm.c
--- alsa-lib/src/pcm/pcm.c	12 Nov 2004 20:27:31 -0000	1.290
+++ alsa-lib/src/pcm/pcm.c	8 Dec 2004 16:20:52 -0000
@@ -171,7 +171,7 @@
 \par SND_PCM_STATE_XRUN
 The PCM device reached overrun (capture) or underrun (playback).
 You can use the -EPIPE return code from I/O functions
-(#snd_pcm_writei(), #snd_pcm_writen(), #snd_pcm_readi(), #snd_pcm_readi())
+(#snd_pcm_writei(), #snd_pcm_writen(), #snd_pcm_readi(), #snd_pcm_readn())
 to determine this state without checking
 the actual state via #snd_pcm_state() call. You can recover from
 this state with #snd_pcm_prepare(),
@@ -231,7 +231,7 @@
 #SND_PCM_ACCESS_RW_NONINTERLEAVED access method) at input. There are these
 functions for interleaved transfers: #snd_pcm_writei()
 #snd_pcm_readi(). For non-interleaved transfers, there are
-these functions: #snd_pcm_writen(0 and #snd_pcm_readn().
+these functions: #snd_pcm_writen() and #snd_pcm_readn().
 
 \subsection alsa_mmap_rw Direct Read / Write transfer (via mmap'ed areas)
 
@@ -402,7 +402,7 @@
 
 \section pcm_action Managing the stream state
 
-These functions directly and indirectly affecting the stream state:
+The following functions directly and indirectly affect the stream state:
 
 \par snd_pcm_hw_params
 The #snd_pcm_hw_params() function brings the stream state
@@ -472,9 +472,11 @@
 The default device is equal to plug plugin with hw plugin as slave. The defaults are
 used:
 
+\code
 defaults.pcm.card 0
 defaults.pcm.device 0
 defaults.pcm.subdevice -1
+\endcode
 
 These defaults can be freely overwritten in local configuration files.
 
@@ -2067,7 +2069,8 @@
 /**
  * \brief Wait for a PCM to become ready
  * \param pcm PCM handle
- * \param timeout maximum time in milliseconds to wait
+ * \param timeout maximum time in milliseconds to wait,
+ *        a negative value means infinity
  * \return a positive value on success otherwise a negative error code
  *         (-EPIPE for the xrun and -ESTRPIPE for the suspended status,
  *          others for general errors) 

--Boundary-00=_gxytBo6vc4VzD5H--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
