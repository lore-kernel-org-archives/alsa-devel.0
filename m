From: Will <walsac@liam2.demon.co.uk>
Subject: ALSA OSS Midi recording is still broken in 1.0.0rc2
Date: Sun, 7 Dec 2003 11:28:39 GMT
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200312071128.LAA10744@koyuki.liam2.demon.co.uk>
Reply-To: walsac@liam2.demon.co.uk
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="G4iJoqBmSsgzjUCe"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Alsa 1.0.0rc2 OSS Midi is still broken for recording from external MIDI devices.
The time values of note on and note off events are severely corrupted in
MIDI recordings that contain a sequence of chords of two or more different
notes played at the same time.  However, interestingly, MIDI recordings which
contain only a sequence of _single_ notes work ok because the bug was
partially fixed in alsa-driver-0.9.1 released around 15th March 2003.

Only OSS-mode MIDI recording from /dev/sequencer is broken, e.g. using
an OSS client like the old Rosegarden 2.1pl4 (http://www.cannam.demon.co.uk/rosegarden/distribution/rosegarden-2.1pl4.tar.gz or ftp://ftp.cs.bath.ac.uk/pub/dream/ROSE/rosegarden-2.1-sources.tar.gz)
whereas ALSA-mode MIDI recording works fine, e.g. using the new Rosegarden 4 (http://heanet.dl.sourceforge.net/sourceforge/rosegarden/rosegarden-4-0.9.5.tar.bz2)

To reproduce this bug, you'd need a MIDI keyboard for sending external MIDI
events to your soundcard and also an OSS client for MIDI recording
which must be the _old_ version 2.1pl4 of Rosegarden (newer versions of
Rosegarden do not do OSS-mode MIDI recording), preferably my statically
linked Rosegarden 2.1pl4: http://www.liam2.demon.co.uk/rosegarden.static.bz2
(sources http://www.liam2.demon.co.uk/rosegarden.tar.bz2)

I made three OSS MIDI recordings to show how to trigger the bug:

Attachment #1: I repeatedly played the ascending notes of the scale of C-major
(or whatever name your locale gives to a 440Hz pitch) one note at a time
at a speed of roughly 1 note/second for about 12 seconds;
this recording plays correctly from beginning to end.

Attachment #2: I played the notes C and E together repeatedly at a
regular speed of roughly 2 chords/second for about 20 seconds;
observe the very irregular, incorrect timing of the recorded notes.

Attachment #3: I repeatedly played the notes C, E and G together at a regular
speed of roughly 2 chords/second for about 20 seconds; notice again the very
irregular, incorrect timing of the notes and also how the MIDI file
has been stretched from 20 seconds of true playing time to over 3 minutes
in playback length.

It is actually the same old bug I reported with full details in my email as
bug #1 ("Every MIDI file recording ... has invalid time ...") with the subject
"[Alsa-devel] Invalid MIDI recordings and silent external playback"
on 26th August 2002.  Please ignore the other bugs mentioned in that email
such as silent external MIDI playback because these have been fixed since
alsa-driver-0.9.1 (external playback is ok using "playmidi -e -D 0 file.mid").

Subject: [Alsa-devel] Invalid MIDI recordings and silent external playback
URL: hhttp://www.geocrawler.com/mail/thread.php3?subject=%5BAlsa-devel%5D+Invalid+MIDI+recordings+and+silent+external+playback&list=12349
Additional explanations in two followups on 15th November 2002 with
Subject: [Alsa-devel] OSS-mode invalid MIDI recordings and silent external playback
http://www.geocrawler.com/mail/thread.php3?subject=%5BAlsa-devel%5D+OSS-mode+invalid+MIDI+recordings+and+silent+external+playback&list=12349
Subject: [Alsa-devel] Re: OSS-mode invalid MIDI recordings and silent external playback

Maybe this bug is easy-to-fix so it won't be a showstopper for a 1.0.0 release
but it's been around a very long time, at least since ALSA-0.3.0pre4 in 1999.
I don't know the ALSA driver source well enough to be able to find it.

Thanks,

Will


--G4iJoqBmSsgzjUCe
Content-Type: audio/midi
Content-Disposition: attachment; filename="oss1-nobug.mid"
Content-Transfer-Encoding: base64

TVRoZAAAAAYAAQABAeBNVHJrAAAA4Io2lzxzg3OHPH9qlz5wg3OHPn8Tl0BjhEpBWROHQH+C
bUF/gS2XQ2WEI0VZJodDf4MKRX+BBpdHaYF6h0d/gimXSEqBSodIf4JjlzxBggOHPH+CF5c+
ToFAhz5/gkaXQFGBGodAf4JQl0FAc4dBf4J2l0NIYIdDf4Mdl0VZQ4dFf4MUl0dOTIdHf4M6
l0hZQ4dIf4MdlzxVgRCHPH+CY5c+VleHPn+CbJdASk2HQH+DCpdBRFaHQX+Cd5dDSWCHQ3+D
E5dFUVaHRX+CbZdHUGCHR3+DHZdIVH2HSH8A/y8A

--G4iJoqBmSsgzjUCe
Content-Type: audio/midi
Content-Disposition: attachment; filename="oss2-buggy.mid"
Content-Transfer-Encoding: base64

TVRoZAAAAAYAAQABAeBNVHJrAAABGIhGlzxeOkBuiQmHPH8TQH+CUJc8XRRAaYwwhzx/CUB/
gkeXPFoJQGI6hzx/E0B/giCXPFoKQGk5hzx/E0B/giqXPF4KQGlDhzx/CUB/gjSXPFkAQGiY
Q4c8fwlAf4I0lzxfAEBum0OHPH8JQH+CIJc8XQpAaEOHPH8KQH+CM5c8XwpAaTmHPH8TQH+C
Kpc8XgpAZUOHPH8TQH+CIJc8VgpAY0OHPH8TQH+CDZc8WglAY0SHPH8TQH+CFpc8XidAaa0m
hzx/E0B/giCXPF0KQGVDhzx/E0B/ggOXPFYKQGNNhzx/E0B/gg2XPFkJQGNEhzx/HEB/ggSX
PFRgQF64bIc8fx1Af4IqlzxWCUBjTYc8fxNAfwD/LwA=

--G4iJoqBmSsgzjUCe
Content-Type: audio/midi
Content-Disposition: attachment; filename="oss3-verybuggy.mid"
Content-Transfer-Encoding: base64

TVRoZAAAAAYAAQABAeBNVHJrAAAB8Yp5lzxVB0NWAEBiAIdAf4xzPH8dQ3+BeZc8XgpDX21A
aQCHQH+QeTx/E0N/giqXPF1KQ2UAQGmVCYc8fwpDfwlAf4IqlzxZCkNjMEBomQaHPH8KQ38J
QH+CUJc8WRdDaABAaZ0Dhzx/E0N/E0B/glCXPFUHQ18AQGihAIc8fwlDfwpAf4Jtl0NeADxR
pAlAYoEHh0N/Ezx/CUB/gwCXPFRUQ2KoNkBjgQaHPH8KQ38KQH+CY5dDYgk8UURAY61gh0N/
CTx/CkB/glCXPFU9Q1+wTEBjNIdAf7FmPH8TQ3+CbZc8WRpDZbRwQGgQh0B/tXY8fxNDf4MK
l0NfbTxWuRxAY4EQh0N/FDx/CUB/glqXQ2MJPFYKQGOBEIdDfwo8fxNAf4Jtl0NjMDxUwVlA
Y4Ejh0N/FDx/CUB/glCXQ2MKPFYNQGgAh0B/xwNDfx08f4J2lzxdakNoAEBoy1aHPH8TQ38K
QH+CKZc8WWRDYwBAaACHQH/PXDx/FEN/glCXPF5AQ2PSSUBrN4dAf9NjPH8TQ3+Cdpc8WRRD
YwBAaQCHQH/YBjx/E0N/gwCXPFpnQ2XbI0BpXYdAf9wzPH8TQ3+DAJc8WTpDXwBAY+B8hzx/
CkN/CkB/gmOXPFQNQ2LjfEBlg2qHPH8KQ38JQH8A/y8A

--G4iJoqBmSsgzjUCe--



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
