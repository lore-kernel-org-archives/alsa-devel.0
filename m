From: Daniel Schroeder <sec@dschroeder.info>
Subject: ASUS M2N32 MCP55 HDAudio problems
Date: Tue, 27 Jun 2006 22:43:49 +0200
Message-ID: <44A19885.8020104@dschroeder.info>
Reply-To: sec@dschroeder.info
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
Cc: alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello *,

sorry for posting this to devel and users, but i think this could be
interesting for both. Plz. send replies in cc to my mail address because
 i am not on list.

I am a proud owner of this flagship mainboard with a nvdidia mcp55
hdaudio sound card. The chip is identified by alsa as a AD1988A rev.2
(dmesg, lspci -v, lspci -nv output below):

The problem is that if i activate only front in kmix all is fine.
Speaker-Test works as expected. If i activate lfe/center then the sound
is messed up and he plays front-left/front-rigt through center and lfe.

I have played around with differend model settings: 6jack etc. no model
worked.

PLZ: help or if i can help you with my hardware i will do so...i have a
little linux experience and could compile alsa drivers in debugging mode
to play around with this things and hopefully find the right
configuration for this mainboard.

thanks in advance

cheers,

daniel


Hardware: 6 Jacks, spdif and two jacks in front (hp, mic)

Kernel: Gentoo-2.6.17

ALSA
/var/tmp/portage/alsa-driver-1.0.12_rc1/work/alsa-driver-1.0.12rc1/pci/hda/../../alsa-kernel/pci/hda/patch_analog.c:2566:
patch_analog: AD1988A rev.2 is detected, enable workarounds

lspci -v output:

00:0e.1 Audio device: nVidia Corporation MCP55 High Definition Audio
(rev a2)
        Subsystem: ASUSTeK Computer Inc. Unknown device 81f6
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 10
        Memory at fe020000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 2
        Capabilities: [50] Message Signalled Interrupts: 64bit+
Queue=0/0 Enable-
        Capabilities: [6c] HyperTransport: MSI Mapping

lspci -nv output:

00:0e.1 0403: 10de:0371 (rev a2)
        Subsystem: 1043:81f6
        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 10
        Memory at fe020000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 2
        Capabilities: [50] Message Signalled Interrupts: 64bit+
Queue=0/0 Enable-
        Capabilities: [6c] HyperTransport: MSI Mapping



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
