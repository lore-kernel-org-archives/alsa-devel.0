From: Alexandre B <wackysalut@bourget.cc>
Subject: arecordmidi and aplaymidi
Date: Mon, 15 Nov 2004 20:26:51 -0500
Message-ID: <200411152026.51451.wackysalut@bourget.cc>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I have a couple of suggestions for arecordmidi and aplaymidi, maybe to the 
last one who sent some patches (Pedro Lopez-Cabanillas) for these programs.

I'd like to use arecordmidi and aplaymidi to pipe MIDI events to a Perl 
script, which in turn would control light spots for a play.

For now, arecordmidi has a --dump option, which suits my needs perfectly, but 
it seems it *has* to save a file. It would be even more fun if the saving of 
the .mid file would be optionnal when --dump is passed. Even though I can 
just delete the file afterwards.

Also.. it would be even better if aplaymidi could just pipe events in text 
form (perhaps another --dump ?) to standard output, just like the 
"arecordmidi --dump" output.. that way.. it would be possible to *save* 
lighting effects into a .midi file.. and recall them back using a single Perl 
script or so, since both outputs (arecordmidi and aplaymidi) would be the 
same.


I'd be very pleased to see those features introduced in the next release!

Thanks to all for your excellent work!


Alexandre Bourget


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
