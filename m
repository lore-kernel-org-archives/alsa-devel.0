From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 18/21] ASoC: SOF: Intel: hda: fix link DMA
 config
Date: Tue, 23 Jul 2019 09:37:47 -0500
Message-ID: <cabe9c2b-359d-deb6-93ee-e42b1400ea27@linux.intel.com>
References: <20190722141402.7194-1-pierre-louis.bossart@linux.intel.com>
 <20190722141402.7194-19-pierre-louis.bossart@linux.intel.com>
 <20190723111515.GD5365@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 302D7F800E8
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2019 16:37:49 +0200 (CEST)
In-Reply-To: <20190723111515.GD5365@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Mark Brown <broonie@kernel.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Rander Wang <rander.wang@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On 7/23/19 6:15 AM, Mark Brown wrote:
> On Mon, Jul 22, 2019 at 09:13:59AM -0500, Pierre-Louis Bossart wrote:
>> From: Rander Wang <rander.wang@linux.intel.com>
>>
>> For this bug, there are two capture pcm streams active, with one
>> stream and its related stream tag released before suspend. Later
>> when system suspend is done, the stream tag for the remaining
> 
> In general fixes should come at the start of a series so that they can
> be applied as such and sent to Linus without getting caught up with
> dependencies on development work.

Yes, but in this case we had two developers that changed the code and I 
couldn't really move code around too much.
You have a good point though, we should ask for the 'fix' subject to be 
used really for true fixes that should have a more direct integration 
path or go to linux-stable.
Thanks for the merges.
