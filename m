From: Peter Kirk <pwk.linuxfan@gmx.de>
Subject: Re: smart and automatic use of dmix and dsnoop - feature suggestion.
Date: Mon, 17 Nov 2003 19:30:30 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200311171930.34843.pwk.linuxfan@gmx.de>
References: <200311141221.hAECLqlT003018@oud.linuxaudiosystems.com> <200311170137.02755.mark@egghead.free-online.co.uk> <s5hznevjnfd.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hznevjnfd.wl@alsa2.suse.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

WARNING: Unsanitized content follows.
-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am Montag, 17. November 2003 11:32 schrieb Takashi Iwai:
> At Mon, 17 Nov 2003 01:37:02 +0000,
> Mark Hubbard wrote:
> > On Friday 14 Nov 2003 15:31, Takashi Iwai wrote:
> > > At Fri, 14 Nov 2003 15:11:22 +0000, Mark Hubbard wrote:
> > > > On Friday 14 Nov 2003 13:20, Takashi Iwai wrote:
> > > > > as a future plan, we'll define dmix as default for el-cheapo
> > > > > soundcards, but e.g. not for sb live, which supports such a
> > > > > function on hardware.
>
> ok, let me correct:  which users most likely want as dmix plugin :)
>
Hmmm,

sorry if I cant realy follow your reasoning. I have understood that using dmix
on every device is stupid - since some applications like jack want low level
access to the hardware. But these applications should use the hw: device, if
I understand everything right. If this is so, you have yet to come up for any
reason why a user would NOT want a smartdmix running behind devices like
"default" "rear" front" (and all others that I dont know about, but that are
consumer application devices) ?

Please enlighten me on this.
Peter
- --
If I could drop dead right now, I'd be the happiest man alive!
		-- Samuel Goldwyn

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/uRPGg2ieGvTmHiURArlnAJ4hc0CmdhQ2Cwh65eE0SdrFy0OH+QCeK0IK
2N60S6oaABtgTXhQVyc8rew=
=79E6
-----END PGP SIGNATURE-----



-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
