From: Qiao Zhou <zhouqiao@marvell.com>
Subject: Re: [PATCH V0] ASoC: pxa-ssp: add TISSP mode support
Date: Fri, 15 Nov 2013 16:57:23 +0800
Message-ID: <5285E1F3.9010406@marvell.com>
References: <1383640208-11919-1-git-send-email-zhouqiao@marvell.com>
 <20131106112421.GI11602@sirena.org.uk> <527C43D0.2030301@marvell.com>
 <20131108101948.GD2493@sirena.org.uk> <527EE65D.3070804@marvell.com>
 <20131110111021.GB878@sirena.org.uk> <52803B02.6000008@marvell.com>
 <20131111112115.GF2674@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by alsa0.perex.cz (Postfix) with ESMTP id AA8A1260323
 for <alsa-devel@alsa-project.org>; Fri, 15 Nov 2013 09:57:29 +0100 (CET)
In-Reply-To: <20131111112115.GF2674@sirena.org.uk>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Eric Miao <eric.y.miao@gmail.com>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, "trinity.qiao.zhou@gmail.com" <trinity.qiao.zhou@gmail.com>, Chao Xie <cxie4@marvell.com>
List-Id: alsa-devel@alsa-project.org

On 11/11/2013 07:21 PM, Mark Brown wrote:
> On Mon, Nov 11, 2013 at 10:03:46AM +0800, Qiao Zhou wrote:
>
>> Yes, it should be an improvement of current driver. The format is
>> not a new one, and the DSP_A mode is suitable for it. The question
>> here is to handle both PSP and SSP mode here. should I pass another
>> parameter here to support it?
>
> Can't the driver just do whatever is best automatically - why would the
> user need to configure things?
>
Hi Mark,

I'll check and replace the PSP mode setting with SSP for DSP_x mode. 
Thanks a lot for the instruction.
-- 

Best Regards
Qiao
