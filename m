From: Troy Benjegerdes <hozer@hozed.org>
Subject: ymfpci, big-endian, and spdif out
Date: Thu, 2 Jan 2003 22:22:34 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030103042233.GK28177@altus.drgw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

I have a mac G4 (running debian testing), a ymfpci card (MaxiSound
Fortissimo) with optical TOSlink out, and a yamaha HTR-5540 receiver with
digital optical TOSlink input.

I'm trying to get xine or some other DVD player to output AC/3 sound to 
the receiver for watching dvd's, and I have a couple of problems.

1) xmms (and xine 2-channel sound) works with OSS emulation, but is static
	with native ALSA drivers. This seems like some endian problem

2) spdif out does not seem to work. Here are some of the messages from 
xine:

audio_alsa_out : supported modes are 8bit mono stereo (4-channel not enabled in
xine config) (5-channel not enabled in xine config) (5.1-channel not enabled in
xine config) a/52 and DTS pass-through


audio_out: stream audio format is 48000 kHz sampling rate, 16 bits. mode is 1.
audio_alsa_out: Audio Device name = 
iec958:AES0=0x6,AES1=0x82,AES2=0x0,AES3=0x2
audio_alsa_out: Number of channels = 2
audio_alsa_out: pcm hw_params failed: No such device or ALSA lib 
pcm_hw.c:292:(snd_pcm_hw_hw_params) SNDRV_PCM_IOCTL_HW_PARAMS failed: No 
such device or addressALSA lib pcm_hw.c:292:(snd_pcm_hw_hw_params) 
SNDRV_PCM_IOCTL_HW_PARAMS failed: No such device or address


So where do I get started to fix this? 

Also, where can I get some short raw AC3 encoded sounds to test with 
something like aplay?

Thanks!


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
