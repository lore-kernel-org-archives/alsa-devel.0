From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Subject: Re: CMI8768 patch
Date: Thu, 24 Feb 2005 23:23:49 +0000
Message-ID: <1109287429.3789.35.camel@bastov>
References: <92C0412E07F63549B2A2F2345D3DB515F7D65D@cm-msg-02.cmedia.com.tw>
	 <1109218822.1244.35.camel@bastov> <s5hu0o25jxj.wl@alsa2.suse.de>
	 <1109270548.3789.5.camel@bastov>  <s5his4h6b9p.wl@alsa2.suse.de>
Reply-To: sergio@sergiomb.no-ip.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <s5his4h6b9p.wl@alsa2.suse.de>
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
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 2005-02-24 at 19:52 +0100, Takashi Iwai wrote:
> Enable the commented out part again in pci/ac97/ac97_patch.c:2043
>=20
> 	ac97->flags |=3D /*AC97_HAS_NO_MASTER_VOL |*/ AC97_HAS_NO_PCM_VOL;
>=20
> to=20
>=20
> 	ac97->flags |=3D AC97_HAS_NO_MASTER_VOL | AC97_HAS_NO_PCM_VOL;
>=20
>=20
> The _only_ question is, whether the Master volume really does nothing,
> or has _any_ role.  As mentioned, if it's really a dummy control, we
> should rather remove it to avoid confusion.

Well I try to remove it and Master and PCM volume disappears.=20
And when put comment back in source, the results of mixer has been
change from begging, PCM doesn't appears with volume, after some make
install , modprobes, alsamixer and kmix, finally I got PCM back.
Seems after install alsa-drive, I have to reinstall alsa-lib !?


>=20
>=20
> Takashi
--=20
S=E9rgio M.B.



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
