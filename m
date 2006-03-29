From: =?iso-8859-1?B?QXNiavhybiBT5mL4?= <asbjs@stud.ntnu.no>
Subject: Re: Q: Compiling ALSA for 2.6.16
Date: Wed, 29 Mar 2006 21:34:03 +0200
Message-ID: <20060329193403.GA16810@stud.ntnu.no>
References: <20060323102614.GA19835@stud.ntnu.no> <s5h64m5jv9y.wl%tiwai@suse.de> <20060323132847.GA27484@stud.ntnu.no> <s5h1wwtjn42.wl%tiwai@suse.de> <20060324083712.GD22993@stud.ntnu.no> <s5h4q1nzvgf.wl%tiwai@suse.de> <20060327094537.GA8655@stud.ntnu.no> <1143492843.1792.279.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1143492843.1792.279.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 27, 2006 at 03:54:03PM -0500, Lee Revell wrote:
> On Mon, 2006-03-27 at 11:45 +0200, Asbj=F8rn S=E6b=F8 wrote:
> > Actually, ALSA-Configuration.txt does not says this for the VXpocket,=
=20
> > only for the snd_hdsp module. =20
> > But yes, it is enabled (as a module, though):
> > ------------------------
> > dhcp91  ~ $ zcat /proc/config.gz |grep FW_LOADER
> > CONFIG_FW_LOADER=3Dm
> > -------------------------
> >=20
> >=20
>=20
> Is the firmware-class module loaded?

No.  But loading manually does not seem to make any difference.

Asbj=F8rn



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
