From: Mark Rages <markrages@mlug.missouri.edu>
Subject: Oss mixer emulation
Date: Sat, 24 Aug 2002 02:54:46 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020824075446.GA23390@mlug.missouri.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mlug.missouri.edu (root@mlug.missouri.edu [128.206.61.230])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id JAA19034
	for <alsa-devel@alsa-project.org>; Sat, 24 Aug 2002 09:54:59 +0200
Received: from mlug.missouri.edu (markrages@localhost [127.0.0.1])
	by mlug.missouri.edu (8.12.3/8.12.3/Debian -4) with ESMTP id g7O7soKL023531
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=FAIL)
	for <alsa-devel@alsa-project.org>; Sat, 24 Aug 2002 02:54:51 -0500
Received: (from markrages@localhost)
	by mlug.missouri.edu (8.12.3/8.12.3/Debian -4) id g7O7skYf023529
	for alsa-devel@alsa-project.org; Sat, 24 Aug 2002 02:54:46 -0500
Content-Disposition: inline
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

A quick question, as I'm tired of reading source:

I can adjust the volume of my driver with either alsamixer or aumix.

Using the OSS output plugin for XMMS, however, the volume control on XMMS 
has no effect.

Besides trading XMMS for Alsaplayer, what can I do to fix this?  The same 
setup works fine with my AWE32.  (I referred to the sb_mixer code when 
adding the volume control)

Does the OSS mixer emulation look for the first control to emulate as 
master volume?  Else, how does it choose?

Regards,
Mark


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
