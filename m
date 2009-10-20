From: "Neil Jones" <neil.jones@imgtec.com>
Subject: What is the meaning of the mask values in the pcm hw
	constraints struct ?
Date: Tue, 20 Oct 2009 16:54:32 +0100
Message-ID: <0D107966AF6D79418315B7C5549F4B5101150A39@lemail1.le.imgtec.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from filter3.imgtec.com (multi.imgtec.com [194.200.65.239])
	by alsa0.perex.cz (Postfix) with ESMTP id 04A3E24731
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Oct 2009 17:54:35 +0200 (CEST)
Content-class: urn:content-classes:message
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

I am developing an ASoC driver for a custom SoC (not in tree yet), I
have written the platform and board modules and my hardware detects and
installs ok, im now trying to play sound using aplay but im having
issues.

I get the error "aplay: set_params:1022: Unable to install hw params:"
I have traced the problem to a failing ioctl call
(snd_pcm_playback_ioctl) the error occurs in snd_pcm_hw_refine when
refining the mask for the SNDRV_PCM_HW_PARAM_ACCESS mask, all the bit
fields in my runtime->hw_constraints are zero for this field, but the
requested params have the value 7, Im not sure what this means, the
SNDRV_PCM_ACCESS_xxx defines in asound.h only go upto 4 ?

I have attached logs below (with RULES_DEBUG turned on) hopefully this
may shed some light.

Thanks in advance for any help,

Neil Jones


Logs:

# /usr/bin/aplay /var/snd48khz.wav
Playing WAVE '/var/snd48khz.wav' : Signed 16 bit Little Endian, Rate
48000 Hz, Stereo
aplay: set_params:1022: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: 48000
PERIOD_TIME: (85333 85334)
PERIOD_SIZE: 4096
PERIOD_BYTES: 16384
PERIODS: (5 6)
BUFFER_TIME: 500000
BUFFER_SIZE: 24000
BUFFER_BYTES: 96000
TICK_TIME: 0

(klog)
...
Rule 0 [4030f9f4]: FORMAT = 4 -> 4
Rule 2 [4030f750]: SAMPLE_BITS = [16 16] -> [16 16]
Rule 4 [4030f90c]: FRAME_BITS = [16 16] -> [16 16]
Rule 5 [4030f90c]: FRAME_BITS = [16 16] -> [16 16]
Rule 7 [4030f90c]: RATE = [48000 48000] -> [48000 48000]
Rule 8 [4030f90c]: RATE = [48000 48000] -> [48000 48000]
Rule 9 [4030f750]: PERIODS = [1 128] -> [1 128]
Rule 10 [4030f750]: PERIOD_SIZE = [16 4096] -> [16 4096]
Rule 12 [4030f828]: PERIOD_SIZE = [16 4096] -> [16 4096]
Rule 15 [4030f828]: BUFFER_SIZE = [16 65536] -> [16 65536]
Rule 18 [4030f90c]: PERIOD_TIME = (166 128000] -> (333 85334)
Rule 19 [4030f90c]: BUFFER_TIME = (166 2048000] -> (333 1365334)
Rule 7 [4030f90c]: RATE = [48000 48000] -> [48000 48000]
Rule 8 [4030f90c]: RATE = [48000 48000] -> [48000 48000]
Rule 12 [4030f828]: PERIOD_SIZE = [16 4096] -> [16 4096]
Rule 15 [4030f828]: BUFFER_SIZE = [16 65536] -> [16 65536]
ACCESS = 0000000000000007 -> 0000000000000000
-
This message is subject to Imagination Technologies' e-mail terms: http://www.imgtec.com/e-mail.htm

Imagination Technologies Ltd is a limited company registered in England No:  1306335 
Registered Office: Imagination House, Home Park Estate, Kings Langley, Hertfordshire, WD4 8LZ.  

Email to and from the company may be monitored for compliance and other administrative purposes.  
-
