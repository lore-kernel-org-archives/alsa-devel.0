From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 4/4] ALSA: pcm_dmaengine: Properly
 synchronize DMA on shutdown
Date: Tue, 20 Oct 2015 13:40:00 +0200
Message-ID: <56262810.3040201@metafoo.de>
References: <1445334391-12272-1-git-send-email-lars@metafoo.de>	<1445334391-12272-5-git-send-email-lars@metafoo.de>
 <s5h37x5g56w.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-188.synserver.de (smtp-out-200.synserver.de
 [212.40.185.200])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A16A26533F
 for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2015 13:40:08 +0200 (CEST)
In-Reply-To: <s5h37x5g56w.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Vinod Koul <vinod.koul@intel.com>, Shengjiu Wang <shengjiu.wang@freescale.com>, linux-kernel@vger.kernel.org, Qiao Zhou <zhouqiao@marvell.com>, Laurent Pinchart <renesas@ideasonboard.com>, Matt Campbell <mcampbell@izotope.com>, dmaengine@vger.kernel.org, Russell King <rmk+kernel@arm.linux.org.uk>, Dan Williams <dan.j.williams@intel.com>, Jonah Petri <jpetri@izotope.com>
List-Id: alsa-devel@alsa-project.org

On 10/20/2015 01:17 PM, Takashi Iwai wrote:
> On Tue, 20 Oct 2015 11:46:31 +0200,
> Lars-Peter Clausen wrote:
>>
>> Use the new dmaengine_synchronize() function to make sure that all complete
>> callbacks have finished running before the runtime data, which is accessed
>> in the completed callback, is freed.
>>
>> This fixes a long standing use-after-free race condition that has been
>> observed on some systems.
> 
> What if a substream is restarted immediately after the stop?
> 

What can happen is that you get a complete callback and the associated
snd_pcm_period_elapsed() too early, before the period has actually elapsed,
but I don't think that this is a problem if the DMA driver properly
implements residue reporting.

This fails if we rely on period counting, but that is broken anyway and
already prone to other race conditions.

I've tested this series with xrun injection and some modifications to the
DMA driver to always trigger the race condition when the stream is stopped.
And I've not seen any issues after the transfer re-started. (There is a
dead-lock condition though but that does not seem to be related to this series)
