From: Brian Victor <bhv1@psu.edu>
Subject: Sequencer Input
Date: Tue, 17 Dec 2002 19:06:09 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021218000609.GB12303@bhv1.adelphia.net>
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
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

I'm using a MidiSport 1x1 and devfs.  The modules are loading, pmidi is
displaying the MidiSport and playing MIDI files through it just fine, so
I presume output through /dev/snd/seq is working.  cat /dev/snd/midiC0D0
displays approrpriate "garbage" characters, but cat /dev/snd/seq does
nothing, and the seqdemo.c sample just sits there.  What do I need to do
to get this working?  This is with RC6.

Relevant modules:

snd-seq-midi            3136   0 (autoclean)
snd-seq-oss            23456   0 (unused)
snd-seq-midi-event      3240   0 [snd-seq-midi snd-seq-oss]
snd-seq                39312   2 [snd-seq-midi snd-seq-oss snd-seq-midi-event]
usb-ohci               18088   0 (unused)
snd-usb-audio          32704   0
snd-pcm                58304   0 [snd-usb-audio]
snd-timer              11080   0 [snd-seq snd-pcm]
snd-rawmidi            12800   0 [snd-seq-midi snd-usb-audio]
snd-seq-device          3776   0 [snd-seq-midi snd-seq-oss snd-seq snd-rawmidi]
snd                    27020   0 [snd-seq-midi snd-seq-oss snd-seq-midi-event
snd-seq snd-usb-audio snd-pcm snd-timer snd-rawmidi snd-seq-device]
soundcore               3908   4 [snd]

Thanks,

-- 
Brian


-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
