From: =?iso-8859-1?B?QXNiavhybiBT5mL4?= <asbjs@stud.ntnu.no>
Subject: Re: Q: Compiling ALSA for 2.6.16
Date: Mon, 27 Mar 2006 11:45:37 +0200
Message-ID: <20060327094537.GA8655@stud.ntnu.no>
References: <20060323102614.GA19835@stud.ntnu.no> <s5h64m5jv9y.wl%tiwai@suse.de> <20060323132847.GA27484@stud.ntnu.no> <s5h1wwtjn42.wl%tiwai@suse.de> <20060324083712.GD22993@stud.ntnu.no> <s5h4q1nzvgf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h4q1nzvgf.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 24, 2006 at 04:57:52PM +0100, Takashi Iwai wrote:
> At Fri, 24 Mar 2006 09:37:12 +0100,
> Asbj=F8rn S=E6b=F8 wrote:


> > > > [Compiling the newest ALSA in an attempt to get a vxpocket to wor=
k]


> > I am still stuck, though.  The vxloader does not find the card. =20
> > And neither does alsaconf.
> > (See the log below of the attempt to set up the card.)
>=20
> With the recent version, you don't need to load snd-vxload by
> yourself.  And, you don't need vxloader, too.  But you need to install
> the firmware files in alsa-firmware package to the appropriate
> directory.  Usually the default should be OK.

Well, the firmware should be OK:
---------------
dhcp91  ~ $ ls /usr/lib/hotplug/firmware/vx
bd56002.boot  bx_1_vp4.b56  l_1_vp4.d56  x1_1_vp4.xlx  x1_2_v22.xlx
bd563s3.boot  bx_1_vxp.b56  l_1_vx2.d56  x1_1_vx2.xlx
bd563v2.boot  l_1_v22.d56   l_1_vxp.d56  x1_1_vxp.xlx
----------------


=20
> Of course, CONFIG_FW_LOADER should be enabled in the kernel config to
> get it working so, as described in ALSA-Configuration.txt.

Actually, ALSA-Configuration.txt does not says this for the VXpocket,=20
only for the snd_hdsp module. =20
But yes, it is enabled (as a module, though):
------------------------
dhcp91  ~ $ zcat /proc/config.gz |grep FW_LOADER
CONFIG_FW_LOADER=3Dm
-------------------------


> Then just plug the card in.  Then pcmcia stuff will load snd-vxpocket,
> and kernel will get the firmware data automatically, set up the board
> and ready.

Unfortunately not so here.  I get a log message saying that a pccard is=20
loaded.  But the module is not loaded.
---------------
dhcp91  ~ $ tail -2 /var/log/messages=20
Mar 27 11:24:24 dhcp91 kernel: [drm] Loading R200 Microcode
Mar 27 11:25:35 dhcp91 kernel: pccard: PCMCIA card inserted into slot 0
----------------=20

=20
> At least, I can confirm that vxpocket v2 is working now fine with my
> laptop with plain SUSE 10.0 + 2.6.16-rc3 kernel.

Thanks, at least that is good to know!

The error is probably in my setup somewhere.  But surely I do have a=20
hard time finding it.

Although manual loading of the module and the firmware should not be=20
necessary, it should still work, shouldn't it?

(Hotplug is of course a nice thing to have.  But I can do very well=20
without it.  A manual setup of the card would be fine with me, as long=20
as it worked.)

Asbj=F8rn


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
