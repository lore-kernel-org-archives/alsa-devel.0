From: Sasha Khapyorsky <sashak@smlink.com>
Subject: Re: Re: au88x0 modem
Date: Thu, 22 Sep 2005 23:19:47 +0300
Message-ID: <20050922201947.GA1267@tecr>
References: <20050914205608.GD14657@sashak.softier1.local> <20050915091158.GA7314@titan.lahn.de> <20050915092155.GA7328@titan.lahn.de> <20050915143533.GB23218@sashak.softier1.local> <20050915204345.GC27700@sashak.softier1.local> <20050916084653.GB524@titan.lahn.de> <20050916182524.GE17864@tecr> <20050919150025.GA3058@titan.lahn.de> <20050921220305.GA22110@sashak.softier1.local> <20050922062441.GA14036@titan.lahn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20050922062441.GA14036@titan.lahn.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Cc: alsa-devel@lists.sourceforge.net, Raymond <rayau@netvigator.com>, openvortex-dev@nongnu.org
List-Id: alsa-devel@alsa-project.org

On 08:24 Thu 22 Sep     , Philipp Matthias Hahn wrote:
> 
> Bingo:
> >  # echo 46 ffff > /proc/asound/card0/codec97#0/mc97#1-1+regs
> 0:46 = 8e8e
> >  # echo 46 0 > /proc/asound/card0/codec97#0/mc97#1-1+regs
> 0:46 = 0000

Fine.

> > if it will not work than we have very strange behaviour there.
> > If it works try to change 0x54 register (this may work or not).
> 
> Sorry, stays always the same. Tried 0,ffff,ff00,00ff,1
> 0:54 = 0000

We are unlucky. This means that GPIO is controlled not via standard
AC97 register, but somehow via MMIO and now we will need to find this
"somehow" (GPIO bits manage DAA interface, including 'Hook-Off' switch,
unfortunately the modem is completely useless without it).

I've looked at win driver
(ftp://ftp.asuscom.de/pub/NOTEBOOK/L8400B/Audio_Modem/8baudw9x.exe)
and think (after few 'strings' runs) that 'ASP4_CTL.vxd' is softmodem
driver (I am completely unfamiliar with .inf files, so please correct
me if I am wrong). Nothing interesting until now and looks that this
file was not dissassembled there
http://savannah.nongnu.org/cgi-bin/viewcvs/openvortex/plato/

Do you or anybody have idea how to dissassemble *.vxd file? (I would
prefer with linux :)).

> > I think that CONFIG_SND_DEBUG_DETECT=y is equivalent, but registers
> > should writeble via proc with CONFIG_SND_DEBUG=y too.
> 
> Yes, should I recompile with CONFIG_SND_DEBUG_DETECT=y too?

This will not help anyway.

Sasha.

PS. Please include me to To or Cc list.


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
