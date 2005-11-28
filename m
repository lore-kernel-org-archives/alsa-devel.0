From: Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
Subject: Re: envy24control word clock error
Date: Mon, 28 Nov 2005 18:40:43 +0200
Message-ID: <20051128164043.GF10146@edu.joroinen.fi>
References: <E1EgS8o-0001CV-7k@localhost.localdomain> <2c746f620511272326t5a36425cqa4c4bc8623ca3454@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <2c746f620511272326t5a36425cqa4c4bc8623ca3454@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Eric Shattow <lucent@gmail.com>
Cc: John Rigg <ad@sound-man.co.uk>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 28, 2005 at 01:26:36AM -0600, Eric Shattow wrote:
> On 11/27/05, John Rigg <ad@sound-man.co.uk> wrote:
> > When I start envy24control from xterm I get an endless stream of
> > "Unable to determine wordclock status: No such file or directory" and
> > "Unable to read word clock sync selection: No such file or directory"=
 error
> > messages.
> > These don't stop until I shut down envy24control. The same occurs reg=
ardless
> > of what clock source I set in the GUI, or whether I link my two Delta=
1010s
> > with SPDIF or wordclock in/out. It's the same with -c0, -c1 or both l=
aunched
> > from separate xterms.
> > The messages appear to come from master_clock_status_timeout_callback=
()
> > in envy24control/hardware.c (lines 160-175).
> >
> > This is with alsa-tools-1.0.10 (also happens with rc2), alsa-lib-1.0.=
10,
> > kernel 2.6.14-rt20 x86_64 SMP (alsa 1.0.10rc1 drivers).
> > Anyone got any ideas?
> >
> > John
> >
> No ideas, however I will confirm this is also happening in my Delta
> 1010 setup / amd64 hardware.  Driver is 1.0.10rc3, Debian "etch"
> GNU/Linux OS, 2.6.14 kernel. The envy24control progam spits out an
> endless stream of the same wordclock error messages.
>=20

I'm also having the same problem. I'm running Debian sid (unstable), with
2.6.14-2-686-smp kernel.

Is this Debian specific problem?

>  Eric
>=20
>=20

-- Pasi K=E4rkk=E4inen
      =20
                                   ^
                                .     .
                                 Linux
                              /    -    \
                             Choice.of.the
                           .Next.Generation.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
