From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: C-Media CM6533 limited sample rate
Date: Fri, 10 Nov 2017 12:49:46 +0100
Message-ID: <a58d7b22-548a-27c0-b3b2-9669a7e4018d@ladisch.de>
References: <CAKkO-Eh96_VQpQVyMCqbBkm3tgmxB26jm7ufpBRHrA8CqyugSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.179])
 by alsa0.perex.cz (Postfix) with ESMTP id E989226792F
 for <alsa-devel@alsa-project.org>; Fri, 10 Nov 2017 12:49:30 +0100 (CET)
Received: from [10.1.2.4] (unknown [94.101.37.79])
 by webclient5.webclient5.de (Postfix) with ESMTPSA id 9ED4D55828DF
 for <alsa-devel@alsa-project.org>; Fri, 10 Nov 2017 12:49:29 +0100 (CET)
In-Reply-To: <CAKkO-Eh96_VQpQVyMCqbBkm3tgmxB26jm7ufpBRHrA8CqyugSg@mail.gmail.com>
Content-Language: en-US
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

Luigi Tarenga wrote:
> The datasheet say the chip support PCM at 8K/11.025K/16K/22.05K/32K/
> 44.1K/48K/96K Hz with 16 or 24 bit depth.

Or not; see footnote 2 on page 7.

> is the firmware on the chip that limit the hardware capabilities and
> when queried by the driver it report only 2 sample rates?

Yes.

> do you think adding a quirk for this chip and trying to overcome the
> firmware configuration and adding support for other sample rate can
> be a solution?

Maybe.

Please find out how you can recompile the kernel of your distribution.


Regards,
Clemens
