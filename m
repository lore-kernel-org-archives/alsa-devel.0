From: Will <walsac@liam2.demon.co.uk>
Subject: Re: OSS-mode invalid MIDI recordings and silent external playback
Date: Fri, 15 Nov 2002 18:43:58 GMT
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021115184402.A8420@liam2.demon.co.uk>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

For testing the OSS-mode sequencer with OSS-software Rosegarden
for external MIDI instrument recording, please get the
statically linked Rosegarden sequencer from this link
(the link in my previous mail was broken):

      http://www.liam2.demon.co.uk/sequencer.static.bz2

To use:

   bunzip2 sequencer.static
   ./sequencer.static

   Click "Record" in the "File" menu in the sequencer,
   Click "Stop" button,
   Click "Save As" in "File" menu to save MIDI recording in a file

Incidentally, a full Rosegarden tar package with dynamically linked and
statically linked versions of both Rosegarden's main program and the notation
editor are at:
      http://www.liam2.demon.co.uk/rosegarden.tar.bz2
      http://www.liam2.demon.co.uk/rosegarden.static.bz2
      http://www.liam2.demon.co.uk/editor.static.bz2

To use:
      bunzip2 < rosegarden.tar.bz2 | tar -C /usr/local/lib xf -
      or
      tar -C /usr/local/lib jxf rosegarden.tar.bz2

Thanks,

Will



-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
