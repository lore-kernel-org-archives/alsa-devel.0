From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: how to snd_printdd
Date: Fri, 5 Nov 2004 18:03:35 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0411051802270.27559-100000@studcom.urz.uni-halle.de>
References: <08F1D234AF91E540BC1F43889E2A6AA702C0AC8D@digiexch.digigram.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <08F1D234AF91E540BC1F43889E2A6AA702C0AC8D@digiexch.digigram.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Markus Bollinger <bollinger@digigram.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Markus Bollinger wrote:
> Debugging a driver I can track outputs of snd_printk()
> when ./configured --with-debug=full

This option affect snd_printd() calls; snd_printk() is always enabled.

> But I cannot see outputs from snd_printdd()

use --with-debug=detect


HTH
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
