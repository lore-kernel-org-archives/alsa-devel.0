From: Paul Davis <pbd@op.net>
Subject: patch to get hdsp recognized as a card
Date: Wed, 15 May 2002 23:12:49 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205160312.g4G3Cn413115@op.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from post2.fast.net (post2.fast.net [209.92.1.22])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id FAA25376
	for <alsa-devel@alsa-project.org>; Thu, 16 May 2002 05:12:21 +0200
Received: from op.net (maxtnt02-113.phlpa.fast.net [209.92.227.113])
	by post2.fast.net (8.11.2/8.9.3) with ESMTP id g4G3CET21901
	for <alsa-devel@alsa-project.org>; Wed, 15 May 2002 23:12:15 -0400 (EDT)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I don't know how to force this change to cause a rebuild of
acinclude.m4, but when that happens (e.g. c/o cvscompile), "hdsp"
becomes a valid card option.

The problem with missing symbols does not go away, however.

--p


Index: Modules.dep
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/scripts/Modules.dep,v
retrieving revision 1.13
diff -u -r1.13 Modules.dep
--- Modules.dep 17 Apr 2002 07:48:53 -0000      1.13
+++ Modules.dep 16 May 2002 03:10:50 -0000
@@ -184,8 +184,9 @@
 |snd-nm256 snd-pcm snd-ac97-codec
 
 %dir linux/sound/pci/rme9652
-snd-rme9652-mem
-|snd-rme9652 snd-pcm snd-rme9652-mem
+snd-hammerfall-mem
+|snd-rme9652 snd-pcm snd-hammerfall-mem
+|snd-hdsp snd-pcm snd-hammerfall-mem
 
 %dir linux/sound/pci/trident
 snd-trident-synth @if_sequencer snd-seq-midi-emul snd-ainstr-simple

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
