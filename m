From: Frank Neumann <beachnase@web.de>
Subject: Need some hints for simple MIDI communication
Date: Fri, 8 Feb 2002 00:55:33 +0100
Message-ID: <E16YyMU-00028E-00@smtp.web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,
I would like to know how I go about creating a small program that lets
me send /received patch sets ("banks") into my synthesizers via SysEx MIDI
communication.

I know all about the actual required SysEx parameters, and I had also once
written such a program for OSS (simply using read()/write() to/from
/dev/midi), but now I'd like to port this to ALSA.

As far as I can tell, there is either the "rawmidi" interface or the
more complex(?) way by going through snd_seq_open(...).

I have some problems with rawmidi; if I try the test program from the
current (0.9.0beta10) alsa-lib source the way it suggests, I always get:

franky@faramir:/u1/src/ALSA/0.9.0beta10/alsa-lib-0.9.0beta10/test> ./rawmidi -i 0 0
ALSA lib rawmidi.c:184:(snd_rawmidi_open_noupdate) Unknown RawMidi 0
snd_rawmidi_open 0 failed: -2

The snd-rawmidi module is loaded, though, and cat /proc/asound/devices gives:

  0: [0- 0]: ctl
  4: [0- 0]: hardware dependent
  8: [0- 0]: raw midi
 19: [0- 3]: digital audio playback
 26: [0- 2]: digital audio capture
 25: [0- 1]: digital audio capture
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
  1:       : sequencer
  9: [0- 1]: raw midi
 10: [0- 2]: raw midi
 33:       : timer
 32: [1- 0]: ctl
 40: [1- 0]: raw midi
 49: [1- 1]: digital audio playback
 48: [1- 0]: digital audio playback
 56: [1- 0]: digital audio capture

Is there anything wrong about rawmidi? Is this driver "orphaned", or is the
demo app incompatible with the current interface?

Anyway, I believe going with the sequencer is the better solution anyway;
for this one, I'd like to get some _short_ setup hints, a la
"first create a port, then connect foo to bar, create an xxx event structure,
fill it with data and send that off to your port with snd_xxx".
Could anyone give me such a setup list, or point me at a source that does
something like this in an as readable as possible fashion? I believe I can
find out the rest, I just need someone to get me started in the right
direction :-).

Thanks,
Frank

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
