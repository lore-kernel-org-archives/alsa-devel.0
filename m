From: Paul Davis <pbd@op.net>
Subject: how to define a 2-index control element?
Date: Sat, 4 May 2002 08:45:42 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205041245.g44Cjgq07507@op.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from newmx1.fast.net (newmx1.fast.net [209.92.1.31])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id OAA19434
	for <alsa-devel@alsa-project.org>; Sat, 4 May 2002 14:45:13 +0200
Received: from unknown (HELO op.net) ([209.92.102.94]) (envelope-sender <pbd@op.net>)
          by newmx1.fast.net (qmail-ldap-1.03) with SMTP
          for <alsa-devel@alsa-project.org>; 4 May 2002 12:45:11 -0000
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

i'm looking at the control API, and i can't see how to define a
control that requires 2 values in order to read or write the control. 

there seems to be an assumption that a control element maps 1:1 onto a
hardware entity. i want (need) to create a control element that is
more flexible than that. the basic idea is:

         control->value.integer.value[0] = source;
         control->value.integer.value[1] = destination;
	 
	 snd_ctl_read (...)

or:

         control->value.integer.value[0] = source;
         control->value.integer.value[1] = destination;
         control->value.integer.value[3] = gain;

	 snd_ctl_write (...)

am i missing something really simple?

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
