From: Mark J Roberts <mjr@znex.org>
Subject: Audigy2 test results.
Date: Wed, 5 Feb 2003 03:51:09 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030205095109.GA198@znex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

alsa-{kernel,lib} cvs, kernel 2.5.49, audigy2 platinum.

Output jack adjacent to firewire connector works; "Wave	Surround"
volume control functions normally.

The next jack over also works; its left and right channel volumes
are controlled independently by "Wave LFE" and "Wave Center".

The output levels of all these jacks seems 12db lower than the main
output of my audigy1. I suspect this is normal and has something to
do with the 12db boost option I read about. The sound quality seems
good. The noise floor seems lower than the old card.

All controls may be turned to zero save for "Wave LFE", "Wave
Center", or "Wave Surround"; it will work fine, and the other
controls, like "Master" and "PCM", have no effect.

The next jack is always silent; the "Wave" control (my guess as to
what should be controlling it) does nothing. However, the livedrive
headphone output _does_ work, and _is_ volume-controlled properly by
"Wave". (Its output level is no higher than the other two jacks,
which reminds me of something I read in an audigy1 review - that the
headphone output was weaker than the line1 output.)

Both joystick and livedrive MIDI outputs work, but neither MIDI
input will read anything. I've tried plugging in a keyboard and also
directly looping one of the outputs to one of the inputs, to no
effect.

Livedrive RCA-SPDIF output works, but it's possible to get weird
distortion (sounds like chimey bell tone things accentuating the
music) if I configure the mixer certain ways. What's needed to make
it work is to simply turn up "Wave"; everything else may be off. If
I turn up "PCM" the weird chime distortion starts. (Addendum: I
can't reproduce this reliably, so it may depend on other state.)

arecord seems capable of recording audio that I'm playing from a
mp3, at the exact level I'm playing it.

So, that's all the testing I've done thus far. Maybe somebody will
find this useful. Meanwhile, I'll try to get the MIDI input going
by... umm. Staring at it real hard, maybe? Oh well.


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
