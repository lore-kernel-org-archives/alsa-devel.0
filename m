From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 10/13] soundwire: cdns: Add port routines
Date: Fri, 6 Apr 2018 14:25:25 +0530
Message-ID: <20180406085524.GL6014@localhost>
References: <1522946904-2089-1-git-send-email-vinod.koul@intel.com>
 <1522946904-2089-11-git-send-email-vinod.koul@intel.com>
 <cc86f00d-dcf8-6609-ba01-f97ec69807d1@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id DD857266E30
 for <alsa-devel@alsa-project.org>; Fri,  6 Apr 2018 10:51:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <cc86f00d-dcf8-6609-ba01-f97ec69807d1@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: ALSA <alsa-devel@alsa-project.org>, tiwai@suse.de, Greg KH <gregkh@linuxfoundation.org>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 05, 2018 at 07:19:43PM -0500, Pierre-Louis Bossart wrote:
> On 4/5/18 11:48 AM, Vinod Koul wrote:

> >+static int cdns_allocate_pdi(struct sdw_cdns *cdns,
> >+			struct sdw_cdns_pdi **stream,
> >+			u32 start, u32 num, u32 pdi_offset)
> 
> the start parameter doesn't seem to be used, remove and remove the useless
> zeroes in all the calls to this routine?

Yes this seems to be the case, will fix

> >+
> >+pdm_error:
> >+	kfree(stream->bd);
> >+	kfree(stream->in);
> >+	kfree(stream->out);
> >+
> >+pcm_error:
> >+	stream = &cdns->pcm;
> >+	kfree(stream->bd);
> >+	kfree(stream->in);
> >+	kfree(stream->out);
> 
> call me a grumpy old fart if you want, I still don't like people freeing
> memory they never allocated. It may be legal but it's sloppy.

Actually looking at it freeing is not required as we are doing devm_
allocations, so this can be removed and return error should do the trick and
we propagate the error and cleanup, thanks for the catch

-- 
~Vinod
