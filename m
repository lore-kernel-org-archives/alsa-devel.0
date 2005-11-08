From: conrad =?iso-8859-1?q?berh=F6rster?= <conrad.berhoerster@gmx.de>
Subject: capturing with phase 28
Date: Tue, 8 Nov 2005 18:51:33 +0100
Message-ID: <200511081851.35199.conrad.berhoerster@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net.
List-Id: alsa-devel@alsa-project.org

Hello all, 
last week i spend much work into got terratecs phase 28 to work. 
this is an ice1724 and an IEC958 chip.

currently playback is fine und jack working good. 
the only problem is the capturing.
it seems, that there is no signal coming into the alsa. 

to get closer to the problem, i just want to capture with arecord.
but arecord test.wav produce an file with no signals. 

i'm using alsa 1.0.10rc2 and append the output from amixer at the end 
are there any ideas if something is configured badly. there seems no capturing 
device recogniced, since there are only 2 captures (and not 8 !) 

maybe someone out there can explain, what these two chips are for. what are 
the special purposes of these chips.    



------------------------------ schnipp ---------------------
Simple mixer control 'Master',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 190 [75%] [on]
  Front Right: Playback 190 [75%] [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 128
  Mono: Playback 95 [74%] [on]
Simple mixer control 'Front',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 127
  Mono:
  Front Left: Playback 93 [73%] [on]
  Front Right: Playback 93 [73%] [on]
Simple mixer control 'Center',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 127
  Mono: Playback 94 [74%] [on]
Simple mixer control 'LFE',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 127
  Mono: Playback 87 [69%] [on]
Simple mixer control 'Side',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 127
  Mono:
  Front Left: Playback 90 [71%] [on]
  Front Right: Playback 90 [71%] [on]
Simple mixer control 'IEC958',0
  Capabilities: enum
  Items: 'PCM Out' 'H/W In 0' 'H/W In 1' 'IEC958 In L' 'IEC958 In R'
  Item0: 'PCM Out'
Simple mixer control 'IEC958 Output',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'IEC958',1
  Capabilities: enum
  Items: 'PCM Out' 'H/W In 0' 'H/W In 1' 'IEC958 In L' 'IEC958 In R'
  Item0: 'PCM Out'
Simple mixer control 'ADC Oversampling',0
  Capabilities: enum
  Items: '128x' '64x'
  Item0: '128x'
Simple mixer control 'DAC Deemphasis',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'H/W',0
  Capabilities: enum
  Items: 'PCM Out' 'H/W In 0' 'H/W In 1' 'IEC958 In L' 'IEC958 In R'
  Item0: 'PCM Out'
Simple mixer control 'H/W',1
  Capabilities: enum
  Items: 'PCM Out' 'H/W In 0' 'H/W In 1' 'IEC958 In L' 'IEC958 In R'
  Item0: 'PCM Out'
Simple mixer control 'H/W',2
  Capabilities: enum
  Items: 'PCM Out' 'H/W In 0' 'H/W In 1' 'IEC958 In L' 'IEC958 In R'
  Item0: 'PCM Out'
Simple mixer control 'H/W',3
  Capabilities: enum
  Items: 'PCM Out' 'H/W In 0' 'H/W In 1' 'IEC958 In L' 'IEC958 In R'
  Item0: 'PCM Out'
Simple mixer control 'H/W',4
  Capabilities: enum
  Items: 'PCM Out' 'H/W In 0' 'H/W In 1' 'IEC958 In L' 'IEC958 In R'
  Item0: 'PCM Out'
Simple mixer control 'H/W',5
  Capabilities: enum
  Items: 'PCM Out' 'H/W In 0' 'H/W In 1' 'IEC958 In L' 'IEC958 In R'
  Item0: 'PCM Out'
Simple mixer control 'H/W',6
  Capabilities: enum
  Items: 'PCM Out' 'H/W In 0' 'H/W In 1' 'IEC958 In L' 'IEC958 In R'
  Item0: 'PCM Out'
Simple mixer control 'H/W',7
  Capabilities: enum
  Items: 'PCM Out' 'H/W In 0' 'H/W In 1' 'IEC958 In L' 'IEC958 In R'
  Item0: 'PCM Out'
Simple mixer control 'Multi Track Internal Clock',0
  Capabilities: enum
  Items: '8000' '9600' '11025' '12000' '16000' '22050' '24000' '32000' '44100' 
'48000' '64000' '88200' '96000' '176400' '192000' 'IEC958 Input'
  Item0: '48000'
Simple mixer control 'Multi Track Peak',0
  Capabilities: volume
  Playback channels: Front Left - Front Right - Rear Left - Rear Right - Front 
Center - Woofer - Side Left - Side Right - Rear Center - ? - ? - ? - ? - ? 
- ? - ? - ? - ? - ? - ? - ? - ?
  Capture channels: Front Left - Front Right - Rear Left - Rear Right - Front 
Center - Woofer - Side Left - Side Right - Rear Center - ? - ? - ? - ? - ? 
- ? - ? - ? - ? - ? - ? - ? - ?
  Limits: 0 - 255
  Front Left: 0 [0%]
  Front Right: 0 [0%]
  Rear Left: 0 [0%]
  Rear Right: 0 [0%]
  Front Center: 0 [0%]
  Woofer: 0 [0%]
  Side Left: 0 [0%]
  Side Right: 0 [0%]
  Rear Center: 0 [0%]
  ?: 0 [0%]
  ?: 112 [44%]
  ?: 113 [44%]
  ?: 0 [0%]
  ?: 0 [0%]
  ?: 0 [0%]
  ?: 0 [0%]
  ?: 0 [0%]
  ?: 0 [0%]
  ?: 0 [0%]
  ?: 0 [0%]
  ?: 0 [0%]
  ?: 0 [0%]
Simple mixer control 'Multi Track Rate Locking',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Multi Track Rate Reset',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'Rear',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 127
  Mono:
  Front Left: Playback 93 [73%] [on]
  Front Right: Playback 93 [73%] [on]

 


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
