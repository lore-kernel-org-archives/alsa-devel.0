From: Abramo Bagnara <abramo.bagnara@libero.it>
Subject: Re: [PATCH] plugin_ops.h fixes
Date: Mon, 08 Jul 2002 19:07:28 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D29C6D0.D0B442F0@libero.it>
References: <3D295521.A14C950@ladisch.de> <s5hadp2v7ni.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> 
> >
> > The _norms function appears to be badly broken (_min and _max
> > interchanged, using 32/64 bits for 24/32 bit values). I didn't attempt
> > to fix it as it isn't used, either.

min & max are interchanged indeed. My bad...
Use of 32/64 bits for 24/32 bit is wanted. Take in account that this
function is called on mix results (where I need to avoid wrap before
normalization).

> 
> yes.  we can remove this stuff.
> Jaroslav, any plan to use still this one?

Please don't remove it. I've written it for pcm_mix. Maybe one day I'll
find the time to finish it.

> 
> > And the summing/normalization code in pcm_route.c treats the sample as
> > if it were unsigned.
> 
> nice spot.

Be careful here. Use of signed vs. unsigned was an hard decision.
Can you point me exactly where you see a problem?


-- 
Abramo Bagnara                       mailto:abramo.bagnara@libero.it

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Oh, it's good to be a geek.
http://thinkgeek.com/sf
