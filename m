From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: User land drivers.
Date: Tue, 31 Aug 2004 11:45:02 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <413456AE.7000007@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-35.mail.demon.net (anchor-post-35.mail.demon.net [194.217.242.85])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 1B99126B
	for <alsa-devel@alsa-project.org>; Tue, 31 Aug 2004 12:45:03 +0200 (MEST)
Received: from superbug.demon.co.uk ([80.176.146.252] helo=[192.168.1.10])
	by anchor-post-35.mail.demon.net with esmtp (Exim 3.35 #1)
	id 1C268M-000Mj1-0Z
	for alsa-devel@alsa-project.org; Tue, 31 Aug 2004 10:45:02 +0000
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

I have found that there are a number of different possible sound 
devices, where creating a user land driver would be beneficial to using 
a kernel module.
E.g. Bluetooth, Firewire etc.

Currently, we have:
user app(user)
     |
     V
alsa-lib(user)
     |
     V
alsa-driver(kernel)
     |
     V
hardware(kernel).

Bluetooth would prefer:
user app(user)
     |
     V
alsa-lib(user)
     |
     V
alsa-bluetooth-headset-profile(user)
     |
     V
bluetooth-driver(kernel)
     |
     V
hardware(kernel).


Would it be possible to have userland processes creating /dev/ files ?
Alternatively, could we provide a new plugin method, so we can add 
userland PCMs, Mixer, etc.

Any ideas?

James


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
