From: Jaroslav Kysela <perex@suse.cz>
Subject: RE: writing user program for alsa under fedora core 1
Date: Sun, 30 May 2004 13:49:13 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0405301347050.1777@pnote.perex-int.cz>
References: <FDEHJOEHEEGCJHLBEHMFGEOBCAAA.fwmiller@cornfed.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from outgoing.perex-int.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id NAA04783
	for <alsa-devel@alsa-project.org>; Sun, 30 May 2004 13:44:12 +0200
In-Reply-To: <FDEHJOEHEEGCJHLBEHMFGEOBCAAA.fwmiller@cornfed.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Frank W. Miller" <fwmiller@cornfed.com>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sat, 29 May 2004, Frank W. Miller wrote:

> using ALSA.  When I try to run my existing binary that makes OSS calls on
> top of Fedora that is using an ALSA driver for my soundcard, I get some
> strange behaviour, some of the calls don't work the same.  For example, the
> card supports full-duplex but the ALSA driver seems to think it will only
> support half-duplex.  When I try to set the sampling rate on the 16-bit

Please, specify your hardware. We have probably available two indepedent 
devices for your card, because ALSA supports full-duplex for capable 
devices.

> interface, I get an error (cant remember which one right now).  So my

Document this with a small test program. We'll try to fix your problem.
Please, create a report in our bug-tracking-system.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
