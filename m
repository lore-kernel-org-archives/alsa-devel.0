From: =?iso-8859-1?Q?Robert_Br=FCckmann?= <robert@musicalica.de>
Subject: rme9652 locks up my computer
Date: Wed, 20 Feb 2002 11:24:39 +0100
Message-ID: <004401c1b9f8$d214efe0$0300a8c0@wgilmenau>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from apollo63.magicalworks.com (root@[217.172.167.217])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id LAA14456
	for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2002 11:26:00 +0100
Received: from curlysue (a1as17-p35.bln.tli.de [195.252.157.35])
	by apollo63.magicalworks.com (8.11.2/8.11.2/SuSE Linux 8.11.1-0.5) with ESMTP id g1KAPRc32176
	for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2002 11:25:32 +0100
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

Hi!

I have two hammerfalls in my computer, linked via Word Clock. When playing
and recording at the same time with 48 channels, the computer sometimes gets
xruns when cpu load gets bigger. This is not a problem, the recovery works
very often, but if the xrun happens continously, the computer locks, and the
only thing I can do is a hard reset. When the computer starts afetr that,
and did the ext2-fschk, the alsa-driver-initialzation claims about too less
memory for a buffer of one of the cards. But I've 512MB ram in my computer!?
When rebooting the computer again, everything works fine again.

I'm using alsa version 0.9.10a, is there a known problem regarding the
hard-locks?

Thanks,
Robert


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
