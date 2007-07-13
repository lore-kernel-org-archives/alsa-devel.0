From: stan <stanl@cox.net>
Subject: Some functionality of ice1724 broken between
 1.0.14.RC1 and 1.0.14.RC3
Date: Fri, 13 Jul 2007 06:23:26 -0700
Message-ID: <20070713062326.22e05830@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_S55_/kvrvlrnkcFgEbWb27."
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fed1rmmtao105.cox.net (fed1rmmtao105.cox.net [68.230.241.41])
	by alsa0.perex.cz (Postfix) with ESMTP id A7C1B24432
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jul 2007 15:23:28 +0200 (CEST)
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao105.cox.net
	(InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
	id <20070713132327.NCGM1399.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>
	for <alsa-devel@alsa-project.org>; Fri, 13 Jul 2007 09:23:27 -0400
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--MP_S55_/kvrvlrnkcFgEbWb27.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

This is going to be fairly long because of the explanations needed, but
there are three problems I've found on my Revolution 5.1 between Alsa
1.0.14.RC1 and 1.0.14.RC3.

1.  Support for high sample rates 96000 and 192000 was lost.
2.  Sound distortion at high sound frequencies was introduced.
3.  The maximum buffer size seems too small for high sample rates (not
      related to release candidate).

Overview 
  On Fedora 6 the alsa version is 1.0.14.RC1.  Using that version,
  my application can use the high frequencies and there is no distortion
  introduced at high frequencies.  On Fedora 7 the alsa version is
  1.0.14.RC3.  I can't use the high frequencies on the Revolution 5.1
  and there is distortion introduced into the sound at high frequencies.
  In investigating this I noticed that the maximum buffer sizes seem
  small.

1.

Here is the output from my app on Fedora 6 at 192000.  (1.0.14.RC1)
This works great!

Minimum channels (1)
Maximum channels (10000)
Minimum rate (4000)  Direction = 0
Maximum rate (4294967295)  Direction = -1
Minimum period_time (10)  Direction = 1
Maximum period_time (2048000)  Direction = 0
Minimum period_size (0)  Direction = 1
Maximum period_size (4294967295)  Direction = -1
Minimum periods (0)  Direction = 1
Maximum periods (4294967295)  Direction = 0
Minimum buffer_time (1)  Direction = 0
Maximum buffer_time (4294967295)  Direction = 0
Minimum buffer_size (1)
Maximum buffer_size (4294967294)
Minimum tick_time (1000)  Direction = 0
Maximum tick_time (1000)  Direction = 0
Actual rate (192000)  Direction = 0
Actual channels (2)
Actual period_size (8)  Direction = 0
Actual buffer_size (8192)      <--- notice that this is reasonable

Here is the output from my app on Fedora 7 at 192000. (1.0.14.RC3)
This aborts while setting the hardware parameters with invalid argument.

Minimum channels (1)
Maximum channels (10000)
Minimum rate (4000)  Direction = 0
Maximum rate (4294967295)  Direction = -1
Rate (48000)  Direction = -1 Result = 0  <-- from test rate
Rate (96000)  Direction = -1 Result = 0
Rate (192000)  Direction = -1 Result = 0  <-- maximum for card hw
Rate (384000)  Direction = -1 Result = 0  <-- accepts invalid 384000
Minimum period_time (21333)  Direction = 1  <-- seems strange the same
Maximum period_time (21334)  Direction = -1
Minimum period_size (85)  Direction = 1
Maximum period_size (91628833)  Direction = -1
Minimum periods (0)  Direction = 1
Maximum periods (17247242)  Direction = -1
Minimum buffer_time (1)  Direction = 0
Maximum buffer_time (4294967295)  Direction = 0
Minimum buffer_size (170)
Maximum buffer_size (1466015503)
Minimum tick_time (0)  Direction = 0
Maximum tick_time (4294967295)  Direction = 0
Actual rate (192000)  Direction = 0
Actual channels (2)
Actual buffer_time (341333)  Direction = 1
Actual buffer_size (65536)
Actual buffer_size (65536)
Actual period_time (21333)  Direction = 1
Actual period_size (807872295)  Direction = 1  <--- Note invalid period
size
Actual periods (21333)  Direction = 1
cannot set parameters (Invalid argument)
Could not open the sound device

The two are on the same hardware, just different OS versions.  While
investigating I switched from using size to time as the allocation
mechanism without any effect (using the sample from pcm.c on alsa site).

I did a diff on the ice1724.c driver (attached below) and noticed that
there was a lot of cleanup done by making the structs and arrays of
structs const.  Could that possibly cause this problem by not allowing
calculated values to be set?  Don't know.  44100 and 48000 work.

I installed the alsa-debuginfo package to try to get a handle on
this in gdb.  But with the extreme indirection in alsa in order to deal 
with all the options and the compiler optimization, gdb left my head
spinning so I thought I would ask here before going any further.
  
Can you think of an explanation for this behavior?  Can you fix it?

2.

I ran a frequency loudness test that is part of the app.  It drops the
frequency at 5 seconds intervals from 20 KHz to 5 Hz alternating.  On
Fedora 6 with 1.0.14.RC1 it works as expected.  When above my hearing
range I hear silence.  When it gets to frequencies I can hear the sound
is pure.  On Fedora 7, this same app produces noise at frequencies I
can't hear.  This behavior is the same as the behavior I noticed with
my emu10k1, ca0106 and CK8S sound cards on 1.0.14.RC1 as well as
1.0.14.RC3.  I previously had ascribed this to bad/low quality sound
chips; now I'm not so sure.  In terms of sound quality the Rev 5.1
ranks well.  See the link

http://compreviews.about.com/od/multimedia/tp/SoundCards.htm

Exact same hardware produces different sound.  Can't explain it.
Can you?  Can you fix it?


3.

While looking at the ice1724.c code I noticed that the maximum buffer
size is 2**18.  This seems small for an application today.  I'm
producing sound at 192000 frames per second (admittedly overkill
though I like very smooth sound) using stereo doubles (16 bytes per
frame). The maximum buffer size is only a fraction of my per second
byte rate.

Could you increase this?


Discussion.

The app is a binaural / chronaural beat generator and is on sourceforge
at 

http://sourceforge.net/projects/discord/

so you can download and run the tests yourself (about a meg).  You
will need libsndfile and libsamplerate installed to compile it.  The
version there won't have the conversion to time based allocation as I
won't release that until this issue is resolved. To change the rate you
change the -r option in the script file high_noon.discord (-r 192000 or
--rate=192000). The run command to use is "./discord
high_noon.discord". For issue 2 you have to run "./discord
frequency_loudness_test.discord". Again change the rate using the -r
option (-r 192000 or -r 96000 fail).

The open_alsa function starts at around line 5610 in discord.c if you
want to play around with the initialization.  I basically cloned it
from the libsndfile samples.

If you aren't familiar with binaural or chronaural beats you can search
for "binaural beat" or "brain wave entrainment" and find more than
you probably want to know.  :-)

