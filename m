From: Mardy <mardy@users.sourceforge.net>
Subject: [Application] OPL3 with hwdep
Date: Sun, 12 Jan 2003 20:01:51 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030112190151.GA2057@pupilla>
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

I want to make a simple OPL3 beeper, but I'm stuck with
snd_hwdep_open(), I just don't know what string I should call it with.

pupilla:~$ cat /proc/asound/cards 
0 [CARD_0         ]: CMI8738-MC6 - C-Media PCI CMI8738-MC6
                     C-Media PCI CMI8738-MC6 (model 55) at 0xb800, irq 9
pupilla:~$ cat /proc/asound/hwdep 
00-00: OPL3 FM
pupilla:~$ cat /proc/asound/devices 
  0: [0- 0]: ctl
  8: [0- 0]: raw midi
 18: [0- 2]: digital audio playback
 26: [0- 2]: digital audio capture
 17: [0- 1]: digital audio playback
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
  4: [0- 0]: hardware dependent
  1:       : sequencer
 33:       : timer

I've tried lots of combinations, but it always fail... :-(

-- 
Saluti,
    Mardy
http://castellina.org/interlingua


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
