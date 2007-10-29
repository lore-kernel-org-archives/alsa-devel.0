From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Subject: Re: Sample format coversion bug?
Date: Mon, 29 Oct 2007 20:04:15 +0500
Message-ID: <4725F66F.10805@ums.usu.ru>
References: <4721E932.5090603@ums.usu.ru>	<s5hpryyny19.wl%tiwai@suse.de>	<4725BD78.6040709@ums.usu.ru>
	<s5hk5p6nveb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay4.usu.ru (relay4.usu.ru [194.226.235.39])
	by alsa0.perex.cz (Postfix) with ESMTP id BFE6024524
	for <alsa-devel@alsa-project.org>; Mon, 29 Oct 2007 16:04:25 +0100 (CET)
Received: from relay4.usu.ru (localhost [127.0.0.1])
	by relay4.usu.ru (PostSystem) with ESMTP id 2541017F9D
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Oct 2007 20:07:02 +0500 (YEKT)
Received: from usu2.usu.ru (usu2.usu.ru [194.226.237.16])
	by relay4.usu.ru (PostSystem) with ESMTP id 424A617F9D
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Oct 2007 20:07:00 +0500 (YEKT)
Received: from usu2.usu.ru (localhost.usu2.usu.ru [127.0.0.1])
	by usu2.usu.ru (Postfix) with ESMTP id D3A9EA7EB0
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Oct 2007 20:04:17 +0500 (YEKT)
Received: from ums.usu.ru (ums.usu.ru [194.226.236.116])
	by usu2.usu.ru (Postfix) with ESMTP id 2EE51A7E95
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Oct 2007 20:04:17 +0500 (YEKT)
In-Reply-To: <s5hk5p6nveb.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Does your driver support mmap?
>   

It looks like the hardware doesn't accept the default parameters:

patrakov@home:~$ arecord -M -f S16_LE -c 2 -r 32000 -D hw:1 /dev/null
Recording WAVE '/dev/null' : Signed 16 bit Little Endian, Rate 32000 Hz, 
Stereo
ALSA lib pcm_mmap.c:369:(snd_pcm_mmap) mmap failed: Invalid argument
arecord: set_params:961: Unable to install hw params:
ACCESS:  MMAP_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: 32000
PERIOD_TIME: 125000
PERIOD_SIZE: 4000
PERIOD_BYTES: 16000
PERIODS: 4
BUFFER_TIME: 500000
BUFFER_SIZE: 16000
BUFFER_BYTES: 64000
TICK_TIME: 4000

Even though mmap seems to be supported in the driver source (judging 
from .info = SNDRV_PCM_INFO_MMAP | other flags), I could not figure out 
the parameters that work. Moreover, the driver seems to accept the same 
hardware parameters without the mmap, and I could not find parameters 
that the driver accepts for mmap.

Also: I have retested my original problem with the virtual ens1370 card 
emulated by qemu. The original testcase does work, so the problem seems 
to be specific to saa7134, due to non-working mmap access. Could you 
please help me transform my observations into something that the v4l 
development list will accept as a good bug report?

One more question: since plug doesn't work at all on devices without 
mmap available, does this mean that I should scrap my original idea 
about using plug to convert everything into S24?

-- 
Alexander E. Patrakov
