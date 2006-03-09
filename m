From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [ALSA - lib 0000172]: Master volume control only
	controls front speakers
Date: Thu, 09 Mar 2006 12:32:33 -0500
Message-ID: <1141925554.13319.37.camel@mindpipe>
References: <5a34d592565296e6d7412e415db906b7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mustang.oldcity.dca.net (mustang.oldcity.dca.net [216.158.38.3])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 03768170
	for <alsa-devel@alsa-project.org>; Thu,  9 Mar 2006 18:32:42 +0100 (MET)
In-Reply-To: <5a34d592565296e6d7412e415db906b7@bugtrack.alsa-project.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: bugtrack@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2006-03-09 at 11:17 +0100, bugtrack@alsa-project.org wrote:
> After a long discussion in alsa-user@lists.sourceforge.net about this
> problem a member of the list (Christian Haertwig) send me a patch to the
> emu10k1 driver that adds a volume control called 'Digital Master' and is
> able to control all 6 channels of the card.

Can someone take a look at this?  It would be great to get this very old
bug fixed for ALSA 1.0.11.

The new control is misleadingly called "Digital Master" because the
existing "Master" control only affects the front speakers.  IMHO this
needs to be changed to "Front" and the new control "Master".

Lee



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
