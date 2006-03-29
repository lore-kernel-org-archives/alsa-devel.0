From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: PROBLEM: about module intel8x0.ko
Date: Wed, 29 Mar 2006 16:06:16 -0500
Message-ID: <1143666377.13933.17.camel@mindpipe>
References: <200603291651.10540.fred@lea-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mustang.oldcity.dca.net (mustang.oldcity.dca.net [216.158.38.3])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 1D0801AC
	for <alsa-devel@alsa-project.org>; Wed, 29 Mar 2006 23:06:26 +0200 (MEST)
In-Reply-To: <200603291651.10540.fred@lea-linux.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: fred@lea-linux.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2006-03-29 at 16:51 +0200, Fr=E9d=E9ric Bonnaud wrote:
> 1. with kernel 2.6.16.1 (vanilla on gentoo) (it starts with 2.6.16) mod=
ule=20
> intel8x0.ko load but doesn't found my NFORCE - NVidia CK804
>=20
> 2. with kernel 2.6.15.*, patched or not by gentoo staff, my device work=
s very=20
> well, started with 2.6.16, the module loads, but doesn't found any card=
=20
> (cat /proc/asound/cards says : --- no soundcards ---)
> not any message un /var/log/message, not any message at boot, all seems=
 good=20
> except that alsa doesn't know about my card,
>=20
> strangely mplayer can play sound (may be using oss interface, because i=
t says=20
> that there's no alsa device, and seems to fall back to oss driver)

If mplayer can play sounds but /proc/asound/cards says no soundcards
then you must have compiled the OSS driver into the kernel.  Recompile
the kernel with all OSS drivers disabled.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
