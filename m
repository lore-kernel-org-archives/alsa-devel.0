From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Quattro probs.
Date: Sat, 21 Sep 2002 02:15:19 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D8B57A7.1090500@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from www7.networkshosting.com (www7.networkshosting.com [66.96.128.106])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id TAA31170
	for <alsa-devel@alsa-project.org>; Fri, 20 Sep 2002 19:16:54 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I have found some lingering problems with the latest incarnation of the 
usb-audio code and this card.

For a start I get very odd behaviour while using JACK which doesn't 
happen with my pci cards. Also the sound quality is inferior to the 
previous version which had 3 streams available.

So although I can now hear sound through JACK and I don't get kernel 
oopses, at least not everytime (I had one before which was caused after 
starting alsaplayer a few times in a row which I couldn't catch). there 
is still some way to go on making it possible to use the full potential 
of this card.


-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
========================================

"Um...symbol_get and symbol_put... They're
kindof like does anyone remember like get_symbol
and put_symbol I think we used to have..."
- Rusty Russell in his talk on the module subsystem



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
