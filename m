From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v4] ALSA: Add SoC on-chip internal memory
 support for DMA buffer allocation
Date: Wed, 16 Oct 2013 18:33:52 +0200
Message-ID: <525EBFF0.1080303@metafoo.de>
References: <1381920801-9187-1-git-send-email-b42378@freescale.com>
 <20131016115847.GK2443@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-205.synserver.de (smtp-out-205.synserver.de
 [212.40.185.205])
 by alsa0.perex.cz (Postfix) with ESMTP id F2C14261A42
 for <alsa-devel@alsa-project.org>; Wed, 16 Oct 2013 18:31:50 +0200 (CEST)
In-Reply-To: <20131016115847.GK2443@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Nicolin Chen <b42378@freescale.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On 10/16/2013 01:58 PM, Mark Brown wrote:
> On Wed, Oct 16, 2013 at 06:53:21PM +0800, Nicolin Chen wrote:
> 
>> +	if (!dev->of_node)
>> +		return NULL;
>> +
>> +	pool = of_get_named_gen_pool(dev->of_node, "iram", 0);
>> +	if (!pool)
>> +		return NULL;
> 
> Can you refactor these ifdefs so they just protect this OF specific code
> and just have the allocation fail otherwise please?  That way the OF
> dependency is minimised - we should be able to support this on other
> platforms in the future and the rest of the code will be the same.
> 
> Also is iram the best name?  It makes me think of the dedicated fast
> instruction RAM that some processors have.  sram perhaps (for static
> RAM)?

Using IRAM (internal SRAM) for this seems to be quite popular (`grep IRAM
arch/arm -r`). Existing devicetree bindings also seem to use the 'iram'
property to refer to the on-chip SRAM
(Documentation/devicetree/bindings/media/coda.txt). It's probably a good
idea to stay consistent with the existing bindings.

- Lars
