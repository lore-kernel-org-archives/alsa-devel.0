From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Adding controls
Date: Tue, 21 Mar 2006 18:58:38 -0500
Message-ID: <1142985518.4532.193.camel@mindpipe>
References: <1142984360.9284.33.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mustang.oldcity.dca.net (mustang.oldcity.dca.net [216.158.38.3])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 0E2B212C
	for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2006 00:58:41 +0100 (MET)
In-Reply-To: <1142984360.9284.33.camel@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2006-03-21 at 23:39 +0000, Adrian McMenamin wrote:
> When I try to compile my driver I get loads of messages like this...

Weird.  It is defined in asound.h, which should be included by:

cvs/alsa/alsa-kernel/include/asequencer.h:#include <sound/asound.h>
cvs/alsa/alsa-kernel/include/control.h:#include <sound/asound.h>
cvs/alsa/alsa-kernel/include/hwdep.h:#include <sound/asound.h>
cvs/alsa/alsa-kernel/include/pcm.h:#include <sound/asound.h>
cvs/alsa/alsa-kernel/include/rawmidi.h:#include <sound/asound.h>
cvs/alsa/alsa-kernel/include/sfnt_info.h:#include <sound/asound.h>
cvs/alsa/alsa-kernel/include/timer.h:#include <sound/asound.h>

Maybe it's an arch thing.  Try including <sound/asound.h> directly, or
just copy the declaration ;-)

Lee



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
