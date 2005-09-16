From: Sasha Khapyorsky <sashak@smlink.com>
Subject: Re: Re: au88x0 modem
Date: Fri, 16 Sep 2005 21:25:24 +0300
Message-ID: <20050916182524.GE17864@tecr>
References: <20050913085552.GA2655@titan.lahn.de> <20050913173529.GD31269@sashak.softier1.local> <20050913174930.GA5816@titan.lahn.de> <4327DA14.3040205@netvigator.com> <20050914205608.GD14657@sashak.softier1.local> <20050915091158.GA7314@titan.lahn.de> <20050915092155.GA7328@titan.lahn.de> <20050915143533.GB23218@sashak.softier1.local> <20050915204345.GC27700@sashak.softier1.local> <20050916084653.GB524@titan.lahn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20050916084653.GB524@titan.lahn.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Philipp Matthias Hahn <pmhahn@titan.lahn.de>, openvortex-dev@nongnu.org, alsa-devel@lists.sourceforge.net, Raymond <rayau@netvigator.com>
List-Id: alsa-devel@alsa-project.org

On 10:46 Fri 16 Sep     , Philipp Matthias Hahn wrote:
> 
> > 2. GPIO
> >
> > Probably we are lucky and au88x0 implements it in AC97 way, try to write
> > mc97 registers via /proc (for this you need build drivers in debug mode,
> > '--with-debug=detect' is ok):
> >  # echo 42 ffff > /proc/asound/card0/codec97#0/mc97#1-1+regs
> >  # echo 42 0 > /proc/asound/card0/codec97#0/mc97#1-1+regs
> >  # echo 54 1 > /proc/asound/card0/codec97#0/mc97#1-1+regs
> 
> Sorry, I did echo those values and read mc97#1-1+regs, but no values
> changed.

Even 0x42 register? Are you with debug version of drivers
( ./configure --with-debug=detect )?

> > , if value is changed (we are lucky then), you may connect line and
> > isten 'Hook-Off' clicks (when 0x54 is switched between 0 and 1) with
> > parallel phone.
> 
> I don't have the line cable with me at the moment and need to find a
> analog telephone circuit until I can test that

If values are not changed there will nothing, don't try.

BTW, stupid question, if you don't have analog telephone line why you
need modem?

Sasha.


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
