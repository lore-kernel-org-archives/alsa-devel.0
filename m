From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: arecordmidi and aplaymidi
Date: Tue, 16 Nov 2004 09:10:54 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0411160851010.755-100000@studcom.urz.uni-halle.de>
References: <200411152026.51451.wackysalut@bourget.cc>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200411152026.51451.wackysalut@bourget.cc>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alexandre B <wackysalut@bourget.cc>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Alexandre B wrote:
> I'd like to use arecordmidi and aplaymidi to pipe MIDI events to a Perl
> script, which in turn would control light spots for a play.

Well, this is not quite what these programs were designed for.

> For now, arecordmidi has a --dump option, which suits my needs perfectly, but
> it seems it *has* to save a file.

/dev/null?

> Also.. it would be even better if aplaymidi could just pipe events in text
> form (perhaps another --dump ?) to standard output, just like the
> "arecordmidi --dump" output.. that way.. it would be possible to *save*
> lighting effects into a .midi file..

Do you want to convert _from_ or _to_ text form?

There is an example sequencer client in the alsa-lib source package
(alsa-lib/test/seq.c) that just outputs events it receives as text.
It should be easy to modify it to fit your needs.

Having separate tool for playing and converting to text is the unixy
way.  :-)


Best regards,
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
