From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: [Realtek ALC260] Can't enable SPDIF out
Date: Fri, 1 Sep 2006 10:48:01 +0930 (CST)
Message-ID: <200609010118.k811I1KU028677@auster.physics.adelaide.edu.au>
References: <mailman.47611.1157047934.29847.alsa-devel@lists.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <mailman.47611.1157047934.29847.alsa-devel@lists.sourceforge.net>
	from "alsa-devel-request@lists.sourceforge.net" at Aug 31,
	2006 11:12:14 AM
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
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
List-Id: alsa-devel@alsa-project.org

Hi Andreas

First up, please note that my ALC260-equipped laptop doesn't make SPDIF
output available on the laptop itself, so I am unable to test any theories
myself.  This is also the reason why my ALC260 patches from early this
year didn't really touch on SPDIF - I had no way to test them.  The docking
station might have SPDIF but I don't have one of those.

> I've got some additional information. Meanwhile, I compiled the alsa
> sources with debug option, which gives this output in /etc/messages:
> 
> kernel: ALSA hda_intel.c:665: codec_mask = 0x3
> kernel: ALSA patch_realtek.c:4278: hda_codec: Unknown model for ALC260,
> trying auto-probe from BIOS...
> kernel: ALSA hda_codec.c:2154: autoconfig: line_outs=1 (0xf/0x0/0x0/0x0/0x0)
> kernel: ALSA hda_codec.c:2158:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
> kernel: ALSA hda_codec.c:2160:    hp=0x0, dig_out=0x18, din_in=0x0
> kernel: ALSA hda_codec.c:2168:    inputs: mic=0x12, fmic=0x0, line=0x0,
> fline=0x0, cd=0x16, aux=0x0

Hmm, interesting.  I notice that the digital output is in fact being
identified.  That's a good start; it probably means a pcm interface is
also being created for it.

> I tested the different modes, which can be found in the documentation for
> ALC260 - none works, because none of them knows anything about S/PDIF.

This is most likely because the authors of those modes - like me - had
no way to test SPDIF on their hardware.

Back to your tests: when you tried to get SPDIF output what command line 
were you using to send audio to it?

With the ALC260 chip the digital output is totally separate to the analog
DAC.  If, for example, you were tryiung to test SPDIF by sending audio data
to the same pcm interface as you use to get analog audio output there's no
way SPDIF will work.  This might be something worth looking into if you
haven't already.  When testing SPDIF output make sure you're sending to the
pcm interface associated with the SPDIF (digital) output.

If you have done all the above and are definitely sending audio to the pcm
associated with the digital output then we have to look deeper.  This will
involve using the "test" model (available only when alsa is compiled with
"--enable-debug".  However, my quick reading of alsa-driver 1.0.12 seems to
suggest that the digital I/Os are not active in the test model (which I
think you've already confirmed).  I will try to have a look at this over the
weekend.  In the meantime, you could try the following completely
untested patch and see if it gives you access to digital pcms in
test mode.

--- patch_realtek.c-orig        2006-08-24 04:05:39.000000000 +0930
+++ patch_realtek.c     2006-09-01 10:27:30.000000000 +0930
@@ -4028,7 +4028,9 @@
		.init_verbs = { alc260_test_init_verbs },
		.num_dacs = ARRAY_SIZE(alc260_test_dac_nids),
		.dac_nids = alc260_test_dac_nids,
+		.dig_out_nid = ALC260_DIGOUT_NID, 
		.num_adc_nids = ARRAY_SIZE(alc260_test_adc_nids),
+		.dig_in_nid = ALC260_DIGIN_NID,
		.adc_nids = alc260_test_adc_nids,
		.num_channel_mode = ARRAY_SIZE(alc260_modes),
		.channel_mode = alc260_modes,

Since I have not looked into the digital I/O side of these codecs at
all I don't know if this is all that's needed.

Once we get digital I/O functionality into the test model it will be a case
of trying the various mixer controls to see if any of them enable SPDIF
output.  The test model creates alsamixer controls for every "control"
provided by the ALC260 chip so there's lots to play with.  Given past
experience with Acer laptops, it would not surprise me to find that your
laptop uses one of the GPIO controls to switch SPDIF output to the output
jack.  For this reason I would start with the GPIO controls.

Regards
  jonathan

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
