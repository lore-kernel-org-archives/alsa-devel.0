From: Alexandre B <wackysalut@bourget.cc>
Subject: Re: arecordmidi and aplaymidi
Date: Tue, 16 Nov 2004 08:38:31 -0500
Message-ID: <200411160838.31853.wackysalut@bourget.cc>
References: <Pine.HPX.4.33n.0411160851010.755-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0411160851010.755-100000@studcom.urz.uni-halle.de>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Le Mardi 16 Novembre 2004 03:10, vous avez =E9crit=A0:
> Alexandre B wrote:
> > I'd like to use arecordmidi and aplaymidi to pipe MIDI events to a Perl
> > script, which in turn would control light spots for a play.
>
> Well, this is not quite what these programs were designed for.

aplaymidi already reads the .mid file.. it would just need to dump the even=
ts=20
with the correct delays but not to the midi device, to the stdout. It does=
=20
all the job already..=20

> > For now, arecordmidi has a --dump option, which suits my needs perfectl=
y,
> > but it seems it *has* to save a file.
>
> /dev/null?

true..

> > Also.. it would be even better if aplaymidi could just pipe events in
> > text form (perhaps another --dump ?) to standard output, just like the
> > "arecordmidi --dump" output.. that way.. it would be possible to *save*
> > lighting effects into a .midi file..
>
> Do you want to convert _from_ or _to_ text form?

I want it to convert a .midi *to* text form.. so that a perl script can rea=
d=20
it. It's to be able to save a sequence of timed events to preset some=20
lighting effects for a play.

>
> There is an example sequencer client in the alsa-lib source package
> (alsa-lib/test/seq.c) that just outputs events it receives as text.
> It should be easy to modify it to fit your needs.

but how would I playback a saved .midi file ?

> Having separate tool for playing and converting to text is the unixy
> way.  :-)

yeah.. but these two tools are so close to do the job :)



thanks

Alexandre Bourget


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
