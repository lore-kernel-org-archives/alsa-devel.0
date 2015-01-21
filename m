From: Qais Yousef <qais.yousef@imgtec.com>
Subject: Re: alsa-lib support for compress offload
Date: Wed, 21 Jan 2015 09:22:41 +0000
Message-ID: <54BF6FE1.3000203@imgtec.com>
References: <54B8DF7A.6000700@imgtec.com> <s5hbnlzt3o2.wl-tiwai@suse.de>
 <54B8F485.7090603@imgtec.com> <54B9413F.805@linux.intel.com>
 <54BD3D7F.6020105@imgtec.com> <54BD8036.5070405@linux.intel.com>
 <54BE25B7.1040606@imgtec.com> <20150121071053.GC28763@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 8598F261A2F
 for <alsa-devel@alsa-project.org>; Wed, 21 Jan 2015 10:22:43 +0100 (CET)
In-Reply-To: <20150121071053.GC28763@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.jf.intel.com>
List-Id: alsa-devel@alsa-project.org

On 01/21/2015 07:10 AM, Vinod Koul wrote:
> Sorry for delayed reply, I am travelling.

Thanks for taking the time to answer.

>
> tinycompress comes with dual license LGPL and BSD. Currently the main user of
> this is Android which picks up the BSD license.
>
> Though I am not a lawyer, but I don't see a reason if alsa-lib uses LGPL
> license to take this lib and include compress support in alsa-lib. This
> way we have code reuse and take advantage of alsa-lib to support compress
> formats too. Takashi is that fine with you?
>
> I would hate if we had to rewrite the simple wrappers over IOCTLs to support
> compress in alsa-lib!
>
> Thanks
>

Unless Takashi comes up with an objection, I'll work just on that.

Thanks,
Qais
