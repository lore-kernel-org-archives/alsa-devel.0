From: David Garcia Garzon <dgarcia@iua.upf.es>
Subject: Re: Alsa sequencer port type flags
Date: Wed, 10 Dec 2003 13:35:39 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200312101335.39428.dgarcia@iua.upf.es>
References: <200312101113.52566.david.garcia@iua.upf.es> <3FD70734.6060502@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3FD70734.6060502@boosthardware.com>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

A Dimecres 10 Desembre 2003 12:44, Patrick Shirkey va escriure:
> David Garcia Garzon wrote:
> > (Context: Keep doing with the sequencer chapter of the Alsa user
> > conceptual model, an spanish documentation to be translated soon, at:
> > http://www.salleurl.edu/~is04069/Modders/Docs/alsadoc-sequencer.html)
>
> Nice work. I have added a link to the docs page. Let us know if you need
> it hosted permanently.

Thanks a lot. :-) Notice that the link i wrote was only the sequencer chapter, 
the full document to link at is:
http://www.salleurl.edu/~is04069/Modders/Docs/alsadoc.html
But, most chapters are not as complete as sequencer chapter :-( i'll keep 
working on them.

Back to the question. Anybody knows about the usefulness of sequencer port 
types?
The API docs specifies that values:
<quote>
Each port has also the type bitmasks defined as follows:
SND_SEQ_PORT_TYPE_SPECIFIC Hardware specific port
SND_SEQ_PORT_TYPE_MIDI_GENERIC Generic MIDI device
SND_SEQ_PORT_TYPE_MIDI_GM General MIDI compatible device
SND_SEQ_PORT_TYPE_MIDI_GS GS compatible device
SND_SEQ_PORT_TYPE_MIDI_XG XG compatible device
SND_SEQ_PORT_TYPE_MIDI_MT32 MT-32 compatible device
SND_SEQ_PORT_TYPE_SYNTH Synth device
SND_SEQ_PORT_TYPE_DIRECT_SAMPLE Sampling device (supporting download)
SND_SEQ_PORT_TYPE_SAMPLE Sampling device (sample can be downloaded at any 
time)
SND_SEQ_PORT_TYPE_APPLICATION Application (sequencer/editor)
A port may contain specific midi channels, midi voices and synth voices. These 
values could be zero as default.
</quote>

But which are the implications of setting up a port with such flags?
- Are they merely informative?
- Will Alsa coerce or enhance the port usage depending on that type?
- Can the user see that information in any way?


-- 
David García Garzón <david.garcia@removespam.iua.upf.es>
Phone: 034 93 542 21 99
Music Technology Group, Institut Universitari de l'Audiovisual
Universitat Pompeu Fabra



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
