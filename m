From: katakombi <katakombi@web.de>
Subject: alsa spdif recording on debian bug?
Date: Tue, 8 Feb 2005 00:32:09 +0100
Message-ID: <200502080032.09104.katakombi@web.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Received: from smtp07.web.de (smtp07.web.de [217.72.192.225])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 8E5EB1CF
	for <alsa-devel@alsa-project.org>; Tue,  8 Feb 2005 00:32:03 +0100 (MET)
Received: from [84.162.85.86] (helo=[192.168.2.102])
	by smtp07.web.de with asmtp (WEB.DE 4.103 #192)
	id 1CyIMN-0002Jb-00
	for alsa-devel@alsa-project.org; Tue, 08 Feb 2005 00:32:03 +0100
Content-Disposition: inline
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

Hi all,

  I encountered heavy distortions while doing some digital recordings with an 
terratec aureon fun 5.1 which uses the cmicpi module.
Lately i discovered that simply reloading the modules via the alsasound script 
resolves this issue.
I use debian and their packages deliveres a tweaked boot up skript, that 
doesn't load/unload the modules but saves/restores the sound mixer volumes 
only.

I encourage everybody having those problems trying this out.
Once I had distortions on playback on a Terratec DMX Fire 1024, and the same 
worked for that issue.

Seems like there's a bug in some register initializations, isn't it?
Is there a bug reported, I couldn't find any?

Does the alsasound script anything besides (re)loading the driver's modules, 
and would it be possible to spread these facts among debian users/packagers?

I believe alsa troubles (at least on debian) could be closely connected to 
that.

thanks >8^)

  Stefan K.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
