From: Paul Davis <pbd@op.net>
Subject: generic mixer control?
Date: Fri, 13 Sep 2002 09:19:12 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200209131319.g8DDJCk13884@op.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from newmx2.fast.net (newmx2.fast.net [209.92.1.32])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id PAA20824
	for <alsa-devel@alsa-project.org>; Fri, 13 Sep 2002 15:15:38 +0200
Received: from unknown (HELO op.net) ([209.92.228.5]) (envelope-sender <pbd@op.net>)
          by newmx2.fast.net (qmail-ldap-1.03) with SMTP
          for <alsa-devel@alsa-project.org>; 13 Sep 2002 13:15:29 -0000
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

i don't enough about ALSA's handling of consumer mixers to know if
this is possible, but ... i was wondering if there is anyway to write
a generic chunk of code for JACK that manipulates a consumer-oriented
card's mixer to provide hardware mixing. the basic process would be to
turn up the "capture gain" volume so that you get to hear whatever
is being recorded. you might have to turn down something else as well,
but thats probably secondary.

its not clear to me whether or not many mixers come with a single
control that can do this, and/or whether there is any standard way to
do this that ALSA "exports" to the world.

any comments? i'd like to provide "hardware monitoring" for users of
consumer oriented cards to supplement the hammerfall and ice1712 stuff
that we already have ...

--p



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
