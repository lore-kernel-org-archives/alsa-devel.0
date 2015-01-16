From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: alsa-lib support for compress offload
Date: Fri, 16 Jan 2015 10:50:07 -0600
Message-ID: <54B9413F.805@linux.intel.com>
References: <54B8DF7A.6000700@imgtec.com> <s5hbnlzt3o2.wl-tiwai@suse.de>
 <54B8F485.7090603@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A116260414
 for <alsa-devel@alsa-project.org>; Fri, 16 Jan 2015 17:50:53 +0100 (CET)
In-Reply-To: <54B8F485.7090603@imgtec.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Qais Yousef <qais.yousef@imgtec.com>, Takashi Iwai <tiwai@suse.de>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org


>> It's a normal IEC958 passthrough, nothing to do with the compress
>> offload.  And, no, we have no support for compress API in alsa-lib
>> yet.  Just because no one submitted the patches.
>
> Thanks. I haven't used alsa-lib before but I might be able to send the
> patches if I get guidance of what needs doing. Is the expected API
> similar/same to what provided by tinycompress[1]?
>
> [1]
> http://git.alsa-project.org/?p=tinycompress.git;a=blob;f=include/tinycompress/tinycompress.h;h=03c396fccea5f2a176d24fd580ee6a447da657ec;hb=HEAD

Since there is no allowed processing/reformatting/reshuffling of 
compressed data, all the plugin system needs to be bypassed and you'd be 
looking at an alsa-lib API that interfaces directly with the ioctls, 
essentially replicating what tinycompress does. I agree it's not great 
to have independent packages, the decision to maintain tinycompress 
separately was driven by licensing concerns, not technical ones.
-Pierre
