From: Daniel Drake <dsd@gentoo.org>
Subject: Rear right speaker silent on 2.6.11
Date: Sat, 12 Mar 2005 23:11:08 +0000
Message-ID: <4233770C.10601@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I'm using the onboard sound chip on my nvidia nforce motherboard with the 
snd-intel8x0 driver. As of 2.6.11, the rear right speaker has gone silent (the 
others are fine). Going back to 2.6.10 makes it all work again.

Upgrading to 2.6.11-mm3 solves the problem. But I'm interested in which patch 
solves this problem, so that I can fix the Gentoo kernel.

A gentoo user also reported this here, using completely different hardware:
http://bugs.gentoo.org/show_bug.cgi?id=84276

Any pointers as to which patch fixes it?

Thanks,
Daniel


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
