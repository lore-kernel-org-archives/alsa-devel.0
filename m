From: Josh Buhl <uzs33d@uni-bonn.de>
Subject: aplay/arecord hang at 44100 Hz
Date: Mon, 10 Feb 2003 10:16:08 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E476DD8.7050907@uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Hello,

When attempting to record at 44100Hz (arecord -f cd), the process hangs
at 100% cpu load.  It works fine if called at 48000 (arecord -f dat).

Similarly, aplay hangs at 100% cpu load when trying to play a wav file
recorded at 44100 Hz. If I use sox to resample the wav to 48000 Hz then
aplay can play it just fine. Both esdcat and xmms  _are_  able to play
the same 44100Hz files which cause aplay to hang.

I have the alsa modules compiled with ALSA_DEBUG="y" but I don't get any
debug info, at least neither in /var/log/syslog nor in
/var/log/messages, should I be looking elsewhere?

I'm using alsa-0.9rc7 on Debian 3.0r1 running kernel 2.4.20 on an AMD
1800+ Elitegroup K7S5A with SIS 7012 sound on board (intel8x0 driver.)



Josh







-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
