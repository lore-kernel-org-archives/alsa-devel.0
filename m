From: Joerg Mayer <jmayer@loplof.de>
Subject: Re: Problems with VIA8233A (todays cvs)
Date: Tue, 22 Jul 2003 22:02:31 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030722200231.GR9899@thot.informatik.uni-kl.de>
References: <20030722182649.GP9899@thot.informatik.uni-kl.de> <s5hy8yqflfu.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hy8yqflfu.wl@alsa2.suse.de>
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

On Tue, Jul 22, 2003 at 08:47:17PM +0200, Takashi Iwai wrote:
> At Tue, 22 Jul 2003 20:26:49 +0200,
> > kernel: ALSA ../alsa-kernel/pci/via82xx.c:687: invalid via82xx_cur_pt=
r, using last valid pointer
> > last message repeated 205 times

> try to add dxs_support=3D3 to snd-via82xx module option.
> (or dxs_support=3D2 if it doesn't solve the problem.)

Both options don't affect anything I would notice, but...

> see alsa-kernel/Documentation/ALSA-Configuration.txt for details.

OK, done now :)

> btw, before building the alsa-driver externally, it's better to remove
> CONFIG_SND* in your kernel configuration
> (/usr/src/linux/include/linux/autoconf.h).
> otherwise there might be inconsistencies.

...by doing this I got rid of the messages.

So the problem remains, that the sound is still not working properly, and
still with the same effects (except the kernel messages).
The sound in e.g. pysol plays , but at at least twice the speed it should
and with the distortions that are associated with it. Diablo 2 in winex
also still has the same problems.
Another thing the dxs options don't change is the fact that I can run
only one application using sound at a time, not several.
All of this worked with Suse 8.1, original kernel and one of your rpm-pac=
kages
at people/tiwai/ (don't remember the version though).


 Thanks
     J=F6rg
--=20
Joerg Mayer                                           <jmayer@loplof.de>
We are stuck with technology when what we really want is just stuff that
works. Some say that should read Microsoft instead of technology.


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
