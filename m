From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Subject: Re: Re: au88x0 modem
Date: Thu, 22 Sep 2005 08:24:41 +0200
Message-ID: <20050922062441.GA14036@titan.lahn.de>
References: <4327DA14.3040205@netvigator.com> <20050914205608.GD14657@sashak.softier1.local> <20050915091158.GA7314@titan.lahn.de> <20050915092155.GA7328@titan.lahn.de> <20050915143533.GB23218@sashak.softier1.local> <20050915204345.GC27700@sashak.softier1.local> <20050916084653.GB524@titan.lahn.de> <20050916182524.GE17864@tecr> <20050919150025.GA3058@titan.lahn.de> <20050921220305.GA22110@sashak.softier1.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20050921220305.GA22110@sashak.softier1.local>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net, Raymond <rayau@netvigator.com>, openvortex-dev@nongnu.org
List-Id: alsa-devel@alsa-project.org

Hello!

On Thu, Sep 22, 2005 at 01:03:05AM +0300, Sasha Khapyorsky wrote:
> Ok, 0x42 and 0x44 are my mistake, sorry (need to look in datasheet from
> time to time), Line level register is 0x46.
> Try manual initialization (whole codec):
>
>  # echo 3c 0 > /proc/asound/card0/codec97#0/mc97#1-1+regs
>  # echo 40 1f40 > /proc/asound/card0/codec97#0/mc97#1-1+regs
>  # echo 3e 0 > /proc/asound/card0/codec97#0/mc97#1-1+regs
>  # echo 46 0 > /proc/asound/card0/codec97#0/mc97#1-1+regs
>
> , then try to change 0x46 register (look at dmesg):

Bingo:
>  # echo 46 ffff > /proc/asound/card0/codec97#0/mc97#1-1+regs
0:46 = 8e8e
>  # echo 46 0 > /proc/asound/card0/codec97#0/mc97#1-1+regs
0:46 = 0000

> if it will not work than we have very strange behaviour there.
> If it works try to change 0x54 register (this may work or not).

Sorry, stays always the same. Tried 0,ffff,ff00,00ff,1
0:54 = 0000

> > Sorry, yes. The is ALSA from linux-2.6.13.2 with CONFIG_SND_DEBUG=y,
> > which is equivalent to --with-debug=detect.
>
> I think that CONFIG_SND_DEBUG_DETECT=y is equivalent, but registers
> should writeble via proc with CONFIG_SND_DEBUG=y too.

Yes, should I recompile with CONFIG_SND_DEBUG_DETECT=y too?

BYtE
Philipp
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
