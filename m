From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: usb audio sound quality
Date: Fri, 08 Nov 2002 07:23:04 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DCAE7C8.5030808@boosthardware.com>
References: <Pine.LNX.4.44.0211060959140.1126-100000@cmn37.stanford.edu> <3DC97C55.6000507@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from www7.networkshosting.com (www7.networkshosting.com [66.96.128.106])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id XAA27074
	for <alsa-devel@alsa-project.org>; Thu, 7 Nov 2002 23:34:30 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I'm getting a lot of wierd sound quality bugs while using JACK. It seems 
like the driver is storing the crappyness somewhere and each time I 
access it the quality gets worse. Is it possible that the driver could 
allow the data to linger and make things unstable?

I have been doing some testing today with various softsynths and my mem 
is getting pretty full. Turning off jack just freed up 10MB but still 
it's at

Mem:    386484K total,   336212K used,    50272K free,    41304K buffers

The machine has been up for 7 hours. Is that reasonable?


-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.djcj.org - The Linux Audio Users guide
========================================

"Um...symbol_get and symbol_put... They're
kindof like does anyone remember like get_symbol
and put_symbol I think we used to have..."
- Rusty Russell in his talk on the module subsystem



-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
