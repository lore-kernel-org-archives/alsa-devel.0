From: Haroldo Gamal <gamal@alternex.com.br>
Subject: Setting hw constraints
Date: Fri, 13 Sep 2002 02:32:16 -0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <5.1.1.6.1.20020913022555.4320e3d0@pop.alternex.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi!

I am trying to improve the korg1212 driver and I am finding a difficult
situation. Let me explain... The korg1212 card has a fixed size audio
frame containing two different sample size, 16 bits and 32 bits, that
are filled by the card at same time. Ten channels of this frame have 16
bits (ADAT + analog channels), two others have 20 bits (SPDIF) and 32
bits of ADAT Time-code information.
I am trying to establish three different devices to support these
different sample size and interface type (ADAT, analog and SPDIF). To do
this, I will have a frame size greater than the number of samples times
its size.

It could be solved creating temporary buffers that would carry some
waste of performance or; modifying the card firmware, putting each
channel on a separated buffer. I am denying the first option for a
while. The second one depends on Korg... I do not have the firmware
source code.

I've tried to set SNDRV_PCM_HW_PARAM_FRAME_BITS,
SNDRV_PCM_HW_PARAM_PERIOD_SIZE and SNDRV_PCM_HW_PARAM_BUFFER_SIZE
constraint but I get an error when I call snd_pcm_hw_params_any on
application side.

How can I handle this situation?

How set SNDRV_PCM_HW_PARAM_FRAME_BITS and all other constraints?
How can I have an audio frame larger than the total size of all samples
in it?

Haroldo




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
