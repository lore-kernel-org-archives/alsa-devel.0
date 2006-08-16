From: Ben B <kernel@bb.cactii.net>
Subject: hda-intel "nobody cared"
Date: Wed, 16 Aug 2006 21:57:50 +0200
Message-ID: <20060816195750.GA32709@cactii.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
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
List-Id: alsa-devel@alsa-project.org


I've been trying to get pesky suspend/resume working on an HP NC6400
notebook, and have got almost everything worked out except for audio
resume, which is not quite right.

During a suspend, if any process has the DSP devices open, upon resume I
see the following kernel message:

[ 3493.252000] irq 177: nobody cared (try booting with the "irqpoll" option)
[ 3493.252000]  [<c0148bc4>] __report_bad_irq+0x24/0x90
[ 3493.252000]  [<c0148e48>] note_interrupt+0x218/0x250
[ 3493.252000]  [<c0148113>] handle_IRQ_event+0x3 3/0x70
[ 3493.252000]  [<c0148252>] __do_IRQ+0x102/0x120
[ 3493.252000]  [<c0105b41>] do_IRQ+0x31/0x70
[ 3493.252000]  [<c0103bba>] common_interrupt+0x1a/0x20
[ 3493.252000]  [<f8b0a6c9>] acpi_processor_idle+0x1ec/0x37f [processor]
[ 3493.252000]  [<c0101d96>] cpu_idle+0x76/0xd0
[ 3493.252000]  [<c03c4230>] unknown_bootoption+0x0/0x270
[ 3493.252000]  [<c03c47c6>] start_kernel+0x326/0x3b0
[ 3493.252000]  [<c03c4230>] unknown_bootoption+0x0/0x270
[ 3493.252000] handlers:
[ 3493.252000] [<f8979ba0>] (azx_interrupt+0x0/0x150 [snd_hda_intel])
[ 3493.252000] Disabling IRQ #177

If I make sure all DSP-hogging processes are closed before suspend,
things are fine on resume, but this is not practical with current
desktop environments.

I also tried booting with "irqpoll", and yes that basically solved it,
but it made the machine eventually hard freeze.

More info:

bb@gromit:/proc/asound$ cat version
Advanced Linux Sound Architecture Driver Version 1.0.12rc1 (Thu Jun 22
13:55:50 2006 UTC).
bb@gromit:/proc/asound$ cat cards
 0 [Intel          ]: HDA-Intel - HDA Intel
                      HDA Intel at 0xf4780000 irq 177

I tried booting with "acpi=noirq" and the irq changed to 10, and then
upon suspend/resume with dsp open, the next time anything tries to write
to the dsp, the process hangs whilst opening the device.

So I'm hoping that the intel hda driver can be made to handle this a
little more gracefully.

Ben


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
