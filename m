From: Bruce Cooper <cooperb@iinet.net.au>
Subject: Re: M-Audio Revolution 7.1
Date: 10 Feb 2003 20:43:21 +0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1044881001.1875.15.camel@home.cowardly.homeip.net>
References: <10366.165.228.129.12.1044847107.squirrel@home.cowardly.homeip.net>
	 <s5h8ywo4hdd.wl@alsa2.suse.de>
	 <1044878241.3145.14.camel@home.cowardly.homeip.net>
	 <s5hznp42v11.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hznp42v11.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I have pulled the card out now

It has the following chips:

main chip marked ICEnsemble ENVY25HT ICE1724 (where did I get 1712A
from?) 0151CD 2IA0002104.  

A chip in a socket, which I assume is the rom for the card, but is has
had something written on it (RC with a red line through it) which
obscures the part name.  

AKM AK4355VF 042A0224N
AKM 438IVT IN226
AKM 5380VT 2N210
1117M3 330224
24AC NO6A

None of those seem like they would be an AC97 codec.  I have also had a
look at the specifications for the card, and it does not mention AC97,
which normally happens.

On Mon, 2003-02-10 at 20:13, Takashi Iwai wrote:
> At 10 Feb 2003 19:57:21 +0800,
> Bruce Cooper wrote:
> > 
> > Hi,
> > 
> > I just checked, and it is the envy24HT, as you predicted.  The chip is
> > also marked ICE1712A instead of ICE1712.  Oh well, that will make life
> > more difficult.  I still want to do it though.
> 
> can you see which codec chips on the board?
> 
> if it's an ac97 codec (or multi ac97 codecs), then we'll be able to
> add the support without difficulties.
> 
> if it's another types and connected over i2s (and if the codec chips
> need proper initialization), it would be tough - we need to know the
> communcation protocol between envy24ht and the codecs (most likely
> over i2c).
> 
> 
> ciao,
> 
> Takashi
> 


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
