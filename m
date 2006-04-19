From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] ice1712: Improve PCM volume gradient for
 aureon cards
Date: Wed, 19 Apr 2006 08:16:57 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0604190816100.9432@tm8103.perex-int.cz>
References: <444557BD.6000900@gmx.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 913ED183
	for <alsa-devel@alsa-project.org>; Wed, 19 Apr 2006 08:16:58 +0200 (MEST)
In-Reply-To: <444557BD.6000900@gmx.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Maximilian Rehkopf <otakon@gmx.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 18 Apr 2006, Maximilian Rehkopf wrote:

> This patch introduces logarithmic volume control for the "PCM Playback
> Volume" control of Terratec Aureon cards (digital master attenuation of
> WM8770). A separate logarithmic table is used.

It's something which I'd like to have in the user space (alsa-lib).

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
