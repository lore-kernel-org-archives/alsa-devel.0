From: Andreas Mohr <andim2@users.sourceforge.net>
Subject: [PATCH] Huge AZT3328 driver update
Date: Sun, 23 Oct 2005 19:54:55 +0200
Message-ID: <20051023175455.GA4087@rhlx01.fht-esslingen.de>
Reply-To: andi@lisas.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Cc: Takashi Iwai <tiwai@suse.de>, andi@lisas.de
List-Id: alsa-devel@alsa-project.org

[slightly improved patch (improved and more precise rate support) remailed and
CC'd to Takashi since my more recent mails don't seem to make it to the list
for some very strange reason]

Hello all,

this is now an even much more reworked patch (#3) for my azt3328.c ALSA driver.
IOW I spent another 4 evenings to get the sequencer timer to work properly
(my head is still hurting) and do lots of other cleanups.

Note that despite the extensive sequencer timer additions, the driver object
is still only 2kB bigger than the previous version, due to those many
optimizations...

Changes in version #3:
- fully working ALSA sequencer timer support for the card's 1024000Hz
  DirectX timer (downscaling adjustable via seqtimer_scaling module param)
- an insane amount of code optimizations
- many, many cleanups

Changes in version #2:
- FOUND the 1us DirectX timer area (yay!), made the code respect it
properly
- renamed some "weird" mixer control names according to ControlNames.txt
- cleanup unneeded debug messages, reformatting
- improved I/O register documentation
- constified many more structs

Changes in version #1:
- improves/fixes some fatal playback/recording interaction
- improves IRQ handler performance (and actually fixes some weird code)
- coalesces some I/O accesses
- slightly improves I/O interface documentation
- improves/fixes logging
- defines out some less important debug code
- constifies some data

Both playback and recording are working nicely, MIDI playback with
card's onboard sequencer timer is working fine, too.
I consider this driver version to be almost perfect now, certainly better
than the original Windows driver which didn't include support for the
DirectX timer hardware...
The only remaining work areas would be power management and maybe some
odd remaining quirks that may be discovered from time to time.

Diff against current CVS, please commit (this new version is infinitely
better compared to the current still relatively buggy ALSA driver).

Thanks!

Andreas Mohr

Signed-off-by: Andreas Mohr <andi@lisas.de>
(those updates done by me, and me alone)


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
