From: Richard Bown <bownie@bownie.com>
Subject: ANNOUNCE: Rosegarden-4 v0.1.5 released
Date: Fri, 3 May 2002 10:02:23 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205031002.23255.bownie@bownie.com>
Reply-To: bownie@bownie.com
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id OAA30908
	for <alsa-devel@alsa-project.org>; Fri, 3 May 2002 14:33:23 +0200
Received: from msgdirector2.onetel.net.uk (IDENT:mirapoint@msgdirector2.onetel.net.uk [212.67.96.149])
	by gate.perex.cz (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id LAA20689
	for <alsa-devel@alsa-project.org>; Fri, 3 May 2002 11:07:11 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org, linux-audio-dev@music.columbia.edu
List-Id: alsa-devel@alsa-project.org

[Excuse the cross-posting.  We've added ALSA and KDE3 support
 so I thought it was worth shouting about - just this once]

--

The Rosegarden development team would like to announce the release of
Rosegarden-4 v0.1.5 - a sequencer and music notation editor for KDE2
now with KDE3 and ALSA 0.9 support.

This is an alpha, development release and while not yet suitable for
end-users it has some interesting features and is certainly usable
for composition, MIDI playback and recording.

For the source tarball, mailing list and developer information please
go to the project homepage:

  http://www.all-day-breakfast.com/rosegarden/

Major features of this release:

- KDE3 support (builds from same source tree as KDE2 version)
- ALSA support for MIDI playback and recording (0.9.0beta12 and above)
- Notation View "Finale style" note entry - notes sound before entry
- Triplet and tuplet editing in the Notation view
- Event editor dialog
- Tempo dialog accessed through double click on current tempo,
  new tempo changes can be inserted or overall tempo changed
- Horizontal zooming on track editor
- Internal reworking and tidying of command framework for improved
  undo/redo capability
- Keyboard accelerators for Transport controls shared across all clients
  (you can control playback from client windows)
- Song state information (including Studio parameters) saved to
  Composition file
- Playback Latency can be modified through Configuration dialog
- Instrument program names appear on Track buttons when selected
- Bigger, brighter song position pointers
- MatrixView keyboard now plays notes
- MatrixView Events are coloured by velocity
- Quick copy of Segments (ctrl and click/drag on Segment)
- Segments are labelled according to Track
- Soloing Tracks now works
- Notation and Matrix clients are labelled against the current file
- Notional JACK audio support (not working)

Notes
-----
- Building for KDE3 requires moving admin/ directory, see INSTALL notes

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
