From: Russell King <rmk+alsa@arm.linux.org.uk>
Subject: Re: An driver error when I using aplay!
Date: Mon, 7 Jun 2004 14:08:17 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040607140817.A28526@flint.arm.linux.org.uk>
References: <Pine.HPX.4.33n.0406070920300.6374-100000@studcom.urz.uni-halle.de> <20040607092522.29704.qmail@web15206.mail.bjs.yahoo.com> <20040607111729.A23059@flint.arm.linux.org.uk> <Pine.LNX.4.58.0406071239110.3294@pnote.perex-int.cz> <s5hk6yj4jvj.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hk6yj4jvj.wl@alsa2.suse.de>; from tiwai@suse.de on Mon, Jun 07, 2004 at 02:45:20PM +0200
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

On Mon, Jun 07, 2004 at 02:45:20PM +0200, Takashi Iwai wrote:
> i guess so, too.  as you can see in the original post, the error
> returned from hw_params callback (sample not available), thus it
> doesn't call trigger(START) callback yet at all.

If we never got past hw_params() then we didn't enable the IO,
and it must be that something else in the system fiddled with
the chip and set it incorrectly.

> unfurtunately i can't tell any more unless i read the driver code.
> where can i find the code?

I never officially released the driver, though it was part of the
old -rmk patches back in the 2.6.0-test era.  Where Roc has got
the source from, and what modifications have been made is anyones
guess.

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
