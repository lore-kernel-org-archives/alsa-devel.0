From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: usb audio sound quality
Date: Thu, 07 Nov 2002 05:32:21 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DC97C55.6000507@boosthardware.com>
References: <Pine.LNX.4.44.0211060959140.1126-100000@cmn37.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from www7.networkshosting.com (www7.networkshosting.com [66.96.128.106])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id VAA04005
	for <alsa-devel@alsa-project.org>; Wed, 6 Nov 2002 21:43:53 +0100
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

I have done extensive testing now and can say that the jack quality is 
exactly the same as the quality from accessing alsa directly with the 
quattro.

Before the merge of the modules jack would not work at all but the sound 
quality of the quattro was crisp and clean. Now jack has absolutely no 
problems but the quality is inferior.

The sound is distorted for any notes that go over a certain volume 
threshhold. It's like the more full the sound is the more likely it will 
distort. I have tested with the output level buttons in and out. The 
sound quality is much improved but still noticibly distorted when the 
button is in.

This is from the manual:

1/2 "Output Level" switch: In the `out' position, the Quattro Outputs 1 
& 2 are set to +4dBu line level operation. Pressing in and engaging this 
switch sets these outputs to -10dBV line level.




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
