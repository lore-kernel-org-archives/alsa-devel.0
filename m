From: Joerg Mayer <jmayer@loplof.de>
Subject: Re: Problems with VIA8233A (todays cvs)
Date: Wed, 23 Jul 2003 14:58:22 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030723125822.GT9899@thot.informatik.uni-kl.de>
References: <20030722182649.GP9899@thot.informatik.uni-kl.de> <s5hy8yqflfu.wl@alsa2.suse.de> <20030722200231.GR9899@thot.informatik.uni-kl.de> <s5hptk1fxu2.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hptk1fxu2.wl@alsa2.suse.de>
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

On Wed, Jul 23, 2003 at 10:31:49AM +0200, Takashi Iwai wrote:
> At Tue, 22 Jul 2003 22:02:31 +0200,
> Joerg Mayer wrote:
> >=20
> > On Tue, Jul 22, 2003 at 08:47:17PM +0200, Takashi Iwai wrote:
> > > At Tue, 22 Jul 2003 20:26:49 +0200,
> > > > kernel: ALSA ../alsa-kernel/pci/via82xx.c:687: invalid via82xx_cu=
r_ptr, using last valid pointer
> > > > last message repeated 205 times
> >=20
> > > try to add dxs_support=3D3 to snd-via82xx module option.
> > > (or dxs_support=3D2 if it doesn't solve the problem.)
> >=20
> > Both options don't affect anything I would notice, but...
>=20
> are you sure?
> they must have big influence on the behavior.
> dxs_support=3D2 doesn't work well on 0.9.5.  you should try cvs version
> if dxs_support=3D3 doesn't solve the problem.

Yes, I'm very sure. Just to summarize: My friend had problems with the al=
sa
binaries from Suse 8.2, so we updated the whole system with all patches
that where available from Suse, including the kernel. The problem was sti=
ll
the same.  Next, we checked out alsa from cvs (co started yesterday (tues=
day)
after 6pm), rebuilt everything and the problem was still there.
Then I sent the mail to alsa-devel.
You told me to a) test the dxs_support options and b) rebuild the kernel
without the SND_ entries in the autoconf.h file.
Playing with a) changed nothing, tested with /etc/init.d/alsasound restar=
t.
Then I changed b), deleted all .o files, rebuilt and installed again.  Af=
ter
that, the kernel messages were gone.
Playing with dxs_support afterwards did not resolve the problem.
The atachment to my first mail contains /proc/pci and some other output
(from the alsa-version provided with the updated suse 8.2).

There are two noticable problems: Music in Pysol plays much too fast, Mus=
ic
in NWN (linux version) is jerky, as is the sound in DiabloII under WineX.
If you need new/other/updated infos or anything, I'm willing to provide t=
hem.

Oh, btw. I have some doubts that the chipset really is a 8233A chipset (t=
he A).

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
