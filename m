From: John Rigg <aldev@sound-man.co.uk>
Subject: Re: MOUT PCI(E)424
Date: Thu, 25 Jan 2007 13:23:19 +0000
Message-ID: <20070125132319.GA3191@localhost.localdomain>
References: <20070125093839.GA5805@linux-2.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20070125093839.GA5805@linux-2.site>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Fons Adriaensen <fons@kokkinizita.net>
Cc: Alsa Developres <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 25, 2007 at 10:38:39AM +0100, Fons Adriaensen wrote:
> Is the MOTU PCI(E) 424 supported by ALSA ?
> 
> It's not in the matrix on the ALSA site, so the answer is probably 'no'.
> Any alternatives ? We need 24 analog outputs at 96 kHz, and a few inputs.

RME HDSP MADI card? That can handle 32 ins and 32 outs at 96kHz, but
getting signals in and out of MADI format is expensive
(eg. RME ADI-648 plus 3 x 8-channel 96kHz ADAT interfaces).

The only other alternative AFAIK is to use 3 x 8-channel cards
(eg. M-Audio Delta 1010(LT) synced via S/PDIF), but you can probably
forget about low-latency operation with jackd if you do that - pcm_multi
and -rt kernel didn't work together with jackd last time I tried
(big xruns on SMP, lockup on UP).

John

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
