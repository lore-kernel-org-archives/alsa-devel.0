From: Raymond <rayau@netvigator.com>
Subject: Re: [patch] au88x0: codec access procs for multiple AC97 codecs
Date: Sat, 17 Sep 2005 12:01:37 +0800
Message-ID: <432B9521.5010307@netvigator.com>
References: <20050915205617.GD27700@sashak.softier1.local> <s5hoe6srhww.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hoe6srhww.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net, Philipp Matthias Hahn <pmhahn@titan.lahn.de>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Thu, 15 Sep 2005 23:56:17 +0300,
> Sasha Khapyorsky wrote:
> 
>>
>>This modification of au88x0's AC97 codec access procedures enables to
>>access multiple codecs.
>>
>>Tested with au8810 (secondary codec was initialized for this case),
>>looks safe for others as well (au88x0 guys, please comment)
>>
>>
>>Sasha.
>>
>>
>>
>>This patch extends au88x0 AC97 codec access procedures to handle multiple
>>codecs properly.
>>
>>Signed-off-by: Sasha Khapyorsky
> 
> 
> It's on CVS.  Let me know if this breaks anything.
> 
> 

Refer to Philipp Matthias Hahn 's ASUS L8400B notebook with onboard
au8810 audio and Modem Daughter Card.


0:7c = 8384
0:7e = 7605

Is ALSA report the wrong name of the audio codec ?


Primary Audio Codec

0-0/0: SigmaTel STAC9704

Capabilities     :
DAC resolution   : 18-bit
ADC resolution   : 18-bit
3D enhancement   : SigmaTel 3D Enhancement

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off

0:00 = 6940
0:02 = 0303
0:04 = 8000
0:06 = 801f
0:08 = ffff
0:0a = 9f1f
0:0c = 801f
0:0e = 881f
0:10 = 9f1f
0:12 = 9f1f
0:14 = 9f1f
0:16 = 9f1f
0:18 = 0707
0:1a = 9818
0:1c = 0000
0:1e = 0000
0:20 = 0000
0:22 = 0808
0:24 = 0000
0:26 = 000f
0:28 = ffff
0:2a = ffff
0:2c = ffff
0:2e = ffff
0:30 = ffff
0:32 = ffff
0:34 = ffff
0:36 = ffff
0:38 = ffff
0:3a = ffff
0:3c = 0000
0:3e = 0000
0:40 = 0000
0:42 = 0000
0:44 = 0000
0:46 = 0000
0:48 = 0000
0:4a = 0000
0:4c = 0000
0:4e = 0000
0:50 = 0000
0:52 = 0000
0:54 = 0000
0:56 = 0000
0:58 = 0000
0:5a = 0000
0:5c = 0000
0:5e = 0000
0:60 = 0000
0:62 = 0000
0:64 = 0000
0:66 = 0000
0:68 = 0000
0:6a = 0000
0:6c = 0000
0:6e = 0000
0:70 = 0000
0:72 = 0000
0:74 = 0000
0:76 = 0000
0:78 = 0000
0:7a = 0000
0:7c = 8384
0:7e = 7605

Seconday Modem Codec

1-1/0: Silicon Laboratory Si3036,8 rev 6

Extended modem ID: codec=1 LIN1
Modem status     : GPIO MREF ADC1 DAC1 PRE(ADC2) PRF(DAC2) PRG(HADC)
PRH(HDAC)
Line1 rate       : 8000Hz

0:00 = 0000
0:02 = 0000
0:04 = 0000
0:06 = 0000
0:08 = 0000
0:0a = 0000
0:0c = 0000
0:0e = 0000
0:10 = 0000
0:12 = 0000
0:14 = 0000
0:16 = 0000
0:18 = 0000
0:1a = 0000
0:1c = 0000
0:1e = 0000
0:20 = 0000
0:22 = 0000
0:24 = 0000
0:26 = 0000
0:28 = 0000
0:2a = 0000
0:2c = 0000
0:2e = 0000
0:30 = 0000
0:32 = 0000
0:34 = 0000
0:36 = 0000
0:38 = 0000
0:3a = 0000
0:3c = 4001
0:3e = f00f
0:40 = 1f40
0:42 = 0000
0:44 = 0000
0:46 = 8080
0:48 = 0000
0:4a = 0000
0:4c = 003e
0:4e = fffe
0:50 = 003f
0:52 = 0000
0:54 = 0000
0:56 = 0000
0:58 = 0000
0:5a = 0122
0:5c = f210
0:5e = 0040
0:60 = 0000
0:62 = 6000
0:64 = 0002
0:66 = 0a08
0:68 = 0000
0:6a = 0000
0:6c = 0000
0:6e = 0000
0:70 = 0000
0:72 = 0000
0:74 = 0000
0:76 = 0000
0:78 = 0000
0:7a = 0000
0:7c = 5349
0:7e = 4c26







-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
