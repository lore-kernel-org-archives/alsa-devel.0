From: Shaju Abraham <shaju@multitech.co.in>
Subject: aplay and period time.
Date: Thu, 22 Aug 2002 11:31:56 +0530
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D647E54.F3890749@multitech.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mtsslvpngway ([202.54.39.98])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id IAA11548
	for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2002 08:04:38 +0200
Received: from multitech.co.in (atmesh [192.168.1.46])
	by multitech.co.in (8.12.1/8.12.1) with ESMTP id g7M65dUZ004353
	for <alsa-devel@alsa-project.org>; Thu, 22 Aug 2002 11:35:40 +0530
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Alsa-Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


Hi all,

I work on i810 motherboard with built-in sound card.

I use aplay with -F option ( set period-time ) to vary the period-time
from 166 micro secs to 1500 microsecs. I also vary the buffer time (
with -B option)

I observe the following...

1.    The number of fragments i.e frags won't increase beyond 1024.  is
there any way I can go beyond 1024 frags?  Because given a big
buffer_size, I am unable to force the fragment size to be smaller than a
certain size .( the final size being such that frags is 1024 )


Thanx in advance,
--Shaju


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
