From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH 1/2] ASoC: Intel: Fix Baytrail SST DSP
	firmware loading
Date: Tue, 13 May 2014 10:22:08 +0300
Message-ID: <5371C820.6010207@linux.intel.com>
References: <1399643264-7669-1-git-send-email-jarkko.nikula@linux.intel.com>
 <20140512220945.GA12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id B74CD265460
 for <alsa-devel@alsa-project.org>; Tue, 13 May 2014 09:25:51 +0200 (CEST)
In-Reply-To: <20140512220945.GA12304@sirena.org.uk>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 05/13/2014 01:09 AM, Mark Brown wrote:
> On Fri, May 09, 2014 at 04:47:43PM +0300, Jarkko Nikula wrote:
>> Commit 10df350977b1 ("ASoC: Intel: Fix Audio DSP usage when IOMMU is
>> enabled.") caused following regression in Baytrail SST:
>>
>> baytrail-pcm-audio baytrail-pcm-audio: error: DMA alloc failed
>> baytrail-pcm-audio baytrail-pcm-audio: error: failed to load firmware
> Is this needed on fix/intel?  If so it doesn't apply there...
Indeed it doesn't. I accidentally made it on top of my suspend/resume 
set and it appears to conflict without [PATCH 4/7] ASoC: Intel: Move 
Baytrail extended fw address saving to sst_byt_boot()".

In case you are thinking to queue Liam's 10df350977b1 as a fix Is it ok 
if I resend this on top of it and handle conflict when merging 
origin/topic/intel?

-- 
Jarkko
