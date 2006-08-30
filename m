From: Franck Routier <franck.routier@axege.com>
Subject: No headphones on STAC7661
Date: Wed, 30 Aug 2006 11:14:13 +0200
Message-ID: <44F556E5.6010909@axege.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from axege.net (LNeuilly-152-22-82-133.w193-251.abo.wanadoo.fr
	[193.251.23.133])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8BC2728D
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Aug 2006 11:41:05 +0200 (MEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by axege.net (Postfix) with ESMTP id 89C2D3C22BA
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Aug 2006 11:14:14 +0200 (CEST)
Received: from axege.net ([127.0.0.1])
	by localhost (tige [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 16147-07 for <alsa-devel@alsa-project.org>;
	Wed, 30 Aug 2006 11:14:13 +0200 (CEST)
Received: from [192.168.1.17] (unknown [192.168.1.17])
	by axege.net (Postfix) with ESMTP id 68D053C22A6
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Aug 2006 11:14:13 +0200 (CEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I have problems with headphones on my Sony Viao VGN-SZ1M using alsa.

Main speakers work fine, but as soon as I plug a headphone set, main 
speakers mute (as expected), but I get no sound on headphones either...

Here is my environment :

Sony SZ1M
alsamixer says :
Card: HDA Intel
Chip: SigmaTel STAC7661
two items : Master and PCM.

$ cat /proc/asound/modules
0 snd_hda_intel

I use Ubuntu Dapper with ubuntu kernel 2.6.15-26-686.

Well, I don't know what information would be interesting to track down 
the problem...

Thanks,
Franck

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
