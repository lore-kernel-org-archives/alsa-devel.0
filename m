From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH] ASoC: cs42l51: Fix SOC_DOUBLE_R_SX_TLV
 shift values for ADC, PCM, and Analog kcontrols
Date: Thu, 17 Apr 2014 16:26:25 +0200
Message-ID: <20140417162625.21d072e7@skate>
References: <1395243602-18012-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (top.free-electrons.com [176.31.233.9])
 by alsa0.perex.cz (Postfix) with ESMTP id A01542602AD
 for <alsa-devel@alsa-project.org>; Thu, 17 Apr 2014 16:26:28 +0200 (CEST)
In-Reply-To: <1395243602-18012-1-git-send-email-brian.austin@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, paul.handrigan@cirrus.com
List-Id: alsa-devel@alsa-project.org

Dear Brian Austin,

On Wed, 19 Mar 2014 10:40:02 -0500, Brian Austin wrote:
> The shift values for the ADC,PCM, and Analog kcontrols were wrong causing wrong values for the SOC_DOUBLE_R_SX_TLV macros
> Fixed the TLV for aout_tlv to show -102dB correctly
> 
> Reported-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Signed-off-by: Brian Austin <brian.austin@cirrus.com>
> ---
>  sound/soc/codecs/cs42l51.c |    9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

Thanks for this patch. Unfortunately, it still doesn't solve completely
the situation. When I start alsamixer, it shows that:

 * PCM is at 102 (so above the maximum 100 value)
 * Both ADC Mixers are at 102
 * Analog is at 174 (so way above the maximum 100 value)

Changing the value of PCM works (but of course I can then only change
it between 0 and 100, not up to 102). However, as soon as I change the
"Analog" value, even if I raise it up to 174, there isn't any sound
anymore. Probably because the alsamixer range 0-100 doesn't allow to
reach a high enough volume to be audible.

Here is the amixer output right after boot (without changing any
value) :

=================================================================
# amixer 
Simple mixer control 'Bass',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 15
  Mono: 7 [47%] [0.00dB]
Simple mixer control 'Treble',0
  Capabilities: volume volume-joined
  Playback channels: Mono
  Capture channels: Mono
  Limits: 0 - 15
  Mono: 7 [47%] [0.00dB]
Simple mixer control 'PCM',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 102
  Mono:
  Front Left: Playback 103 [101%] [0.00dB] [off]
  Front Right: Playback 103 [101%] [0.00dB] [off]
Simple mixer control 'PCM channel mixer',0
  Capabilities: enum
  Items: 'L R' 'L+R' 'R L'
  Item0: 'L R'
Simple mixer control 'Mic Boost',0
  Capabilities: volume
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 1
  Front Left: 0 [0%] [16.00dB]
  Front Right: 0 [0%] [16.00dB]
Simple mixer control 'Playback Deemphasis',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
Simple mixer control 'ADC Mixer',0
  Capabilities: volume pswitch
  Playback channels: Front Left - Front Right
  Capture channels: Front Left - Front Right
  Limits: 0 - 102
  Front Left: 103 [101%] [0.00dB] Playback [off]
  Front Right: 103 [101%] [0.00dB] Playback [off]
Simple mixer control 'Analog',0
  Capabilities: pvolume
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 176
  Mono:
  Front Left: Playback 204 [116%] [0.00dB]
  Front Right: Playback 204 [116%] [0.00dB]
Simple mixer control 'Auto-Mute',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [on]
Simple mixer control 'PGA-ADC Mux Left',0
  Capabilities: enum
  Items: 'AIN1 Left' 'AIN2 Left' 'MIC Left' 'MIC+preamp Left'
  Item0: 'AIN1 Left'
Simple mixer control 'PGA-ADC Mux Right',0
  Capabilities: enum
  Items: 'AIN1 Right' 'AIN2 Right' 'MIC Right' 'MIC+preamp Right'
  Item0: 'AIN1 Right'
Simple mixer control 'Soft Ramp',0
  Capabilities: pswitch pswitch-joined
  Playback channels: Mono
  Mono: Playback [off]
# 
=================================================================

See also an alsamixer screenshot at
http://free-electrons.com/~thomas/pub/alsamixer-issue.png.

I wanted to give you the raw state of the codec registers, but for some
reason, the codec_reg file is empty here (I'm on 3.15-rc1) :

=================================================================
# cat /sys/kernel/debug/asoc/a370db/cs42l51-codec.0-004a/codec_reg 
# 
=================================================================

Note that if I revert back the cs42l51 code to the state before
1d99f2436d0d1c7741d6dfd9d27b5376cdbbca40 ('ASoC: core: Rework
SOC_DOUBLE_R_SX_TLV add SOC_SINGLE_SX_TLV'), then the volume control
works normally.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
