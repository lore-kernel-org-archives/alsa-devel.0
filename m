From: Paul Davis <pbd@op.net>
Subject: midi kernel api question
Date: Mon, 6 May 2002 14:17:03 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205061817.g46IH3E04636@op.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from newmx1.fast.net (newmx1.fast.net [209.92.1.31])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id UAA01348
	for <alsa-devel@alsa-project.org>; Mon, 6 May 2002 20:16:54 +0200
Received: from unknown (HELO op.net) ([209.92.102.208]) (envelope-sender <pbd@op.net>)
          by newmx1.fast.net (qmail-ldap-1.03) with SMTP
          for <alsa-devel@alsa-project.org>; 6 May 2002 18:16:34 -0000
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

the h-dsp has 2 MIDI ports. they share an IRQ with the audio aspects
of the card.

is it intended/preferred that these are represented as 2 distinct
ports, or two substreams of the same port?

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
