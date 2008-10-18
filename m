From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: [PATCH] snd-sbxfi: implement support for 192khz
 playback/capture.
Date: Sat, 18 Oct 2008 22:32:21 +0100
Message-ID: <48FA55E5.8000503@superbug.co.uk>
References: <20081018183020.540B577DF81@carpathia.dereferenced.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anchor-post-37.mail.demon.net (anchor-post-37.mail.demon.net
	[194.217.242.87])
	by alsa0.perex.cz (Postfix) with ESMTP id 8E5FB10388B
	for <alsa-devel@alsa-project.org>;
	Sat, 18 Oct 2008 23:32:41 +0200 (CEST)
In-Reply-To: <20081018183020.540B577DF81@carpathia.dereferenced.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: William Pitcock <nenolod@sacredspiral.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

William Pitcock wrote:
> Implements support for 192khz initialization for playback and capture.
> 
>  	case 96000:
>  		ratec = 0x5d | SRCCTL_RUN_STATE;
>  		break;
> +	case 192000:
> +		ratec = 0x6d | SRCCTL_RUN_STATE;
> +		break;
>  	}
>  
>  	ctrl = ratec;

FYI:

ratec writes to the SRC_CTL register.

The SRC_CTL register is a 32bit register with bits 31-0
Bits 2-0: STATE: Sample rate converter state
000 OFF
001 RESERVED
010 TAIL
011 STOPPING
100 INIT
101 RUN
110 INIT_AUTO_LOAD
111 RUN_AUTO_LOAD

Bit 3: BM: Bus Master enable

Bits 5-4: RSR: Reference sample rate
00  48 kHz Uses 1 channel
01  96kHz  Uses 2 channels
10 192 kHz Uses 4 channels
11 384kHz  Uses 8 channels
Note: 44.1kHz is possible, but is more complex because it uses a method
whereby the channel ring marks each sample in the channel ring as valid
or not, so to get 44.1kHz, some samples are simply tagged invalid. The
"channel ring" is not the ring buffer that is used to get sound samples
to the card. The "channel ring" is used to pass samples between
different processing modules on the card. One of these processing
modules is the SRC, another is the INs/OUTs, another is the hardware
mixer, and yet another is the DSP.

Bits 8-6: SF: Sample format
000  8-bit unsigned
001 16-bit signed
010 24-bit signed, packed on 3-byte boundaries
011 32-bit signed (can be used for 24-bit unpacked)
100 32-bit float

Bit 9: WR: Write cache to memory. Takes samples only from the ring, and
not from the host.

Bit 10: PM: Pitch master of following channel: Used to phase lock
neighboring channels together.

Bit 12-11: Pitch ROM select
00 Pitch 0 to 8.0 (very high quality)
01 Pitch 0.26 to 1.72 (extremely high quality)
10 Pitch 1.8375 (88.2 kHz 48 kHz)
11 Pitch 2.0 (96kHz 48 kHz)

Bit 13: VO: Variable output rate, fixed input rate.

Bit 14: Stop on Loop: Stop after last sample in the loop.

Bit 15: IE: Interrupt enable: Interrupt after last sample in the loop.

Bit 19-16: ILSZ: Interleave size: Indicates number of contiguous
channels that are part of an interleaved group. Only needs to be tagged
in the first channel of the group.

Bit 20: Bypass: Bypass SRC.

Bits 21-31 not used
