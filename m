From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Proposal for more reliable audio DMA.
Date: Thu, 25 Jun 2009 00:26:16 -0400
Message-ID: <9e4733910906242126v30add6d5r150f992aed6694dd@mail.gmail.com>
References: <378E7985-7CD3-4009-AA14-127391A819F2@opensource.wolfsonmicro.com>
	<9e4733910906241207m50340ef5gd63fc4527e50b861@mail.gmail.com>
	<s5hprctmj5x.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.145])
	by alsa0.perex.cz (Postfix) with ESMTP id B037724A5D
	for <alsa-devel@alsa-project.org>;
	Thu, 25 Jun 2009 06:26:17 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 5so632089qwf.56
	for <alsa-devel@alsa-project.org>; Wed, 24 Jun 2009 21:26:16 -0700 (PDT)
In-Reply-To: <s5hprctmj5x.wl%tiwai@suse.de>
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
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, James Courtier-Dutton <james.dutton@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 24, 2009 at 5:11 PM, Takashi Iwai<tiwai@suse.de> wrote:
>> The problem is knowing which sample in the background music to start
>> mixing the low latency laser blast into.
>
> That's why querying the accurate hwptr is important in PA.

I'm still not convinced that all of this logic should be exposed to
PA. Exposing these details is what makes ALSA hard to use. We should
be able to better isolate user space from this. If mixing were moved
into the kernel these details could be hidden.  The in-kernel code
could then be customized for various sound DMA hardware. This would
also go a long ways toward getting rid of latency issues by removing
the need for real-time response from PA.

My hardware doesn't have the capability of querying the hwptr and the
hwptr speed is not linear because of the FIFO and burst transfers.
Non-linear speed means I can't use a clock to estimate hwptr. I do
however have the capability of directing the DMA into a new buffer.
Another thing I could try is setting up DMA descriptor chain blocks
for every 16 bytes. These descriptors get marked as they are used and
they don't have to cause an interrupt.

We are evaluating a processor change from PPC to ARM so all of this
may change for me.

-- 
Jon Smirl
jonsmirl@gmail.com
