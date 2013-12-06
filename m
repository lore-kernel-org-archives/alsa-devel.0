From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ASoC: omap-pcm: Lower the dma coherent
	mask to 32bits
Date: Fri, 6 Dec 2013 12:33:02 +0000
Message-ID: <20131206123302.GM4360@n2100.arm.linux.org.uk>
References: <1386230802-3660-1-git-send-email-peter.ujfalusi@ti.com>
 <20131205095619.GC4360@n2100.arm.linux.org.uk> <52A09CDA.6010700@ti.com>
 <20131205192853.GH4360@n2100.arm.linux.org.uk> <52A19988.9060806@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 98DEA2610A3
 for <alsa-devel@alsa-project.org>; Fri,  6 Dec 2013 13:33:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <52A19988.9060806@ti.com>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 06, 2013 at 11:31:52AM +0200, Peter Ujfalusi wrote:
> On 12/05/2013 09:28 PM, Russell King - ARM Linux wrote:
> > gives us the very last PFN which the bus associated with dev is able to
> > address.  Hmm - so I got the test wrong on both twice - they should both
> > be:
> > 
> >  	if (sizeof(mask) != sizeof(dma_addr_t) &&
> >  	    mask > (dma_addr_t)~0 &&
> >  	    dma_to_pfn(dev, ~0) < min(max_pfn, arm_dma_pfn_limit))
> > 		return 0;
> > 
> > since we want to fail if we have _more_ memory than the bus will allow.
> > Can you try the above in both locations please?
> 
> Thanks, works fine.
> I will be out for a long weekend so you can add my:
> 
> Tested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Thanks Peter.
