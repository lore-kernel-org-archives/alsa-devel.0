From: <maniacdavid@cableone.net>
Subject: Audigy2 Status/Help
Date: Mon, 19 May 2003 13:00:16 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <2265a01c31e41$44429e70$2c00740a@cableone.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Class: urn:content-classes:message
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

 I have an Audigy2 Platinum eX. I have been trying to get the alsa card =
to recognize it. I have been compiling the 2.5 kernel and 2.4 kernel =
tons of times to see if anything would work. I still can not get it to =
work. I can get the emu10k1-cvs drivers to work right away. I really =
need ALSA because I'm going to be doing a lot of audio editing with jack =
applications.

I would like to know if there is ANY Audigy2 support in the drivers? I =
go through the source code and there were references to "Audigy2".  Has =
anyone got this working and with what version (reg., plat, plat. ex)?

I use 2.4.20-ac2 kernel. (although I have tried 2.5.69 and =
2.4.20vanilla).  I think what I have kind of noticed is that it all =
comes back to the ac97 stuff. I have been using the latest =
alsa-driver-0.9.3a(and b) as well as tried the alsa-drive-0.9.2. The =
kernel has compiled in sound and no oss. (I have tried sound as a module =
as well).
It seems like other people get it working but maybe that's because they =
have just a regular audigy2 and not the eX.

When I "modprobe snd-emu10k1" I get the following:

/lib/modules/2.4.20/kernel/sound/pci/emu10k1/snd-emu10k1.o: init_module: =
No such device
Hint: insmod errors can be caused by incorrect module parameters, =
including invalid IO or IRQ parameters.
You may find more information in syslog or the output from dmesg
/lib/modules/2.4.20/kernel/sound/pci/emu10k1/snd-emu10k1.o: insmod =
/lib/modules/2.4.20/kernel/sound/pci/emu10k1/snd-emu10k1.o failed
/lib/modules/2.4.20/kernel/sound/pci/emu10k1/snd-emu10k1.o: insmod =
snd-emu10k1 failed

This is from /var/log/everything/current (dmesg):

[kernel] EMU10K1/Audigy soundcard not found or device busy
[kernel] ALSA ../../alsa-kernel/pci/ac97/ac97_codec.c:2046: AC'97 0:0 =
does not respond - RESET
[kernel] EMU10K1/Audigy soundcard not found or device busy
[kernel] devfs_mk_dir(snd): using old entry in dir: c1c175c0 ""
[kernel] devfs_register(snd/controlC0): could not append to parent, err: =
-17
[kernel] devfs_register(snd/timer): could not append to parent, err: -17
[kernel] ALSA ../../alsa-kernel/pci/ac97/ac97_codec.c:2046: AC'97 0:0 =
does not respond - RESET
[kernel] EMU10K1/Audigy soundcard not found or device busy

David
maniacdavid@cableone.net


-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