Thanks for any help.

--MP_S55_/kvrvlrnkcFgEbWb27.
Content-Type: text/x-patch; name=ice1724_rc1_to_rc3.diff
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=ice1724_rc1_to_rc3.diff

53c53
< 
---
> #include "wtm.h"
66a67
> 	       WTM_DEVICE_DESC
89c90
< static struct pci_device_id snd_vt1724_ids[] = {
---
> static const struct pci_device_id snd_vt1724_ids[] = {
339d339
< 	struct list_head *pos;
343,345c343,344
< 	snd_pcm_group_for_each(pos, substream) {
< 		struct vt1724_pcm_reg *reg;
< 		s = snd_pcm_group_substream_entry(pos);
---
> 	snd_pcm_group_for_each_entry(s, substream) {
> 		const struct vt1724_pcm_reg *reg;
608c607
< 	struct vt1724_pcm_reg *reg = substream->runtime->private_data;
---
> 	const struct vt1724_pcm_reg *reg = substream->runtime->private_data;
623c622
< 	struct vt1724_pcm_reg *reg = substream->runtime->private_data;
---
> 	const struct vt1724_pcm_reg *reg = substream->runtime->private_data;
649c648
< static struct vt1724_pcm_reg vt1724_playback_pro_reg = {
---
> static const struct vt1724_pcm_reg vt1724_playback_pro_reg = {
656c655
< static struct vt1724_pcm_reg vt1724_capture_pro_reg = {
---
> static const struct vt1724_pcm_reg vt1724_capture_pro_reg = {
663c662
< static struct snd_pcm_hardware snd_vt1724_playback_pro =
---
> static const struct snd_pcm_hardware snd_vt1724_playback_pro =
682c681
< static struct snd_pcm_hardware snd_vt1724_spdif =
---
> static const struct snd_pcm_hardware snd_vt1724_spdif =
704c703
< static struct snd_pcm_hardware snd_vt1724_2ch_stereo =
---
> static const struct snd_pcm_hardware snd_vt1724_2ch_stereo =
776c775
< 	runtime->private_data = &vt1724_playback_pro_reg;
---
> 	runtime->private_data = (void *)&vt1724_playback_pro_reg;
805c804
< 	runtime->private_data = &vt1724_capture_pro_reg;
---
> 	runtime->private_data = (void *)&vt1724_capture_pro_reg;
891c890
< static struct vt1724_pcm_reg vt1724_playback_spdif_reg = {
---
> static const struct vt1724_pcm_reg vt1724_playback_spdif_reg = {
898c897
< static struct vt1724_pcm_reg vt1724_capture_spdif_reg = {
---
> static const struct vt1724_pcm_reg vt1724_capture_spdif_reg = {
956c955
< 	runtime->private_data = &vt1724_playback_spdif_reg;
---
> 	runtime->private_data = (void *)&vt1724_playback_spdif_reg;
988c987
< 	runtime->private_data = &vt1724_capture_spdif_reg;
---
> 	runtime->private_data = (void *)&vt1724_capture_spdif_reg;
1093c1092
< static struct vt1724_pcm_reg vt1724_playback_dma_regs[3] = {
---
> static const struct vt1724_pcm_reg vt1724_playback_dma_regs[3] = {
1139c1138
< 	runtime->private_data = &vt1724_playback_dma_regs[substream->number];
---
> 	runtime->private_data = (void *)&vt1724_playback_dma_regs[substream->number];
1320c1319
< static struct snd_kcontrol_new snd_vt1724_eeprom __devinitdata = {
---
> static const struct snd_kcontrol_new snd_vt1724_eeprom __devinitdata = {
1433c1432
< static struct snd_kcontrol_new snd_vt1724_spdif_default __devinitdata =
---
> static const struct snd_kcontrol_new snd_vt1724_spdif_default __devinitdata =
1465c1464
< static struct snd_kcontrol_new snd_vt1724_spdif_maskc __devinitdata =
---
> static const struct snd_kcontrol_new snd_vt1724_spdif_maskc __devinitdata =
1474c1473
< static struct snd_kcontrol_new snd_vt1724_spdif_maskp __devinitdata =
---
> static const struct snd_kcontrol_new snd_vt1724_spdif_maskp __devinitdata =
1519c1518
< static struct snd_kcontrol_new snd_vt1724_spdif_switch __devinitdata =
---
> static const struct snd_kcontrol_new snd_vt1724_spdif_switch __devinitdata =
1587c1586
< 	static char *texts_1724[] = {
---
> 	static const char * const texts_1724[] = {
1605c1604
< 	static char *texts_1720[] = {
---
> 	static const char * const texts_1720[] = {
1638c1637
< 	static unsigned char xlate[16] = {
---
> 	static const unsigned char xlate[16] = {
1697c1696
< static struct snd_kcontrol_new snd_vt1724_pro_internal_clock __devinitdata = {
---
> static const struct snd_kcontrol_new snd_vt1724_pro_internal_clock __devinitdata = {
1736c1735
< static struct snd_kcontrol_new snd_vt1724_pro_rate_locking __devinitdata = {
---
> static const struct snd_kcontrol_new snd_vt1724_pro_rate_locking __devinitdata = {
1775c1774
< static struct snd_kcontrol_new snd_vt1724_pro_rate_reset __devinitdata = {
---
> static const struct snd_kcontrol_new snd_vt1724_pro_rate_reset __devinitdata = {
1819c1818
< 	static unsigned char xlate[8] = {
---
> 	static const unsigned char xlate[8] = {
1838c1837
< 	static unsigned char xroute[8] = {
---
> 	static const unsigned char xroute[8] = {
1894c1893
< static struct snd_kcontrol_new snd_vt1724_mixer_pro_analog_route __devinitdata = {
---
> static const struct snd_kcontrol_new snd_vt1724_mixer_pro_analog_route __devinitdata = {
1902c1901
< static struct snd_kcontrol_new snd_vt1724_mixer_pro_spdif_route __devinitdata = {
---
> static const struct snd_kcontrol_new snd_vt1724_mixer_pro_spdif_route __devinitdata = {
1938c1937
< static struct snd_kcontrol_new snd_vt1724_mixer_pro_peak __devinitdata = {
---
> static const struct snd_kcontrol_new snd_vt1724_mixer_pro_peak __devinitdata = {
1950c1949
< static struct snd_ice1712_card_info no_matched __devinitdata;
---
> static const struct snd_ice1712_card_info no_matched __devinitdata;
1952c1951
< static struct snd_ice1712_card_info *card_tables[] __devinitdata = {
---
> static const struct snd_ice1712_card_info *card_tables[] __devinitdata = {
1960a1960
> 	snd_vt1724_wtm_cards,
2010c2010
< 	struct snd_ice1712_card_info **tbl, *c;
---
> 	const struct snd_ice1712_card_info **tbl, *c;
2309c2309
< 	struct snd_ice1712_card_info **tbl, *c;
---
> 	const struct snd_ice1712_card_info **tbl, *c;

--MP_S55_/kvrvlrnkcFgEbWb27.
Content-Type: text/x-patch; name=pcm_rc1_to_rc3.diff
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=pcm_rc1_to_rc3.diff

7158c7158
< 		SNDERR("Channels count (%i) not available for %s: %s", s, channels, snd_strerror(err));
---
> 		SNDERR("Channels count (%i) not available for %s: %s", channels, s, snd_strerror(err));
7215c7215
<         		SNDERR("Unable to set period time %i for %s: %s", s, period_time, snd_strerror(err));
---
>         		SNDERR("Unable to set period time %i for %s: %s", period_time, s, snd_strerror(err));

--MP_S55_/kvrvlrnkcFgEbWb27.
Content-Type: text/x-patch; name=ice1712_rc1_to_rc3_h.diff
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=ice1712_rc1_to_rc3_h.diff

517,518c517,518
< 	unsigned int eeprom_size;
< 	unsigned char *eeprom_data;
---
> 	const unsigned int eeprom_size;
> 	const unsigned char *eeprom_data;

--MP_S55_/kvrvlrnkcFgEbWb27.
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--MP_S55_/kvrvlrnkcFgEbWb27.--
