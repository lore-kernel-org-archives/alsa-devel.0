From: Paul Davis <pbd@op.net>
Subject: opening control devices with "hw:N,M"
Date: Thu, 18 Jul 2002 09:03:26 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200207181303.g6ID3Qq25729@op.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from newmx1.fast.net (newmx1.fast.net [209.92.1.31])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id PAA07855
	for <alsa-devel@alsa-project.org>; Thu, 18 Jul 2002 15:01:47 +0200
Received: from unknown (HELO op.net) ([209.92.100.76]) (envelope-sender <pbd@op.net>)
          by newmx1.fast.net (qmail-ldap-1.03) with SMTP
          for <alsa-devel@alsa-project.org>; 18 Jul 2002 13:01:34 -0000
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

why doesn't this work:

    snd_ctl_open (&handle, "hw:0,0", ...)

it means that you can't use the same standard name format for control
devices as PCM devices, which is a bit of problem for programs that
need to open both but only want to require the user to specify a
single name ...

--p


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
