From: Abramo Bagnara <abramo.bagnara@libero.it>
Subject: Re: Re: dmix plugin
Date: Tue, 18 Feb 2003 23:36:57 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E52B589.F0C88246@libero.it>
References: <E18kpnN-0001LM-00@sc8-sf-list1.sourceforge.net>
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
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Paul Davis wrote:
> 
> >> Still, don't we already *have* a feeding thread for the sound card? I mean
> >> it doesn't just grab the memory buffer all by itself whenever it wants?
> >
> >Nope. The idea for the dmix plugin is that we share the DMA ring buffer
> >with more threads (processes). There is no "master" thread which operates
> >exclusively with the DMA buffer.
> 
> that would be called "JACK", right ?

Not necessarily, sorry.

I've just explained in many ways that IMO the callback-only model choice
will doom Jack to remain in a niche.

And I say this with grief: Jack is the nicest acronym I've ever heard
;-)

-- 
Abramo Bagnara                       mailto:abramo.bagnara@libero.it

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
