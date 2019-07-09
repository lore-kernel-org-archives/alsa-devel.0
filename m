From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH 3/4] ALSA: compress: Don't allow drain
 operations on capture streams
Date: Tue, 9 Jul 2019 13:58:33 +0100
Message-ID: <20190709125833.GJ54126@ediswmail.ad.cirrus.com>
References: <20190709105211.11741-1-ckeepax@opensource.cirrus.com>
 <20190709105211.11741-3-ckeepax@opensource.cirrus.com>
 <20190709113633.GL2911@vkoul-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BFA7EF801A4
 for <alsa-devel@alsa-project.org>; Tue,  9 Jul 2019 14:58:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20190709113633.GL2911@vkoul-mobl>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 09, 2019 at 05:06:33PM +0530, Vinod Koul wrote:
> On 09-07-19, 11:52, Charles Keepax wrote:
> > would make sense on a capture stream but currently the implementation
> > of drain involves the kernel waiting for the DSP to consume its
> > available data, whereas a capture drain would involve waiting for
> > user-space to consume the data available on the DSP. Disallow drain
> > on capture streams until that is implemented.
> 
> Well it in unclear to me about the support required in kernel! Kernel
> issues drain request to DSP and waits for that to be done. When DSP has
> encoded and copied the data the notification should make drain complete.
> So I dont see anything in kernel required for that
> 

Ok that makes sense I think what I missed there is we are looking
at the capture drain being complete when the data is in the DSP
buffer, not when it has been pulled by user-space as I had.

I will update the patch to remove this one.

Thanks,
Charles
