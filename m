From: Peter Kirk <pwk.linuxfan@gmx.de>
Subject: Re: smart and automatic use of dmix and dsnoop - feature suggestion.
Date: Sat, 15 Nov 2003 03:46:34 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200311150346.40669.pwk.linuxfan@gmx.de>
References: <200311141221.hAECLqlT003018@oud.linuxaudiosystems.com> <200311141511.22130.mark@egghead.free-online.co.uk> <s5hy8uj55m6.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hy8uj55m6.wl@alsa2.suse.de>
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

Am Freitag, 14. November 2003 16:31 schrieb Takashi Iwai:
> At Fri, 14 Nov 2003 15:11:22 +0000,
>
> Mark Hubbard wrote:
> > On Friday 14 Nov 2003 13:20, Takashi Iwai wrote:
> > > as a future plan, we'll define dmix as default for el-cheapo
> > > soundcards, but e.g. not for sb live, which supports such a function
> > > on hardware.
> >
> > And what is your definition of an "el-cheapo" soundcard? :)
OK,

now I understand that using what I suggested for *every* device alsa provides
is stupid (hw: should go directly to the hardware for low level application
etc.). Well, but as I see it the behavior for the "default" "front" "rear"
devices (the *normal* consumer applications use) could (and should in my
opinion) implement the behavior I suggest. But - I cant understand why you
are limiting down the use of dmix to "el-cheapo" soundcards - every soundcard
has in-hardware limitations for playback and capture...so dmix (and the
dnsoop part of my suggestion which you guys like to ignore :/) _can_ be
needed things for every/any card. And - if implemented in the *smart* way I
am talking about, dmix will only start mixing once the "default" "front" or
"rear" (assuming these are the only 3 devices *normal* applications should
use) cant handle another playback...Before that this "smartdmix" thing would
only pass through a untouched (same quality, no extra cpu usage, no extra
latency) stream. What you are talking about is the current (call it
stupid :P) dmixing, to just mix every stream that comes in, no matter if the
used device could handle the stream in hardware without mixing or not...which
of course gives you things like quality degression and unnecessary cpu usage
on cards that can playback more than one stream in hardware.

> the question is "which" user is targeted.
> most desktop users need simple mixing only: playing mp3 or DVD and
> beep.  hence, if the restriction of sampling-rate for a single app is
> removed, there would be no big disadvantage to use always dmix.
see above, always use smartdmix shouldnt be a problem for anybody - always
using dmix is (I must agree) plain stupid for high-end soundcards.

> and, note that we're discussing the "default" behavior.  you can
> easily change it by defining your own default in ~/.asoundrc, as well
> as you can set dmix for now.
>
> i believe that the "usability" is a keyword to spread the linux
> desktop over world.  we're still NOT in the way at all.
>
Right,

this is what Im talking about =). And the way I see my suggestion it will
offer great usability improvements for low-end soundcards, very view to
high-end soundcards, and never give any big disadvantages... :)


Peter
- --
Where does it go when you flush?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/tZOPg2ieGvTmHiURApD9AJ0Xxwx0mieCLmFa5z9tnmv5FmLD3wCZAU4e
qUSuQEVlYYHenzIXSylB/rE=
=IXw8
-----END PGP SIGNATURE-----



-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
