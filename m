From: Manuel Jander <manuel.jander@gmail.com>
Subject: Re: Enumerating virtual devices
Date: Mon, 31 Jan 2005 09:42:37 -0300
Message-ID: <1107175357.3189.5.camel@localhost>
References: <200501280209.14823.GregorMueckl@gmx.de>
	 <1106940570.3705.12.camel@krustophenia.net>  <s5hpszllslw.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hpszllslw.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hello,

On Mon, 2005-01-31 at 12:56 +0100, Takashi Iwai wrote:
> At Fri, 28 Jan 2005 14:29:30 -0500,
> Lee Revell wrote:
> > On Fri, 2005-01-28 at 02:09 +0100, Gregor M=FCckl wrote:
> > > Hello!
> > > Is there a way to enumerate devices like "surround40", "front", "si=
de", etc.=20
> > > and other user-created virtual devices? I can't seem to find any fu=
nction for=20
> > > that in the documentation. Any hint would be appreciated.
[snip!]
> Right, no API yet.
>=20
> I have a plan to create a new API to list up the available PCMs, but
> not implemented yet.

IMHO enumeration should not be done just for soundcards, but rather for
"devices" and channels. I was proposing something like that in the scope
of a Resource Manager and Configuration system for ALSA. Unfortunately i
could not go any further beyond some general ideas, because of current
very bad employment conditions :( (no time...).
I posted my thoughts on the ALSA wiki, if someone may be interested:
http://alsa.opensrc.org/index.php?page=3DDrawingBoard

--=20
Manuel Jander
Electronic Engineer



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
