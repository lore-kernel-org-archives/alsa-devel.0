From: Philip Prindeville <philipp_subx@redfish-solutions.com>
Subject: Last set of diffs for vt1617, etc.
Date: Sat, 13 Aug 2005 15:22:35 -0600
Message-ID: <42FE649B.70805@redfish-solutions.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030407040504070404090106"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
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

This is a multi-part message in MIME format.
--------------030407040504070404090106
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ok, so these are the changes for the changed PCI id
for the K8MM-V motherboard and the VT1617A codec.

I still get the warnings, however, about the device not being
able to accept 44.1kHz audio and having to send it at 48kHz
instead.  I suspect that this is a configuration file issue instead.

I tried forcing the patch_vt1617a() routing to set:

    ac97->rates[AC97_RATES_SPDIF] = SNDRV_PCM_RATE_44100;

and it still complained about:

[root@media ~]# aplay -v  -Dhw:0,0 
/usr/share/system-config-soundcard/sound-sample.wav
Playing WAVE '/usr/share/system-config-soundcard/sound-sample.wav' : 
Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
Warning: rate is not accurate (requested = 44100Hz, got = 48000Hz)
        please, try the plug plugin (-Dplug:hw:0,0)
Hardware PCM card 0 'VIA 8237' device 0 subdevice 0

so that might be an orthogonal issue.

-Philip



--------------030407040504070404090106
Content-Type: text/x-patch;
 name="vt1617.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vt1617.patch"

*** alsa-kernel/pci/via82xx.c.bak	2005-05-27 04:10:18.000000000 -0600
--- alsa-kernel/pci/via82xx.c	2005-08-12 13:50:42.000000000 -0600
***************
*** 932,943 ****
  
  	if ((rate_changed = via_lock_rate(&chip->rates[0], ac97_rate)) < 0)
  		return rate_changed;
! 	if (rate_changed) {
  		snd_ac97_set_rate(chip->ac97, AC97_PCM_FRONT_DAC_RATE,
  				  chip->no_vra ? 48000 : runtime->rate);
! 		snd_ac97_set_rate(chip->ac97, AC97_SPDIF,
! 				  chip->no_vra ? 48000 : runtime->rate);
! 	}
  	if (runtime->rate == 48000)
  		rbits = 0xfffff;
  	else
--- 932,943 ----
  
  	if ((rate_changed = via_lock_rate(&chip->rates[0], ac97_rate)) < 0)
  		return rate_changed;
! 	if (rate_changed)
  		snd_ac97_set_rate(chip->ac97, AC97_PCM_FRONT_DAC_RATE,
  				  chip->no_vra ? 48000 : runtime->rate);
!         if (chip->spdif_on && viadev->reg_offset == 0x30)
! 		snd_ac97_set_rate(chip->ac97, AC97_SPDIF, runtime->rate);
! 
  	if (runtime->rate == 48000)
  		rbits = 0xfffff;
  	else
***************
*** 2170,2175 ****
--- 2170,2176 ----
  		{ .vendor = 0x1297, .device = 0xc160, .action = VIA_DXS_ENABLE }, /* Shuttle SK41G */
  		{ .vendor = 0x1458, .device = 0xa002, .action = VIA_DXS_ENABLE }, /* Gigabyte GA-7VAXP */
  		{ .vendor = 0x1462, .device = 0x0080, .action = VIA_DXS_SRC }, /* MSI K8T Neo-FIS2R */
+ 		{ .vendor = 0x1462, .device = 0x0430, .action = VIA_DXS_SRC },    /* MSI K8MM-V onboard audio */
  		{ .vendor = 0x1462, .device = 0x3800, .action = VIA_DXS_ENABLE }, /* MSI KT266 */
  		{ .vendor = 0x1462, .device = 0x5901, .action = VIA_DXS_NO_VRA }, /* MSI KT6 Delta-SR */
  		{ .vendor = 0x1462, .device = 0x7023, .action = VIA_DXS_NO_VRA }, /* MSI K8T Neo2-FI */
*** alsa-kernel/pci/ac97/ac97_codec.c.bak	2005-04-25 04:22:20.000000000 -0600
--- alsa-kernel/pci/ac97/ac97_codec.c	2005-08-11 12:56:59.000000000 -0600
***************
*** 157,162 ****
--- 157,163 ----
  { 0x54524123, 0xffffffff, "TR28602",		NULL,		NULL }, // only guess --jk [TR28023 = eMicro EM28023 (new CT1297)]
  { 0x54584e20, 0xffffffff, "TLC320AD9xC",	NULL,		NULL },
  { 0x56494161, 0xffffffff, "VIA1612A",		NULL,		NULL }, // modified ICE1232 with S/PDIF
+ { 0x56494170, 0xffffffff, "VIA1617A",		patch_vt1617a,	NULL }, // modified VT1616 with S/PDIF
  { 0x57454301, 0xffffffff, "W83971D",		NULL,		NULL },
  { 0x574d4c00, 0xffffffff, "WM9701A",		NULL,		NULL },
  { 0x574d4C03, 0xffffffff, "WM9703,WM9707,WM9708,WM9717", patch_wolfson03, NULL},
*** alsa-kernel/pci/ac97/ac97_patch.c.bak	2005-05-27 03:42:45.000000000 -0600
--- alsa-kernel/pci/ac97/ac97_patch.c	2005-08-12 17:45:05.000000000 -0600
***************
*** 558,563 ****
--- 558,572 ----
  }
  
  /*
+  * VT1617A codec
+  */
+ int patch_vt1617a(ac97_t * ac97)
+ {
+ 	ac97->ext_id |= AC97_EI_SPDIF;	/* force the detection of spdif */
+ 	return 0;
+ }
+ 
+ /*
   * Sigmatel STAC97xx codecs
   */
  static int patch_sigmatel_stac9700_3d(ac97_t * ac97)
*** alsa-kernel/pci/ac97/ac97_patch.h.bak	2005-04-07 08:53:20.000000000 -0600
--- alsa-kernel/pci/ac97/ac97_patch.h	2005-08-11 12:56:59.000000000 -0600
***************
*** 56,60 ****
--- 56,61 ----
  int patch_cm9761(ac97_t * ac97);
  int patch_cm9780(ac97_t * ac97);
  int patch_vt1616(ac97_t * ac97);
+ int patch_vt1617a(ac97_t * ac97);
  int patch_it2646(ac97_t * ac97);
  int mpatch_si3036(ac97_t * ac97);

--------------030407040504070404090106--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
