From: John Parker <John.Parker@actio.co.uk>
Subject: Help with SPDIF output on Via EPIA with via686 and VT1612 codec
Date: Fri, 09 Aug 2002 14:02:41 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D53BD71.501@actio.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.actio.limited ([212.104.142.173])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id PAA09570
	for <alsa-devel@alsa-project.org>; Fri, 9 Aug 2002 15:04:46 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel <alsa-devel@alsa-project.org>, alsa-user <alsa-user@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi folks (apologies if this appears more than once)

I'm trying to get good quality sound from the Via EPIA motherboards.

The analog output is OK with the 0.9rc2 driver, but I can't see how to
enable the SPDIF output.
----------------------------------------------------------------------------
aplay -l  reports

card 0: card0 [VIA 82C686A/B], device 0: VIA 82C686A [VIA 82C686A]
    Subdevices: 1/1
    Subdevice #0: subdevice #0

----------------------------------------------------------------------------
/proc/asound/card0/ac97#0

0-0/0: 0x56494161 VIA

Capabilities     : -headphone out-
DAC resolution   : 18-bit
ADC resolution   : 18-bit
3D enhancement   : Reserved 27

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=0 AMAP DSA=0 SPDIF VRA
Extended status  : SPDIF=res SPDIF VRA
PCM front DAC    : 44100Hz
PCM ADC          : 48000Hz
SPDIF Control    : Consumer PCM Category=0x22 Generation=1 Rate=48kHz
----------------------------------------------------------------------------

amixer reports

Simple mixer control 'Master',0
    Capabilities: pvolume pswitch pswitch-joined
    Playback channels: Front Left - Front Right
    Limits: Playback 0 - 31
    Front Left: Playback 23 [74%] [on]
    Front Right: Playback 23 [74%] [on]
Simple mixer control 'Master Mono',0
    Capabilities: pvolume pvolume-joined pswitch pswitch-joined
    Playback channels: Mono
    Limits: Playback 0 - 31
    Mono: Playback 0 [0%] [off]
Simple mixer control 'Headphone',0
    Capabilities: pvolume pswitch pswitch-joined
    Playback channels: Front Left - Front Right
    Limits: Playback 0 - 31
    Front Left: Playback 0 [0%] [off]
    Front Right: Playback 0 [0%] [off]
Simple mixer control '3D Control - Center',0
    Capabilities: volume volume-joined
    Playback channels: Mono
    Limits: 0 - 15
    Mono: 0 [0%]
Simple mixer control '3D Control - Depth',0
    Capabilities: volume volume-joined
    Playback channels: Mono
    Limits: 0 - 15
    Mono: 0 [0%]
Simple mixer control '3D Control - Switch',0
    Capabilities: pswitch pswitch-joined
    Playback channels: Mono
    Mono: Playback [off]
Simple mixer control 'PCM',0
    Capabilities: pvolume pswitch pswitch-joined
    Playback channels: Front Left - Front Right
    Limits: Playback 0 - 31
    Front Left: Playback 21 [68%] [on]
    Front Right: Playback 21 [68%] [on]
Simple mixer control 'Line',0
    Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-joined
cswitch-exclusive
    Capture exclusive group: 0
    Playback channels: Front Left - Front Right
    Capture channels: Front Left - Front Right
    Limits: Playback 0 - 31
    Front Left: Playback 0 [0%] [off] Capture [off]
    Front Right: Playback 0 [0%] [off] Capture [off]
Simple mixer control 'CD',0
    Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-joined
cswitch-exclusive
    Capture exclusive group: 0
    Playback channels: Front Left - Front Right
    Capture channels: Front Left - Front Right
    Limits: Playback 0 - 31
    Front Left: Playback 0 [0%] [off] Capture [off]
    Front Right: Playback 0 [0%] [off] Capture [off]
Simple mixer control 'Mic',0
    Capabilities: pvolume pvolume-joined pswitch pswitch-joined cswitch
cswitch-joined cswitch-exclusive
    Capture exclusive group: 0
    Playback channels: Mono
    Capture channels: Front Left - Front Right
    Limits: Playback 0 - 31
    Mono: Playback 0 [0%] [off]
    Front Left: Capture [on]
    Front Right: Capture [on]
Simple mixer control 'Mic Boost (+20dB)',0
    Capabilities: pswitch pswitch-joined
    Playback channels: Mono
    Mono: Playback [off]
Simple mixer control 'Video',0
    Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-joined
cswitch-exclusive
    Capture exclusive group: 0
    Playback channels: Front Left - Front Right
    Capture channels: Front Left - Front Right
    Limits: Playback 0 - 31
    Front Left: Playback 0 [0%] [off] Capture [off]
    Front Right: Playback 0 [0%] [off] Capture [off]
Simple mixer control 'Phone',0
    Capabilities: pvolume pvolume-joined pswitch pswitch-joined cswitch
cswitch-joined cswitch-exclusive
    Capture exclusive group: 0
    Playback channels: Mono
    Capture channels: Front Left - Front Right
    Limits: Playback 0 - 31
    Mono: Playback 0 [0%] [off]
    Front Left: Capture [off]
    Front Right: Capture [off]
Simple mixer control 'IEC958',0
    Capabilities: pswitch pswitch-joined
    Playback channels: Mono
    Mono: Playback [on]
Simple mixer control 'IEC958 Playback AC97-SPSA',0
    Capabilities: volume volume-joined
    Playback channels: Mono
    Limits: 0 - 3
    Mono: 3 [100%]
Simple mixer control 'PC Speaker',0
    Capabilities: pvolume pvolume-joined pswitch pswitch-joined
    Playback channels: Mono
    Limits: Playback 0 - 15
    Mono: Playback 0 [0%] [off]
Simple mixer control 'Aux',0
    Capabilities: pvolume pswitch pswitch-joined cswitch cswitch-joined
cswitch-exclusive
    Capture exclusive group: 0
    Playback channels: Front Left - Front Right
    Capture channels: Front Left - Front Right
    Limits: Playback 0 - 31
    Front Left: Playback 0 [0%] [off] Capture [off]
    Front Right: Playback 0 [0%] [off] Capture [off]
Simple mixer control 'Capture',0
    Capabilities: cvolume cswitch cswitch-joined
    Capture channels: Front Left - Front Right
    Limits: Capture 0 - 15
    Front Left: Capture 0 [0%] [on]
    Front Right: Capture 0 [0%] [on]
Simple mixer control 'Mix',0
    Capabilities: cswitch cswitch-joined cswitch-exclusive
    Capture exclusive group: 0
    Capture channels: Front Left - Front Right
    Front Left: Capture [off]
    Front Right: Capture [off]
Simple mixer control 'Mix Mono',0
    Capabilities: cswitch cswitch-joined cswitch-exclusive
    Capture exclusive group: 0
    Capture channels: Front Left - Front Right
    Front Left: Capture [off]
    Front Right: Capture [off]
Simple mixer control 'External Amplifier Power Down',0
    Capabilities: pswitch pswitch-joined
    Playback channels: Mono
    Mono: Playback [on]

----------------------------------------------------------------------------

alsamixer shows a control for IEC958 (mute/unmute?) and a 4 step control
for IEC958 Playback AC97-SPSA


I've tried lots have things and searched the archives but now I'm
looking for more ideas.

Thanks in advance
John












-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
