From: "Andrew Kohlsmith (Mailing List Account)" <aklists@mixdown.ca>
Subject: device naming
Date: Wed, 20 Jan 2010 11:35:11 -0500
Message-ID: <201001201135.11954.aklists@mixdown.ca>
Reply-To: akohlsmith-lists@mixdown.ca
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gromit.mixdown.ca (gromit.mixdown.ca [208.68.91.47])
	by alsa0.perex.cz (Postfix) with ESMTP id ADDA2245D6
	for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2010 17:35:14 +0100 (CET)
Received: from aklaptop.localnet (localhost.localdomain [127.0.0.1])
	by gromit.mixdown.ca (Postfix) with ESMTP id D1D2DE130015
	for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2010 11:33:37 -0500 (EST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Is there a definitive guide to device naming with ALSA? I'm trying to use a 
single device for simultaneous capture and playback but opening different 
device names gives different results and I'm trying to determine which is the 
best to use.

aplay -L output gives front, surround40, surround41, surround50, surround51, 
null and pulse.

Trying to register a playback callback using "pulse" gives a "function not 
implemented" error, although I can open and set all the parameters I need 
(8kHz, 2 channels, 20ms buffers).

I get the same result with "default".  If I use "plughw:0,0" I can capture and 
play audio, but the driver (intel HDA) seems to be very prone to either not 
calling either the playback or capture callback, or throwing an xrun and not 
being able to recover.  This is an otherwise idle core2 machine running Ubuntu 
9.10. Playing with nice or ionice does not seem to affect this "brittleness."

I do not have an ~/.asoundrc, nor do I have anything related to asound in 
/etc.  Moving pulseaudio out of the way doesn't seem to do anything either.

Is there a definitive list of devices and their device filenames so I can stop 
guessing?  /proc/asound/cards just shows card 0 as an Intel HDA, and 
/proc/asound/devices shows the following:

$ cat /proc/asound/devices
  2:        : timer
  3:        : sequencer
  4: [ 0- 2]: digital audio capture
  5: [ 0- 0]: digital audio playback
  6: [ 0- 0]: digital audio capture
  7: [ 0- 1]: hardware dependent
  8: [ 0- 0]: hardware dependent
  9: [ 0]   : control

(0-0 is the only device showing both playback and capture, which is why I'm 
using it, but how do I know that plughw is the correct device filename? I just 
guessed at it due to previous experience trying to get bt audio working with 
ALSA.)

I'm sure I'm doing something incredibly stupid, but I can't seem to find out 
what it is.

-A.
