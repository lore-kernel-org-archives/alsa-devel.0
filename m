From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] ev->type not set for encoded sysex
Date: Fri, 10 May 2002 12:57:29 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CDBA799.7038A4D1@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate.uni-halle.de (mlucom8.urz.Uni-Halle.DE [141.48.10.118] (may be forged))
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id MAA12332
	for <alsa-devel@alsa-project.org>; Fri, 10 May 2002 12:57:52 +0200
Received: from mserv1.urz.uni-halle.de ([141.48.3.145] helo=mserv1)
	  by mailgate.uni-halle.de with esmtp (EXIM Version 3.35)
	  for <alsa-devel@alsa-project.org>
	  id 17685d-0002Ia-00; Fri, 10 May 2002 12:57:33 +0200
Received: from conversion-daemon.mail.uni-halle.de by mail.uni-halle.de
 (iPlanet Messaging Server 5.2 (built Feb 21 2002))
 id <0GVW002015C121@mail.uni-halle.de> for alsa-devel@alsa-project.org; Fri,
 10 May 2002 12:57:33 +0200 (MEST)
Received: from studcom.urz.uni-halle.de
 (studcom.urz.Uni-Halle.DE [141.48.3.19]) by mail.uni-halle.de
 (iPlanet Messaging Server 5.2 (built Feb 21 2002))
 with ESMTP id <0GVW000LT6FXQ1@mail.uni-halle.de> for
 alsa-devel@alsa-project.org; Fri, 10 May 2002 12:57:33 +0200 (MEST)
Received: from ladisch.de (ifiu23.informatik.Uni-Halle.DE [141.48.14.23])
	by studcom.urz.uni-halle.de (8.9.3 (PHNE_22672)/8.9.3)
 with ESMTP id MAA23883	for <alsa-devel@alsa-project.org>; Fri,
 10 May 2002 12:57:29 +0200 (METDST)
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


The equivalent change to the kernel implementation (rev. 1.22 in the
old alsa-driver) never got applied to alsa-lib.


Index: seq_midi_event.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/seq/seq_midi_event.c,v
retrieving revision 1.14
diff -u -r1.14 seq_midi_event.c
--- seq_midi_event.c    19 Apr 2002 17:34:57 -0000      1.14
+++ seq_midi_event.c    10 May 2002 10:26:14 -0000
@@ -337,6 +337,7 @@
                    dev->read >= dev->bufsize) {
                        ev->flags &= ~SNDRV_SEQ_EVENT_LENGTH_MASK;
                        ev->flags |= SNDRV_SEQ_EVENT_LENGTH_VARIABLE;
+                       ev->type = SND_SEQ_EVENT_SYSEX;
                        ev->data.ext.len = dev->read;
                        ev->data.ext.ptr = dev->buf;
                        if (c != MIDI_CMD_COMMON_SYSEX_END)

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
