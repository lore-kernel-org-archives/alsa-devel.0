From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH 1/2] ALSA: add LaCie Firewire Speakers/Griffin FireWave
	surround driver
Date: Mon, 7 Feb 2011 22:56:04 +0100
Message-ID: <20110207225604.3fe43920@stein>
References: <4D46933D.5050609@ladisch.de> <4D4FB7C8.7090501@ladisch.de>
	<4D4FB7F6.8000801@ladisch.de> <20110207154025.13fdeba3@stein>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20110207154025.13fdeba3@stein>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, Jay Fenlason <fenlason@redhat.com>
List-Id: alsa-devel@alsa-project.org

Here are the results of a few quick smoke tests.

First I attached FireWave and Speakers to my Mac mini and booted into OS
X to make sure that this hardware still works.  Both do.  I don't have
Griffin's driver installed.  The FireWave puts out proper stereo sound on
the L/R port, some muffled sound and pops on the C/S port, and nothing on
the LS/RS port.  The Speakers put out a loud tinny sound as expected from
them.

Rebooted into Linux (2.6.38-rc3).  snd_firewire_speakers gets loaded right
after I modprobed firewire-ohci, yet somehow no devices are bound to it.
(I guess I will add some printks here to look closer onto the device
probe under various circumstances.)  Removed the speakers, and perhaps
replugged the FireWave.  They get bound, programs show them as sound
card.  Unloaded the snd_hda_intel driver to make testing easier.

Xine, although configured to the alsa backend, somehow refuses to use the
alsa backend and falls through to jack which doesn't have any devices
present at the moment.  Kaffeine which uses xine as backend pops up a
window that it can't open the sound device.  Audacious complains about
missing mixer and can't use this sound card.

KDE4's hardware control, sound pane, shows the card and lets me play the
test sound on it.  First few seconds are choppy.  Shortly after the test
sound faded I press teh test button again and get a kernel panic:

BUG: unable to handle kernel paging request at [...]
IP: [...] iso_packets_buffer_destroy+0x8/0x1d [snd_firewire_lib]
[...]
Call Trace:
 [...] amdtp_out_stream_stop+0x3b/0x46 [snd_firewire_lib]
 [...]

I will send you a screenshot off list.

Next test:  Plugged the Speakers in, unloaded snd_hda_intel, loaded
firewire-ohci, snd_firewire_speakers now gets bound to devie right away.
Started xine and played a file.  No complaint.  (Hmm, I wonder whether I
had an operator error in my earlier session with FireWave.)  There is the
same problem as in the first KDE4 control panel test:  Playback starts
with an Autechre remix during the first few seconds. ;-)

Subsequent pause/resume or program exit/ program restart of xine do not
feature the choppy lead in anymore.

Audacious again pops up a window titled "ALSA error", saying "No suitable
mixer element found."  But it actually plays back now.

Alas the missing mixer makes the whole affair not quite usable yet:  The
LaCie FireWire Speakers are very loud; too loud for the desk or living
room.  On OS X, I had their volume pulled down to the lowest mark.

No kernel panic yet.

Plugged Speakers out and FireWave in.  Gets bound.  Xine plays back, as
does Audacious (which again first the missing mixer nag window).  Alas
there is choppy noise during the whole playback, with different audio
sources.

Reboot with FireWave plugged in.  Same results as in the session before.
The choppy noise apparently starts as soon as there was a louder part in
the audio stream.  This noise changes is pitch all the time along with the
music.  The Speakers don't seem to have that noise, but I can't really be
sure because the building where I live in is not suitable to test them
longer at full volume, at least not at this time of day.

Still haven't reproduced the aforementioned kernel panic.

-----

By the way, the ALSA subsystem is not sparse-clean if
CF="-D__CHECK_ENDIAN__" is specified in the make command line.  Sparse
gets nervous about __bitwise types being used as integers.
-- 
Stefan Richter
-=====-==-== --=- --===
http://arcgraph.de/sr/

------------------------------------------------------------------------------
The ultimate all-in-one performance toolkit: Intel(R) Parallel Studio XE:
Pinpoint memory and threading errors before they happen.
Find and fix more than 250 security defects in the development cycle.
Locate bottlenecks in serial and parallel code that limit performance.
http://p.sf.net/sfu/intel-dev2devfeb
