From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [PATCH 1/5] emu10k1 SB Live: Master volume and
 front channels via fxbus 8,9
Date: Wed, 23 Feb 2005 09:22:58 +0100 (CET)
Message-ID: <Pine.LNX.4.58.0502230918440.1748@pnote.perex-int.cz>
References: <421A3A3A.6070009@glocalnet.net>  <Pine.LNX.4.58.0502220925540.1748@pnote.perex-int.cz>
 <1109109856.31071.44.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 0386D1D6
	for <alsa-devel@alsa-project.org>; Wed, 23 Feb 2005 09:30:56 +0100 (MET)
In-Reply-To: <1109109856.31071.44.camel@krustophenia.net>
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
Cc: Mikael Magnusson <mikaelmagnusson@glocalnet.net>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 22 Feb 2005, Lee Revell wrote:

> There are two separate issues that the patch addresses.  One is that
> unlike the Audigy configuration, the driver does not use separate FX
> buses for front output and PCM.  So attenuating the front channels will
> attenuate *all* PCM samples.  This has to be fixed in the driver.  And
> it's essentially zero cost as the extra FX buses and GPRs are available.

Sorry, but I don't understand very well why we need to have "PCM mix" FX
buses. We can do this "down-mix" in the DSP code, but it's better to do it
in application. My original DSP code for emu10k1 have only front, rear,
center+lfe FX buses (6). I must miss something important here.

> The other issue is the lack of a master volume control.  Provided the
> first issue is addressed, perex is correct in that this can be solved in
> userspace.
> 
> Personally I feel that the entire patch should be applied, until the
> required abstraction layer exists in alsa-lib.  The second part of the
> patch can be trivially reverted when this is available.

Maybe..

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
