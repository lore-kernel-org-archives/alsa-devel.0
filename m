From: Jaroslav Kysela <perex@suse.cz>
Subject: RFC: Add support for monotonic clock for 2.6
Date: Tue, 27 Feb 2007 15:52:41 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0702271533590.9439@tm8103-a.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [212.20.107.50])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9E3661A7
	for <alsa-devel@alsa-project.org>; Tue, 27 Feb 2007 15:52:42 +0100 (MET)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id
	82272999A8
	for <alsa-devel@alsa-project.org>; Tue, 27 Feb 2007 15:52:42 +0100 (MET)
Received: from tm8103.perex-int.cz (localhost [127.0.0.1])
	by server.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id
	5E762E94BB
	for <alsa-devel@alsa-project.org>; Tue, 27 Feb 2007 15:52:42 +0100 (CET)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

	in 2.6 kernels, we can use ktime_get_ts() function to get 
monotonic time which can be used for PCM timestamps. I would propose to 
reuse the SNDRV_PCM_IOCTL_TSTAMP ioctl to enable using of monotonic clock.
The "enable" (int) argument might mean:

0: standard clock - getnstimeofday()
1: standard clock - getnstimeofday() - for "compatibility"
2: monotonic clock - ktime_get_ts()

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
