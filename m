From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: xine with dmix
Date: Tue, 20 Jan 2004 17:07:02 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0401201706270.2010@pnote.perex-int.cz>
References: <1074607760.9700.453.camel@thor.asgaard.local>
 <Pine.LNX.4.58.0401201628140.2010@pnote.perex-int.cz>
 <1074614789.9699.464.camel@thor.asgaard.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1074614789.9699.464.camel@thor.asgaard.local>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 20 Jan 2004, Michel D=E4nzer wrote:

> On Tue, 2004-01-20 at 16:29, Jaroslav Kysela wrote:
> > On Tue, 20 Jan 2004, Michel D=E4nzer wrote:
> >=20
> > > I'm basically very happy with http://penguinppc.org/~daenzer/asound.c=
onf
> > > and alsa-oss, kudos to all ALSA developers who made this possible.
> > >=20
> > > The only problem I'm having is that xine doesn't work well. Do you ag=
ree
> > > with the analysis in
> > > http://sourceforge.net/mailarchive/message.php?msg_id=3D6793623 ? Can
> > > snd_pcm_delay() be changed to behave as expected by xine? If so, I ca=
n
> > > look into it, but I'd need some pointers.
> >=20
> > Could you try the attached patch? If you add a line 'slowptr yes' to yo=
ur=20
> > dmix pcm definition, the snd_pcm_delay() function should be more precis=
e.
>=20
> It seems to work perfectly, thank you very much!

Nice. The code is already in CVS, so it will be in 1.0.2.

=09=09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
