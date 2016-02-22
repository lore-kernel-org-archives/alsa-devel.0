From: Mengdong Lin <mengdong.lin@linux.intel.com>
Subject: Re: [PATCH] ASoC: topology: Fix setting of stream
 rates, rate_min and rate_max
Date: Mon, 22 Feb 2016 16:31:26 +0800
Message-ID: <56CAC75E.4020503@linux.intel.com>
References: <1455603146-6138-1-git-send-email-mengdong.lin@linux.intel.com>
 <201602161403.uifzZpWI%fengguang.wu@intel.com>
 <20160219161651.GW18327@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 641FE260789
 for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2016 09:30:14 +0100 (CET)
In-Reply-To: <20160219161651.GW18327@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, kbuild test robot <lkp@intel.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, vinod.koul@intel.com, hardik.t.shah@intel.com, liam.r.girdwood@linux.intel.com, kbuild-all@01.org, mengdong.lin@intel.com, jeeja.kp@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org



On 02/20/2016 12:16 AM, Mark Brown wrote:
> On Tue, Feb 16, 2016 at 02:27:32PM +0800, kbuild test robot wrote:
>
>>     sound/soc/soc-topology.c: In function 'set_stream_info':
>>>> sound/soc/soc-topology.c:1588:1: warning: no return statement in function returning non-void [-Wreturn-type]
>>      }
>>      ^
>
> This is a real bug that 0day has identified.
>

I'm sorry for the bug. Fixed this in v2 patch.

Thanks
Mengdong
