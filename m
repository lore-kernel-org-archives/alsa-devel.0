From: Jack Mitchell <ml@communistcode.co.uk>
Subject: Re: [3.13-rc8] AM335x BeagleBone Buffer XRUN
Date: Thu, 16 Jan 2014 10:44:53 +0000
Message-ID: <52D7B825.30305@communistcode.co.uk>
References: <52D59E8A.1010400@communistcode.co.uk>
Reply-To: ml@communistcode.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from owm.eumx.net (eumx.net [91.82.101.43])
 by alsa0.perex.cz (Postfix) with ESMTP id AB3882608E8
 for <alsa-devel@alsa-project.org>; Thu, 16 Jan 2014 11:44:51 +0100 (CET)
In-Reply-To: <52D59E8A.1010400@communistcode.co.uk>
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

On 14/01/14 20:31, Jack Mitchell wrote:
> I am currently trying to debug a buffer overrun when capturing with the
> BeagleBone Black and Audio Cape attached on 3.13-rc8, this is pretty
> much the same setup as the am335x-evm. The following is the traceback
> captured using the XRUN_BUFFER_DEBUG kernel config option. I think an
> interrupt is taking too long to return.
>
> [snip
> 

Ok, so I managed to enlarge the buffer by increasing the
max_buffer_bytes in snd_pcm_hardware capture struct. However, it doesn't
really make sense... The original value was (128*1024) which should give
a buffer of 128K, but in reality it gave a buffer of 32K. Now when I was
hacking last night it got to the point where I just started twiddling
knobs to see what would happen, and it turns out that changing the
max_buffer_bytes to (256*1024) gave me 64K of buffer. So, I don't have a
clue what is going on here, but I now have enough buffer to get the
audio data captured and written out before an overflow occurs.

Cheers,

-- 
  Jack Mitchell (jack@embed.me.uk)
  Embedded Systems Engineer
  Cambridgeshire, UK
  http://www.embed.me.uk
-- 
