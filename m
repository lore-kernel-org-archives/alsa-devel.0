From: Abramo Bagnara <abramo.bagnara@libero.it>
Subject: Re: OSS compatibility w/multichannel cards
Date: Sat, 06 Jul 2002 20:02:50 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D2730CA.93A6BE5A@libero.it>
References: <200207061633.g66GXK922995@op.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp1.libero.it (smtp1.libero.it [193.70.192.51])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id UAA04329
	for <alsa-devel@alsa-project.org>; Sat, 6 Jul 2002 20:04:26 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@op.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Paul Davis wrote:
> 
> it appears that the ice1712 driver, at least for some midiman cards,
> can provide OSS compatibility "out of the box". this seems hard, since
> the h/w has 10 channels, and alsa-driver/alsa-kernel doesn't do
> channel conversion or mapping. similarly, there seems only to be
> support for 32 bit samples (storage format). yet OSS apps using 2
> channels and 16 bit samples work with this card.
> 
> since this doesn't work for the Hammerfall and H-DSP drivers, and
> since i don't understand how it could work given that ALSA doesn't do
> this kind of stuff in the kernel, i am wondering how this is
> happening.
> 
> jaroslav or takashi - can you fill me in? there is some expectation
> that OSS emulation work for the Hammerfall drivers as well, even
> without LD_PRELOAD, and i can't understand how it could be possible.

eh? You was living under a stone last years? ;-)

Kernel OSS emulation works on each cards (its behaviour is similar to
plughw). I played with xmms and rme9652 near two years ago.

-- 
Abramo Bagnara                       mailto:abramo.bagnara@libero.it

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Got root? We do.
http://thinkgeek.com/sf
