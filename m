From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: Audio quality issue - regular clicks are observed
Date: Wed, 22 Aug 2007 21:16:32 +0100
Message-ID: <1187813792.16454.39.camel@localhost.localdomain>
References: <61445c750708220943k1c410147pa0dddf4d950eb08c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id 070841037EE
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Aug 2007 22:16:34 +0200 (CEST)
In-Reply-To: <61445c750708220943k1c410147pa0dddf4d950eb08c@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Pharaoh ." <pharaoh137@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2007-08-22 at 22:13 +0530, Pharaoh . wrote:
> Hi
> While testing the audio driver using aplay in blocking mode, a periodic
> murmur is observed, this increases with
> the audio volume and occurs even when there are no issues like xrun etc.
> Aplay was used in normal read/write mode
> i.e. no mmap. The song can be heard properly i.e. with no noticable gaps aur
> hisses but the clicks are audible.

Clock domain mismatch issues cause periodic ticks that increase in
frequency with increasing sample rate. It's possible your clocking the
codec and controller in two different clock domains. i.e. I2S controller
(bitclk and frame) clocked from CPU and codec clocked from separate
crystal.

It's best to make sure that only one clock is clocking both the codec
and digital audio interface. 

Liam
