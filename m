From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Enumerating virtual devices
Date: Fri, 28 Jan 2005 14:29:30 -0500
Message-ID: <1106940570.3705.12.camel@krustophenia.net>
References: <200501280209.14823.GregorMueckl@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200501280209.14823.GregorMueckl@gmx.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Gregor =?ISO-8859-1?Q?M=FCckl?= <GregorMueckl@gmx.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 2005-01-28 at 02:09 +0100, Gregor M=FCckl wrote:
> Hello!
>=20
> Is there a way to enumerate devices like "surround40", "front", "side",=
 etc.=20
> and other user-created virtual devices? I can't seem to find any functi=
on for=20
> that in the documentation. Any hint would be appreciated.
>=20

That's a very very good question.  As you may know this came up on the
JACK list recently.

I suspect there is no good API for this, because aplay -L essentially
does "get config | grep pcm".

Lee



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
