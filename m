From: Marco Canini <m.canini@libero.it>
Subject: Re: Support for realtek alc 655
Date: 04 Sep 2003 15:50:40 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1062683440.1189.15.camel@jabawack.canini.org>
References: <200309041349.PAA04964@www3.pobox.sk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200309041349.PAA04964@www3.pobox.sk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: p z oooo <pzad@pobox.sk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 2003-09-04 at 15:49, p z oooo wrote:
> >There exist some ac97 codecs capable of hw multiplexing?
> >What are them?
> 
> I think that none. AC97 is only part of sound system. These part is 
> reponsible for A/D and D/A conversion + analog mixer + spdif in + 
> spdif out. Most capability is in second part. This second part is 
> responsible for playing digital sound and hardware mixing and is 
> integrated into motherboard chipset. For example you can have two 
> motherboards which uses same AC97 codec and one (for example VIA8235 
> based) is capable hw mixing of 4 streams and second (for example 
> intel based) can't do hw mixing.
> 
Oh, ok now i get it. so it depends on the mobo's chipset, and from what
you write i understand that all mobos based on i875p unregarding of
particular ac97 codec aren't able of doing hw mixing.

is dmix a good solution in those cases?

thanks

> Peter Zubaj
> 
> 
> 
> ====================== REKLAMA =================================
> Vyrazne zlavy pocitacov a prislusenstva
> Sun Fire V210 server v cenach uz od 125.000,- Sk bez DPH
> Navstivte nas na adrese http://www.somi.sk/sun/lowend_servery.php
> ================================================================
-- 
Marco Canini <m.canini@libero.it>



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
