From: Glenn English <ghe@slsware.com>
Subject: jerks
Date: Thu, 08 Dec 2005 10:41:47 -0700
Message-ID: <1134063707.13439.37.camel@snuk.slsware.lan>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from srv.slsware.lan (server.slsware.com [207.189.192.218])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8350C173
	for <alsa-devel@alsa-project.org>; Thu,  8 Dec 2005 18:41:49 +0100 (MET)
Received: from snuk.slsware.lan (snuk.slsware.dmz [192.168.20.11])
	by srv.slsware.lan (slsware.com) with ESMTP id 828D226FCB
	for <alsa-devel@alsa-project.org>; Thu,  8 Dec 2005 10:41:47 -0700 (MST)
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

I'm trying to make a Digital Audio Workstation (DAW) out of a SUN W2100z
(dual AMD64).

Every few seconds, at seemingly random times, everything freezes for
~50ms. Even the mouse. Sometimes. Reliable at the first card moved in
Aisle Riot Solitaire and when Jack is running. Often when I'm typing
email (chars don't get from the keyboard to the screen).

I know that's not much of a description, but I don't know where to start
looking for this. I'm assuming interrupts are being disabled entirely
momentarily. My background says it's time for a bus monitor, but I don't
have one handy.

This happens with a 2.6 kernel from the current updated Sarge or a 2.4
from DeMuDi 1.2.1 distro.

Anybody have any idea how to begin tracing this down? Or maybe a better
explanation of what's going on?

-- 
Glenn English
ghe@slsware.com
GPG ID: D0D7FF20



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
