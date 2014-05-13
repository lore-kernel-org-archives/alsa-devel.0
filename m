From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH 2/2] ASoC: Intel: Use ACPI device for
 Baytrail PCM buffer allocation
Date: Tue, 13 May 2014 10:30:12 +0300
Message-ID: <5371CA04.5060605@linux.intel.com>
References: <1399643264-7669-1-git-send-email-jarkko.nikula@linux.intel.com>
 <1399643264-7669-2-git-send-email-jarkko.nikula@linux.intel.com>
 <20140512221050.GB12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id D1A54265310
 for <alsa-devel@alsa-project.org>; Tue, 13 May 2014 09:30:15 +0200 (CEST)
In-Reply-To: <20140512221050.GB12304@sirena.org.uk>
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

On 05/13/2014 01:10 AM, Mark Brown wrote:
> On Fri, May 09, 2014 at 04:47:44PM +0300, Jarkko Nikula wrote:
>> This follows the same idea than commit 10df350977b1
>> ("ASoC: Intel: Fix Audio DSP usage when IOMMU is enabled.") by using only
>> ACPI device for all DMA allocations. Since DMA masking is already done in
>> firmware loading it can be removed from here.
> Is this needed as a bug fix?
Not really. AFAIK this IOMMU issues doesn't hit on Baytrail so this 2/2 
is more like keeping code in sync.

-- 
Jarkko
