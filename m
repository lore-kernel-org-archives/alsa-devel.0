From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Q: Compiling ALSA for 2.6.16
Date: Wed, 29 Mar 2006 16:13:56 -0500
Message-ID: <1143666837.13933.22.camel@mindpipe>
References: <20060323102614.GA19835@stud.ntnu.no>
	 <s5h64m5jv9y.wl%tiwai@suse.de> <20060323132847.GA27484@stud.ntnu.no>
	 <s5h1wwtjn42.wl%tiwai@suse.de> <20060324083712.GD22993@stud.ntnu.no>
	 <s5h4q1nzvgf.wl%tiwai@suse.de> <20060327094537.GA8655@stud.ntnu.no>
	 <1143492843.1792.279.camel@mindpipe>  <20060329193403.GA16810@stud.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20060329193403.GA16810@stud.ntnu.no>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?ISO-8859-1?Q?Asbj=F8rn_S=E6b=F8?= <asbjs@stud.ntnu.no>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 2006-03-29 at 21:34 +0200, Asbj=F8rn S=E6b=F8 wrote:
> On Mon, Mar 27, 2006 at 03:54:03PM -0500, Lee Revell wrote:
> > On Mon, 2006-03-27 at 11:45 +0200, Asbj=F8rn S=E6b=F8 wrote:
> > > Actually, ALSA-Configuration.txt does not says this for the VXpocke=
t,=20
> > > only for the snd_hdsp module. =20
> > > But yes, it is enabled (as a module, though):
> > > ------------------------
> > > dhcp91  ~ $ zcat /proc/config.gz |grep FW_LOADER
> > > CONFIG_FW_LOADER=3Dm
> > > -------------------------
> > >=20
> > >=20
> >=20
> > Is the firmware-class module loaded?
>=20
> No.  But loading manually does not seem to make any difference.


Why would this have appeared to work without firmware loading enabled?
Shouldn't the driver have complained loudly?

Lee=20



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting langua=
ge
that extends applications into web and mobile media. Attend the live webc=
ast
and join the prime developer group breaking into this new coding territor=
y!
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D110944&bid=3D241720&dat=3D=
121642
