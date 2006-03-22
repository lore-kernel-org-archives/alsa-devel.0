From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: Adding controls
Date: Wed, 22 Mar 2006 20:36:13 +0000
Message-ID: <1143059773.9254.3.camel@localhost.localdomain>
References: <1142984360.9284.33.camel@localhost.localdomain>
	 <1142985518.4532.193.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sc-outsmtp1.homechoice.co.uk (sc-outsmtp1.homechoice.co.uk [81.1.65.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 6E36C18D
	for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2006 21:36:28 +0100 (MET)
In-Reply-To: <1142985518.4532.193.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2006-03-21 at 18:58 -0500, Lee Revell wrote:
> On Tue, 2006-03-21 at 23:39 +0000, Adrian McMenamin wrote:
> > When I try to compile my driver I get loads of messages like this...
> 
> Weird.  It is defined in asound.h, which should be included by:
> 
> cvs/alsa/alsa-kernel/include/asequencer.h:#include <sound/asound.h>
> cvs/alsa/alsa-kernel/include/control.h:#include <sound/asound.h>
> cvs/alsa/alsa-kernel/include/hwdep.h:#include <sound/asound.h>
> cvs/alsa/alsa-kernel/include/pcm.h:#include <sound/asound.h>
> cvs/alsa/alsa-kernel/include/rawmidi.h:#include <sound/asound.h>
> cvs/alsa/alsa-kernel/include/sfnt_info.h:#include <sound/asound.h>
> cvs/alsa/alsa-kernel/include/timer.h:#include <sound/asound.h>
> 
> Maybe it's an arch thing.  Try including <sound/asound.h> directly, or
> just copy the declaration ;-)
> 
I did. Made no difference afaics



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
