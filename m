From: Daniel Pouzzner <douzzer@mega.nu>
Subject: Re: 192khz working for anyone?  and  RME96 patch broke
Date: Wed, 29 Jan 2003 01:18:06 -0500 (EST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301290618.h0T6I6k95459@mail.mega.nu>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tiwai@suse.de
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>what is the kernel message?

Ah ha.

  ALSA ../../alsa-kernel/pci/ice1712/ice1712.c:2472: invalid EEPROM version 120

the driver wants version 1 and barfs on anything else.

If I disable the error-out at that point in the code, here's what
results:

  ALSA ../../alsa-kernel/pci/ice1712/ice1712.c:2472: invalid EEPROM version 120
  ALSA ../../alsa-kernel/pci/ac97/ac97_codec.c:1829: AC'97 0:0 does not respond - RESET [REC_GAIN = 0xffff]
  ice1712: cannot initialize pro ac97, skipped
  devfs_register(unknown): could not append to parent, err: -17
  devfs_register(unknown): could not append to parent, err: -17
  devfs_register(unknown): could not append to parent, err: -17

The module then deals with the card well enough for it to come up in
amixer with read/write access, but not well enough to actually make
sounds.  Only S32_LE is accepted at all, the others producing "aplay:
set_params:1346: Sample format non available".  If S32_LE is used,
aplay and record block for a few seconds, then product

  aplay: pcm_write:1623: write error: Input/output error

or

  arecord: pcm_read:1710: read error: Input/output error


Other glitches:

  douzzer@triceps douzzer $ /usr/sbin/alsactl -f /tmp/bla store 2
  /usr/sbin/alsactl: get_controls:484: snd_ctl_open error: No such device


Clearly more work is needed in the driver.  I'm sure I'm missing some
vital details on the card needed to do it, not to mention, some vital
skills (I'm a hacker of neither the linux kernel nor the ALSA
kernel).


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
