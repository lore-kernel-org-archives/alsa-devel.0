From: "hagman" <hagman@hotbrev.com>
Subject: Confirmation of AzTech PCI 338-A3D (AU8820) support.
Date: Sun, 28 Dec 2003 01:18:30 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <WorldClient-F200312280118.AA18305509@hotbrev.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

In the soundcard database it says that AzTech PCI 338-A3D (AU8820)
support is undermined.
I just wan't to tell you all that it's working for me with the 2.4.22
kernel, Using soundcore as module.
But I can't get it to work on 2.6.0 (seems to be a mixer problem).

00:12.0 Multimedia audio controller: Aureal Semiconductor Vortex 1 (rev
02)
        Subsystem: Aztech System Ltd AU8820 Vortex Digital Audio
Processor
        Flags: bus master, medium devsel, latency 64, IRQ 5
        Memory at effc0000 (32-bit, non-prefetchable) [size=128K]
        I/O ports at da00 [size=8]
        I/O ports at d800 [size=8]
        Capabilities: [dc] Power Management version 1

Please let me know if there is anymore you wan't to know! I wanna help!

2.6.0 Problem info follows.

I'm getting this with the 2.6.0 kernel when I close down alsaconf.
/usr/sbin/alsaconf: line 619: rcalsasound: command not found.

And this when I use alsamixer
alsamixer: function snd_ctl_open failed for default: No such device

aumix pukes this qute error
aumix:  error opening mixer

Some questions if you guys don't mind.
1. Why isn't AU88x0 in the new kernel?
2. Will it be in the kernel soon?
3. Is there a kernel patch?
4. Will there be a patch soon?
5. Can someone make me a patch? pleeeease... *showing puppy-eyes*
6. Which version of alsa-drivers should I try to use for now? (Have only
tried 1.0.0rc2).

http://hagman.trance.nu
hagman@hotbrev.com




__________________________________________________________
http://www.hotbrev.com/ - Nätets farligaste e-postadresser




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
