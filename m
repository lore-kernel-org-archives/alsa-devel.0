From: Richard Bown <bownie@bownie.com>
Subject: ANNOUNCE: Rosegarden-4 v0.2.0 released
Date: Fri, 9 Aug 2002 16:59:24 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200208091659.24601.bownie@bownie.com>
Reply-To: bownie@bownie.com
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: linux-audio-dev@music.columbia.edu, linux-audio-announce@music.columbia.edu, alsa-devel@alsa-project.org, alsa-user@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The Rosegarden development team would like to announce the release of
Rosegarden-4 v0.2.0 - a sequencer and music notation editor for Linux.

This is a pre-beta release and while not yet stable enough for end-users it
has many interesting features and is suitable for Audio and MIDI recording,
playback and editing and notational composition.  The project is approaching
a beta testing phase and this release represents a first step towards
completion of all major parts of the intended functionality.

For the source tarball, mailing list, FAQ and developer and end-user information
please go to the project homepage:

  http://www.all-day-breakfast.com/rosegarden/

Major features of this release:

- Multiple mono audio tracks supported through JACK with audio VU meters
- Some significant improvements to notation layout of simple
  contrapuntal staffs
- WAV file loading/saving including BWF format peak files
- Audio Manager dialog: sortable list of audio files in projects including
  child segments
- Configuration pane for notation editor
- Audio VU meters including live preview of audio levels
- "smooth-move" modifier (Shift) for matrix tools
- Event list view with event type filtering and event editing
- Support for PitchBends, Controller events, also better but not yet complete
  support for System Exclusives, Pressure events.
- Various new notation commands (Cut and Close, Untie Notes)
- Sweep selection of Segments on main canvas
- Sweep selection and multiple event movement on matrix view
- Progress dialogs
- Semi-automatic syncing of audio and MIDI using JACK latency sliders
- Audio segment splitting, including auto splitting to a threshold
- Event playback on selection movement in Notation and Matrix view
- Track addition/deletion
- Added tempo ruler to main window as well as notation window
- Non-destructive Segment resize (through Segment end markers)
- Rescale Segment command
- Initial support for user-configurable notation styles, such
  as different note head shapes and tail count.  Provided
  a selection of default styles that can be applied in the
  notation editor.  (No style editor yet, edit the XML files.)
- Rather flaky support for grace notes
- Text annotations in cute yellow boxes in notation
- Slashes now available on note stems
- Notation can now show notes that needed smoothing quantize
  in another colour (namely, green)
- FAQ and the beginnings of the first Help documentation
- Set tempo event to length of segment
- Audio visual preview - waveform shown on Segments 
- Incomplete support for BWF files
- Build admin/ directories tidied.
- Repeating Segments improved







-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
