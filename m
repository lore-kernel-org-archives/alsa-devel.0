From: Daniel Mack <daniel@zonque.org>
Subject: Re: ALSA - Channel swap
Date: Wed, 20 Aug 2014 15:00:44 +0200
Message-ID: <53F49BFC.6010306@zonque.org>
References: <53F35310.2040300@tcz.cz> <53F377BB.90309@zonque.org>
 <53F49680.2050003@tcz.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 951932656ED
 for <alsa-devel@alsa-project.org>; Wed, 20 Aug 2014 15:00:45 +0200 (CEST)
In-Reply-To: <53F49680.2050003@tcz.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tomas Matejka <tomas.matejka@tcz.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 08/20/2014 02:37 PM, Tomas Matejka wrote:
> My kernel version is 3.2.18.
> I can't uderstand this, does this mean that using Atmel, Linux and audio 
> codec always result to channel swapping?
> It would be very strange. How could codec manufacturer sell codec, which 
> swaps channels ?

Also, as I've told you before, the Codec is most probably not the
cultprit here. Try and play a wave file that only has signal on the left
side, and provide some input to the Codec's left channel only. Then see
what your scope shows on the SDIN/SDOUT lines, while putting the trigger
on the LRCLK. If your Codec is causing the problem, you'll already see
the channel swap on the bus, but I bet you won't. Instead, the problem
is in how the Atmel I2S hardware block transports the data into and out
of your memory, and that's likely related to its DMA implementation.

Anyway - the first step is to boot an up-to-date kernel.


Daniel
