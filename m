From: Qiao Zhou <zhouqiao@marvell.com>
Subject: Re: [PATCH V0] ASoC: pxa-ssp: add TISSP mode support
Date: Mon, 11 Nov 2013 10:03:46 +0800
Message-ID: <52803B02.6000008@marvell.com>
References: <1383640208-11919-1-git-send-email-zhouqiao@marvell.com>
 <20131106112421.GI11602@sirena.org.uk> <527C43D0.2030301@marvell.com>
 <20131108101948.GD2493@sirena.org.uk> <527EE65D.3070804@marvell.com>
 <20131110111021.GB878@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by alsa0.perex.cz (Postfix) with ESMTP id ADA0E260815
 for <alsa-devel@alsa-project.org>; Mon, 11 Nov 2013 03:03:55 +0100 (CET)
In-Reply-To: <20131110111021.GB878@sirena.org.uk>
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

On 11/10/2013 07:10 PM, Mark Brown wrote:
> On Sun, Nov 10, 2013 at 09:50:21AM +0800, Qiao Zhou wrote:
>> On 11/08/2013 06:19 PM, Mark Brown wrote:
>
>> The SPI/NSM are not used for audio usage, and currently only PSP
>> mode is used pxa-ssp driver. We have the requirement now to support
>> this SSP mode. The benefit is that we don't need to configure
>> detailed timing in transmit/receiving since HW handles it
>> automatically.
>
>> The SSP mode is something like the PCM format for mono stream for
>> voice related scenario. In current audio format definition and
>> pxa-ssp driver implementation, I don't find suitable way to handle
>> it. so I add such SSP-format to differentiate it from PSP mode. Do I
>> make a confusion of SSP mode and audio frame format? please help
>> comment. thanks.
>
> If this is just about programming the hardware better rather than
> changing the externally visible symbols then as Daniel says it should be
> handled transparently by the driver, replacing the current code for
> whatever formats are handled.  Normally the same DAI format should be
> configured for both CODEC and CPU so unless a new format should also be
> used by CODEC drivers the update ought to be internal to the driver.
>
Yes, it should be an improvement of current driver. The format is not a 
new one, and the DSP_A mode is suitable for it. The question here is to 
handle both PSP and SSP mode here. should I pass another parameter here 
to support it?

-- 

Best Regards
Qiao
