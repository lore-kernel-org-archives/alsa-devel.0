From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH] ASoC: omap-mcbsp: On OMAP1 and OMAP2420
 only 16bit format is supported
Date: Fri, 26 Oct 2018 09:06:10 +0300
Message-ID: <20181026060610.GA12498@bitmer.com>
References: <20181025134824.16527-1-peter.ujfalusi@ti.com>
 <20181026060044.GA12256@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bitmer.com (50-87-157-213.static.tentacle.fi [213.157.87.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 59E382679C6
 for <alsa-devel@alsa-project.org>; Fri, 26 Oct 2018 08:06:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20181026060044.GA12256@bitmer.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, aaro.koskinen@iki.fi
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 26, 2018 at 09:00:44AM +0300, Jarkko Nikula wrote:
> On Thu, Oct 25, 2018 at 04:48:24PM +0300, Peter Ujfalusi wrote:
> > I have noticed that on Nokia n810 32bit samples just don't work at all for audio
> > 
> > Regards,
> > Peter
> > 
> >  sound/soc/omap/omap-mcbsp.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> I guess this same holds for OMAP1 too as it has 16-bit McBSP registers
> too.
>
Never mind, I forgot the subject line which mention the OMAP1 while
reading the patch and looking at the code. -ENOCOFFEE yet.

> Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>

Above holds.

-- 
Jarkko
