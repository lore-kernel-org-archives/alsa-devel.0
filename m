From: Olaf Hering <olh@suse.de>
Subject: sound/core/pcm_lib.c:158: BUG
Date: Sun, 19 Dec 2004 00:53:59 +0100
Message-ID: <20041218235359.GA3782@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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


Is this just debug output, or should I be worried about it?

linux-2.6.10-rc3-olh/sound/core/pcm_lib.c:158: BUG: stream = 0, pos = 0x4000, buffer size = 0x4000, period size = 0x1000

This is an ibook2, playing mp3 with xmms, alsa version is 1.0.3, from sles9.
I remember no failures in the last couple hours.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
