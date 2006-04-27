From: Pierre Ossman <ossman@cendio.se>
Subject: Non-continous channel map?
Date: Thu, 27 Apr 2006 07:52:35 +0200
Message-ID: <44505C23.30109@cendio.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.cendio.se (mail.cendio.se [193.12.253.69])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9FFE2172
	for <alsa-devel@alsa-project.org>; Thu, 27 Apr 2006 07:52:35 +0200 (MEST)
Received: from [10.47.1.240] (ossman.lkpg.cendio.se [10.47.1.240])
	by mail.cendio.se (Postfix) with ESMTP id E9A6825DA34
	for <alsa-devel@alsa-project.org>; Thu, 27 Apr 2006 07:52:35 +0200 (CEST)
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

Hi!

ALSA uses a rather strict default channel map, just a simple list. This 
is insufficient for the polypaudio plug-in I wrote, as the polypaudio 
server might have an output of e.g. just the center channel and a 
subwoofer. I'm wondering how to properly represent this in ALSA.

For the PCM, there is no problem as we as clients decide which channels 
are to be set up. The server will then need to map these to actual hardware.

For mixer, however, we're modifying the server hardware so we will need 
to adapt to whatever channels it has. So provided I have a device with 
channels "left", "right", "center" and "subwoofer", should I:

  a) Just expose "left" and "right" since "rear left" isn't present (the 
next in ALSA's list).

  b) Expose all channels until I can cover my four and simply filter out 
the ones that aren't present on the server.

  c) Ignore ALSA's list completely and leave it to the user to figure 
out what the channel map is.

  d) Something else?

Input appreciated.

-- 
Pierre Ossman                Telephone: +46-13-21 46 00
Cendio AB                    Web: http://www.cendio.com


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
