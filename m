From: Jaroslav Kysela <perex@suse.cz>
Subject: dsnoop, dshare and dmix plugins
Date: Wed, 19 Mar 2003 17:49:51 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303191739010.1351-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id RAA13687
	for <alsa-devel@alsa-project.org>; Wed, 19 Mar 2003 17:49:55 +0100
Received: from pnote.perex-int.cz ([192.168.105.2])
	by gate.perex.cz (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id SAA02314
	for <alsa-devel@alsa-project.org>; Wed, 19 Mar 2003 18:49:51 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi all,

	the dmix plugin was extended to support channel bindings and 
mixing code for 32-bit samples (24-bit resolution).
	I'd like to introduce new two plugins (seems also "most wanted" by
ALSA users): dsnoop and dshare. The dsnoop plugin allows spliting of one
stream to more applications. And finally the dshare plugin does sharing of
channels (thus you may use your multi-channel device for separated
independent tasks). The ALSA configuration syntax for both of new plugins
is same as for the dmix plugin. Please note that dshare plugin must have
the bindings section with unique destination channels otherwise it won't
work.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: Does your code think in ink? 
You could win a Tablet PC. Get a free Tablet PC hat just for playing. 
What are you waiting for?
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
