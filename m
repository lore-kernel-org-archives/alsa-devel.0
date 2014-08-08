From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: SGTL500 and its external MCLK
Date: Fri, 8 Aug 2014 13:29:20 +0800
Message-ID: <20140808052901.GA6028@MrMyself>
References: <CAKON4OxRr-igCSZ2HwXcKGFT7O6sQjJUMP_aF19kSRP59ZxFew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0186.outbound.protection.outlook.com [207.46.163.186])
 by alsa0.perex.cz (Postfix) with ESMTP id D797D2654A6
 for <alsa-devel@alsa-project.org>; Fri,  8 Aug 2014 07:31:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAKON4OxRr-igCSZ2HwXcKGFT7O6sQjJUMP_aF19kSRP59ZxFew@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, zengzm.kernel@gmail.com, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 07, 2014 at 03:37:47PM -0400, jonsmirl@gmail.com wrote:
> Since the sgtl5000 driver has the handle to the clock, can't it just
> ask the clock for its rate? If it directly asked the clock for its
> rate it looks like this codec could be bound with simple-audio-card
> and not need a machine driver.

I think Simple Card should already have the capability to support
this without changing sgtl5000's code. It has two properties that
can make it call set_sysclk() for you during the init(). They are
'clocks' and 'system-clock-frequency'. Please refer to its binding
doc for details.

And the topic why not let sgtl5000 fully control the clock has been
discussed in this thread:
http://comments.gmane.org/gmane.linux.alsa.devel/109093

So I think the change can be done as well?

Best regards,
Nicolin
