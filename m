From: Torrey Hoffman <thoffman@arnor.net>
Subject: Problem with supported PCM formats in ice1712 driver
Date: Fri, 16 Jan 2004 18:15:41 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1074305741.6251.7.camel@moria.arnor.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from devil.servak.biz (devil.servak.biz [209.124.81.2])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id DAA27654
	for <alsa-devel@alsa-project.org>; Sat, 17 Jan 2004 03:21:24 +0100
Received: from [64.122.104.99] (helo=[10.134.0.78])
	by devil.servak.biz with esmtp (Exim 4.24)
	id 1Ahg5F-0000BW-Ud
	for alsa-devel@alsa-project.org; Fri, 16 Jan 2004 21:21:10 -0500
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA Development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I've got an M-Audio Audiophile 2496 and am running linux 2.6.1-mm3
(which includes ALSA 1.0.1).

I'm trying to get all my sound applications working using only ALSA
interfaces.   I'm having problems with the ice 1712 driver.

(I have lots of C programming experience but am new to the ALSA driver
subsystem.)  I've compiled my own copy of xmms with the ALSA output
plugin.  It fails at startup with these messages: (I have enabled alsa
debug in my xmms config file) 

--
Message: alsa_setup_mixer
Message: alsa_setup_mixer: end
Message: Opening device
Message: alsa_setup
Message: output format: 7, rate: 44100, channels: 2
Message: Opening device: hw:0,0
Opened ALSA card 0, Device 0, Subdevice 0
Message: Configuring device: hw:0,0
Message: Attempting to set hardware format S16_LE
Message: Attempting to set next hardware format S16_LE
Message: Attempting to set next hardware format S16_BE
Message: Attempting to set next hardware format U8
** WARNING **: alsa_setup(): Sample format not available for playback:
Invalid argument
Message: Closing device
Message: Device closed
--

I decided to try debugging this myself, so I'm writing a little test app
that iterates over all the possible PCM formats and tries to set them.  

(The plan is to evolve this into a full ALSA test program which iterates
over all cards, devices and subdevices in the system, prints out all
their possible configurations, and tests them...)

Anyway, the relevant snippet of C code is:

for (pcm_format = 0; pcm_format <= SND_PCM_FORMAT_LAST; pcm_format++)
{
	test = snd_pcm_hw_params_test_format(pcm_handle, hw_params, pcm_format);
	info_printf("PCM format %d: %s (%s)\n", pcm_format, (test ? "FAILED" : "OK"), 
			snd_pcm_format_t_to_string(pcm_format));
}

This outputs:
PCM format 0: FAILED (Signed 8 bit )
PCM format 1: FAILED (Unsigned 8 bit)
PCM format 2: FAILED (Signed 16 bit Little Endian)
PCM format 3: FAILED (Signed 16 bit Big Endian)
PCM format 4: FAILED (Unsigned 16 bit Little Endian)
PCM format 5: FAILED (Unsigned 16 bit Big Endian)
PCM format 6: FAILED (Signed 24 bit Little Endian)
PCM format 7: FAILED (Signed 24 bit Big Endian)
PCM format 8: FAILED (Unsigned 24 bit Little Endian)
PCM format 9: FAILED (Unsigned 24 bit Big Endian)
PCM format 10: OK (Signed 32 bit Little Endian)
PCM format 11: FAILED (Signed 32 bit Big Endian)
PCM format 12: FAILED (Unsigned 32 bit Little Endian)
PCM format 13: FAILED (Unsigned 32 bit Big Endian)
PCM format 14: FAILED (Float 32 bit Little Endian, Range -1.0 to 1.0)

(... etc. ... all other formats other than 10 are also FAILED.)

This seems to explain why the XMMS Alsa plugin fails... apparently only
"Signed 32 bit Little Endian" is supported by this driver???

But the strange thing is, I've looked at the source code for the ice1712
driver and found this: 

static snd_pcm_hardware_t snd_ice1712_playback =
{
        .info =                 (SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
                                 SNDRV_PCM_INFO_BLOCK_TRANSFER |
                                 SNDRV_PCM_INFO_MMAP_VALID |
                                 SNDRV_PCM_INFO_PAUSE),
        .formats =              SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S16_LE,
        .rates =                SNDRV_PCM_RATE_CONTINUOUS | SNDRV_PCM_RATE_8000_48000,
        .rate_min =             4000,

...

So it looks like the driver should support unsigned 8bit, and signed
16bit little endian.  And, those are the formats which the XMMS plugin
tries to set, and fails.

What's going on there?

Now, just as a sanity check... my motherboard also has an onboard ICH5
sound chip.  If I load that driver instead, it works as expected... The
XMMS ALSA plugin works, and my test app prints:

PCM format 0: FAILED (Signed 8 bit )
PCM format 1: FAILED (Unsigned 8 bit)
PCM format 2: OK (Signed 16 bit Little Endian)
PCM format 3: FAILED (Signed 16 bit Big Endian)

(... the rest fail ... )

With both the drivers loaded, my /proc/asound/cards looks like this:

0 [ICH5           ]: ICH - Intel ICH5
                     Intel ICH5 at 0xfc102000, irq 17
1 [M2496          ]: ICE1712 - M Audio Audiophile 24/96
                     M Audio Audiophile 24/96 at 0x6000, irq 20

/proc/asound/version is:

Advanced Linux Sound Architecture Driver Version 1.0.1 (Tue Dec 30
10:04:14 2003 UTC).
Compiled on Jan 14 2004 for kernel 2.6.1-mm3 (SMP).

Any help would be deeply appreciated!

-- 
Torrey Hoffman <thoffman@arnor.net>



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
