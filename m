From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoc: wm8731: add normal mode with
 12MHz XTAL
Date: Mon, 20 Jun 2016 11:55:40 +0100
Message-ID: <20160620105540.GI1552@localhost.localdomain>
References: <1465517516-1917-1-git-send-email-flatmax@flatmax.org>
 <1465517516-1917-2-git-send-email-flatmax@flatmax.org>
 <575BD6F2.70600@flatmax.org> <575CD572.2040700@flatmax.org>
 <CAMv2zM8txnDEPh9Gebbt7KC7YuvEyOFxTomnnaRdu8SLyme5bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C0C026507F
 for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2016 12:55:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAMv2zM8txnDEPh9Gebbt7KC7YuvEyOFxTomnnaRdu8SLyme5bw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Calhoun <rcalhoun@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, patches@opensource.wolfsonmicro.com, Matt Flax <flatmax@flatmax.org>
List-Id: alsa-devel@alsa-project.org

On Sun, Jun 19, 2016 at 05:46:02PM -0400, Rob Calhoun wrote:
> Hi Matt,
> 
> Based on my experience with the WM8737, the bitclock will always run
> at 12 MHz on these devices in USB mode. While the carrying capacity of
> the channel is always 12 Mbps, the data put on the wire by the codec
> depend on the sample rate, number of channels, and bit depth. This
> leaves some unused capacity in the channel. It is the responsibility
> of the receiving digital audio interface to pull off the appropriate
> number of bits every time the LRCLK/frameclock fires and ignore the
> rest of it. For example in I2S mode, 2-channel, 32-bit, the DAI should
> pull off the first 32 bits following each LRCLK transition.

Thanks very much for adding this, sounds like this is basically
how the part operates then. Although I feel the datasheet could
have been more clear, apologies for that.

Thanks,
Charles
