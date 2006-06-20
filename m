From: Ian Malone <ibmalone@gmail.com>
Subject: Re: Fwd: [Alsa-user] Recording spdif/iec958 on	ice1724
 terratec aureon 7.1 space
Date: Tue, 20 Jun 2006 17:46:26 +0100
Message-ID: <44982662.1030502@gmail.com>
References: <124299980606190740v47ab8c9dgedbb88a9f607a572@mail.gmail.com>	<s5hwtbdi02g.wl%tiwai@suse.de>	<4497355D.80704@gmail.com>	<1150761326.2754.75.camel@mindpipe>	<4497A8E6.9020002@gmail.com>
	<s5hfyi0i1u5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030402080503060506090905"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hfyi0i1u5.wl%tiwai@suse.de>
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

This is a multi-part message in MIME format.
--------------030402080503060506090905
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Takashi Iwai wrote:
> At Tue, 20 Jun 2006 08:51:02 +0100,
> Ian Malone wrote:

>>>
>> That's it!  Thanks very much.
>> I had to use alsactl restore to make the change though;
>> toggling the IEC958 capture source in alsamixer doesn't
>> seem to have any effect.
>> Anyway, working nicely now, thanks again.
> 
> "IEC958 capture switch" should exist independently from "IEC958
> capture source".  There might some confliction in the mixer
> abstraction.  Could you show the output of amixer?
> 
> 


Attached.

-- 
imalone

--------------030402080503060506090905
Content-Type: text/plain;
 name="amixer.out"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="amixer.out"

Simple mixer control 'Master',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 255
  Mono:
  Front Left: Playback 113 [44%] [on]
  Front Right: Playback 113 [44%] [on]
Simple mixer control 'PCM',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 128
  Mono: Playback 118 [92%] [on]
Simple mixer control 'Front',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 127
  Mono:
  Front Left: Playback 107 [84%] [on]
  Front Right: Playback 107 [84%] [on]
Simple mixer control 'Center',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 127
  Mono: Playback 0 [0%] [off]
Simple mixer control 'LFE',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 127
  Mono: Playback 0 [0%] [off]
Simple mixer control 'Side',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 127
  Mono:
  Front Left: Playback 0 [0%] [off]
  Front Right: Playback 0 [0%] [off]
Simple mixer control 'Line',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 23 [74%] [off] Capture [on]
  Front Right: Playback 23 [74%] [off] Capture [on]
Simple mixer control 'CD',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 24 [77%] [on] Capture [off]
  Front Right: Playback 24 [77%] [on] Capture [off]
Simple mixer control 'Mic',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined cswitch cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Mono
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Mono: Playback 0 [0%] [off]
  Front Left: Capture [off]
  Front Right: Capture [off]
Simple mixer control 'Mic Boost (+20dB)',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'IEC958',0
  Capabilities: cswitch cswitch-joined enum
  Items: 'PCM Out' 'H/W In 0' 'H/W In 1' 'IEC958 In L' 'IEC958 In R'
  Item0: 'PCM Out'
Simple mixer control 'IEC958 Capture Source',0
  Capabilities: enum
  Items: 'CD' 'Optical'
  Item0: 'Optical'
Simple mixer control 'IEC958 Output',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'IEC958',1
  Capabilities: enum
  Items: 'PCM Out' 'H/W In 0' 'H/W In 1' 'IEC958 In L' 'IEC958 In R'
  Item0: 'PCM Out'
Simple mixer control 'Aux',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 23 [74%] [off] Capture [off]
  Front Right: Playback 23 [74%] [off] Capture [off]
Simple mixer control 'Capture',0
  Capabilities: cvolume cswitch
  Capture channels: Front Left - Front Right
  Limits: Capture 0 - 31
  Front Left: Capture 31 [100%] [on]
  Front Right: Capture 31 [100%] [on]
Simple mixer control 'AC97',0
  Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-exclusive
  Capture exclusive group: 0
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: Playback 0 - 31
  Front Left: Playback 18 [58%] [on] Capture [off]
  Front Right: Playback 18 [58%] [on] Capture [off]
Simple mixer control 'ADC Oversampling',0
  Capabilities: enum
  Items: '128x' '64x'
  Item0: '128x'
Simple mixer control 'DAC Deemphasis',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'External Amplifier',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
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
  Items: '8000' '9600' '11025' '12000' '16000' '22050' '24000' '32000' '44100' '48000' '64000' '88200' '96000' '176400' '192000' 'IEC958 Input'
  Item0: '44100'
Simple mixer control 'Multi Track Peak',0
  Capabilities: volume
  Playback channels: Front Left - Front Right - Rear Left - Rear Right - Front Center - Woofer - Side Left - Side Right - Rear Center - ? - ? - ? - ? - ? - ? - ? - ? - ? - ? - ? - ? - ?
  Capture channels: Front Left - Front Right - Rear Left - Rear Right - Front Center - Woofer - Side Left - Side Right - Rear Center - ? - ? - ? - ? - ? - ? - ? - ? - ? - ? - ? - ? - ?
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
  ?: 2 [1%]
  ?: 1 [0%]
  ?: 0 [0%]
  ?: 0 [0%]
  ?: 0 [0%]
  ?: 0 [0%]
  ?: 0 [0%]
  ?: 0 [0%]
  ?: 146 [57%]
  ?: 148 [58%]
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
  Front Left: Playback 0 [0%] [off]
  Front Right: Playback 0 [0%] [off]

--------------030402080503060506090905
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------030402080503060506090905
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--------------030402080503060506090905--
