From: Russell King <rmk+alsa@arm.linux.org.uk>
Subject: Re: An driver error when I using aplay!
Date: Mon, 7 Jun 2004 16:04:42 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040607160442.D28526@flint.arm.linux.org.uk>
References: <Pine.HPX.4.33n.0406070920300.6374-100000@studcom.urz.uni-halle.de> <20040607092522.29704.qmail@web15206.mail.bjs.yahoo.com> <20040607111729.A23059@flint.arm.linux.org.uk> <Pine.LNX.4.58.0406071239110.3294@pnote.perex-int.cz> <s5hk6yj4jvj.wl@alsa2.suse.de> <20040607140817.A28526@flint.arm.linux.org.uk> <s5hbrjv4hbs.wl@alsa2.suse.de> <20040607145113.B28526@flint.arm.linux.org.uk> <s5h4qpn4fjk.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h4qpn4fjk.wl@alsa2.suse.de>; from tiwai@suse.de on Mon, Jun 07, 2004 at 04:18:55PM +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@suse.cz>, Roc Wu <cooloney@yahoo.com.cn>, Clemens Ladisch <clemens@ladisch.de>, Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 07, 2004 at 04:18:55PM +0200, Takashi Iwai wrote:
> You're right.  The error was not txcr, but in another WARN_ON() for
> checking chan->tx_substream (line 404)!  (Russell, you mislead this,
> too ;)

Well I don't have the exact source which this guy is using, so I can
only guess.

> The reason is same -- since hw_params is not called,
> chan->tx_substream is not set, too.

Wrong.  It's memset to zero by matter of fact of how it is allocated.
I'm surprised you don't know this.  It is afterall code which I thought
you'd be fully aware of, being core ALSA code.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
