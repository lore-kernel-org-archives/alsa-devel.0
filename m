From: Paul Davis <pbd@op.net>
Subject: hammerfall mem allocation planning
Date: Thu, 9 May 2002 10:47:42 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205091447.g49Elge01888@op.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from newmx1.fast.net (newmx1.fast.net [209.92.1.31])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id QAA28093
	for <alsa-devel@alsa-project.org>; Thu, 9 May 2002 16:47:16 +0200
Received: from unknown (HELO op.net) ([209.92.231.85]) (envelope-sender <pbd@op.net>)
          by newmx1.fast.net (qmail-ldap-1.03) with SMTP
          for <alsa-devel@alsa-project.org>; 9 May 2002 14:47:13 -0000
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

i changed from the plan i outlined (that recent email was delayed
from last night)

i've put the h-dsp driver into the same directory as the rme9652
driver, since they have to share the memory allocation module. the
mem module is renamed (i've fixed alsasound to know about it too).

this seems much cleaner to me. it might even be possible to share some
code between the two drivers this way, at some point.

jaroslav et alia - let me know if you have objections to this structure.

for those who care, the driver is in a strange state. it basically
works - you can record with it, play with the control settings, check
the level meters, etc. what you can't do is get any sound out of the
thing, even in passthru mode :(

--p

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
