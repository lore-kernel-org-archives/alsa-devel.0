From: --friar <friar@zendragon.com>
Subject: problems loading cmipci module with A7M266-D
Date: Sat, 30 Nov 2002 22:09:37 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200212010309.WAA07518@www.zendragon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-ID: <7508.1038712177.1@localhost>
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

Ok, I've now tried both the 0.9.0rc6 and just built the latest
version from cvs, neither module works.  I am running Slackware and
have compiled both the 2.4.20 (SMP) kernel and the modules using the
standard 2.95.3 20010315 (release) gcc.

"lspci -v" gives:
02:04.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
        Subsystem: Asustek Computer, Inc.: Unknown device 8077
        Flags: bus master, stepping, medium devsel, latency 32
        I/O ports at c800 [size=256]
        Capabilities: [c0] Power Management version 2

With "modprobe snd-cmipci" I get:
/lib/modules/2.4.20/kernel/sound/pci/snd-cmipci.o: init_module: No such device

various "ls -ld /dev/dsp" gives:
jolt# ls -ld /dev/dsp
lrwxrwxrwx    1 root     root            9 Nov 30 21:52 /dev/dsp -> /dev/dsp0
jolt# ls -ld /dev/dsp0
crw-rw-rw-    1 root     root      14,   3 Nov 30 21:52 /dev/dsp0
jolt# ls -ld /dev/dsp1 
crw-rw-rw-    1 root     root      14,  19 Nov 30 21:52 /dev/dsp1


The standard kernel cmpci.o module will load,
but doesn't provide an openable /dev/dsp.

Any ideas?  I'll provide any further information, if needed.
It works fine under Windows 2000.

--friar



-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
