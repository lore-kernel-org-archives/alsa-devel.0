From: Olivier Langlois <olivier@trillion01.com>
Subject: Re: need help with loopback driver
Date: Fri, 27 Dec 2013 00:05:39 -0500
Message-ID: <1388120739.18597.37.camel@Wailaba2>
References: <1386743591.753.9.camel@Wailaba2>
 <1386911522.753.43.camel@Wailaba2> <1388088465.18597.29.camel@Wailaba2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from alt-proxy33.mail.unifiedlayer.com
 (alt-proxy33.mail.unifiedlayer.com [70.40.209.146])
 by alsa0.perex.cz (Postfix) with SMTP id 4D6DA261A11
 for <alsa-devel@alsa-project.org>; Fri, 27 Dec 2013 06:05:49 +0100 (CET)
Received: from [173.179.63.169] (port=33552 helo=[192.168.1.104])
 by box610.bluehost.com with esmtpsa (SSLv3:RC4-SHA:128) (Exim 4.80)
 (envelope-from <olivier@trillion01.com>) id 1VwPcJ-0006AD-Bd
 for alsa-devel@alsa-project.org; Thu, 26 Dec 2013 22:05:47 -0700
In-Reply-To: <1388088465.18597.29.camel@Wailaba2>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Ok mystery solved. the refinement failing wasn't in pcm_rate with params
from pcm_multi but in pcm_hw with pcm_rate params.

The problem was on my side since I forgot to change the sampling rate
from 44100 to 48000 on the aloop capture side. Again depending on the
order I was initializing the aloop subdevices, this was creating a param
mismatch or not.

On Thu, 2013-12-26 at 15:07 -0500, Olivier Langlois wrote:
> Concerning the last problem. Here it is 'loop_44100_16' refine sometimes
> works and sometimes it doesn't. Either something invisible to the param
> dumps is different or maybe some uninitialized variables adds some
> randomness to the result:
> 
> srefine 'loop_44100_16' (client)
> ACCESS:  MMAP_INTERLEAVED MMAP_NONINTERLEAVED
> FORMAT:  S16_LE S32_LE
> SUBFORMAT:  STD
> SAMPLE_BITS: ALL
> FRAME_BITS: ALL
> CHANNELS: 2
> RATE: 192000
> PERIOD_TIME: (20 682667)
> PERIOD_SIZE: [4 131072]
> PERIOD_BYTES: ALL
> PERIODS: [2 32]
> BUFFER_TIME: (41 1365334)
> BUFFER_SIZE: [8 262144]
> BUFFER_BYTES: ALL
> TICK_TIME: ALL
> srefine 'loop_44100_16' (slave)
> ACCESS:  MMAP_INTERLEAVED MMAP_NONINTERLEAVED MMAP_COMPLEX
> FORMAT:  S16_LE
> SUBFORMAT:  STD
> SAMPLE_BITS: ALL
> FRAME_BITS: ALL
> CHANNELS: 2
> RATE: [48000 48001)
> PERIOD_TIME: (20 682667)
> PERIOD_SIZE: ALL
> PERIOD_BYTES: ALL
> PERIODS: ALL
> BUFFER_TIME: ALL
> BUFFER_SIZE: [2 65538)
> BUFFER_BYTES: ALL
> TICK_TIME: ALL
> REFINE called:
> ACCESS:  MMAP_INTERLEAVED MMAP_NONINTERLEAVED MMAP_COMPLEX
> FORMAT:  S16_LE
> SUBFORMAT:  STD
> SAMPLE_BITS: ALL
> FRAME_BITS: ALL
> CHANNELS: 2
> RATE: [48000 48001)
> PERIOD_TIME: (20 682667)
> PERIOD_SIZE: ALL
> PERIOD_BYTES: ALL
> PERIODS: ALL
> BUFFER_TIME: ALL
> BUFFER_SIZE: [2 65538)
> BUFFER_BYTES: ALL
> TICK_TIME: ALL
> refine done - result = 0
> 
> 
> lano1106@Wailaba2 ~/dev/alsa_debug $ diff refine_success.txt
> refine_fail.txt 
> 49c49,50
> < refine done - result = 0
> ---
> > refine done - result = -22
