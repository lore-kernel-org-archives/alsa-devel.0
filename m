From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Rawmidi and CONFIG_DEBUG_SPINLOCK_SLEEP
Date: Sun, 1 Feb 2004 17:37:49 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0402011736410.20355@pnote.perex-int.cz>
References: <40196C9B.3050901@undata.org> <Pine.LNX.4.58.0401310942260.1876@pnote.perex-int.cz>
 <401CE08D.5070903@undata.org> <401D0D6D.60601@undata.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate2.perex.cz (UNKNOWN@194.149.109.108.adsl.nextra.cz [194.149.109.108])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id RAA12769
	for <alsa-devel@alsa-project.org>; Sun, 1 Feb 2004 17:36:24 +0100
In-Reply-To: <401D0D6D.60601@undata.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thomas Charbonnel <thomas@undata.org>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, 1 Feb 2004, Thomas Charbonnel wrote:

> The attached patch fixes the problem for me, but I took the obvious and 
> easy way - I may have missed something.

Nope. It looks good. I've applied it to CVS. Thanks for analyze.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
