From: Jaroslav Kysela <perex@perex.cz>
Subject: move snd-aloop to the alsa-kernel tree?
Date: Mon, 9 Aug 2010 09:17:10 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1008090858190.10278@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 5D3C02454B
	for <alsa-devel@alsa-project.org>;
	Mon,  9 Aug 2010 09:17:11 +0200 (CEST)
Received: from server.perex.cz (server.perex.cz [172.16.0.20])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id
	50CD3149E26 for <alsa-devel@alsa-project.org>;
	Mon,  9 Aug 2010 09:17:11 +0200 (CEST)
Received: from eeebox2.perex-int.cz (localhost [127.0.0.1])
	by server.perex.cz (Perex's E-mail Delivery System) with ESMTP id
	40AF384CAF for <alsa-devel@alsa-project.org>;
	Mon,  9 Aug 2010 09:17:11 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi all,

 	does anyone have any objection to move the loop module (snd-aloop) 
from the alsa-driver tree to the alsa-kernel tree (Linux 2.6 tree)?
 	I worked on these things last days:

- fixed timing issues (we cannot use the identical period
   timing for both playback/capture - it also means that the capture and
   playback buffer setup might be different)
- added proper buffer silencing when the playback is in the draining phase
- added stream parameters change notification (stop the capture stream
   when the playback stream parameters were changed)
- added controls to propagate the playback stream parameters to the
   user space with the notification of changes
- added simple time shift functionality to compensate the time drift for
   another clock source

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
