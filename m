From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/2] ASoC: dmaengine_pcm: Reset pointer
 position when starting a stream
Date: Thu, 08 Mar 2012 11:26:57 +0100
Message-ID: <4F588971.4010302@metafoo.de>
References: <1330952535-30614-1-git-send-email-lars@metafoo.de>
	<20120305130917.GL3224@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-087.synserver.de (smtp-out-087.synserver.de
	[212.40.185.87])
	by alsa0.perex.cz (Postfix) with ESMTP id 92C0010B8F1
	for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2012 11:25:03 +0100 (CET)
In-Reply-To: <20120305130917.GL3224@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mika Westerberg <mika.westerberg@iki.fi>
Cc: Vinod Koul <vinod.koul@linux.intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 03/05/2012 02:09 PM, Mark Brown wrote:
> On Mon, Mar 05, 2012 at 02:02:14PM +0100, Lars-Peter Clausen wrote:
>> From: Mika Westerberg <mika.westerberg@iki.fi>
>>
>> Otherwise a wrong position will be reported after restarting a stream and the
>> first few samples might be skipped.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> 
> I can't apply this without a signoff from Mika.

Mika, can we get your sign off for this patch?

Thanks,
- Lars
