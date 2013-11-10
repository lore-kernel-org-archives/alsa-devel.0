From: Qiao Zhou <zhouqiao@marvell.com>
Subject: Re: [PATCH V0] ASoC: pxa-ssp: add TISSP mode support
Date: Sun, 10 Nov 2013 09:50:21 +0800
Message-ID: <527EE65D.3070804@marvell.com>
References: <1383640208-11919-1-git-send-email-zhouqiao@marvell.com>
 <20131106112421.GI11602@sirena.org.uk> <527C43D0.2030301@marvell.com>
 <20131108101948.GD2493@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 13F22261A90
 for <alsa-devel@alsa-project.org>; Sun, 10 Nov 2013 02:50:29 +0100 (CET)
In-Reply-To: <20131108101948.GD2493@sirena.org.uk>
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

On 11/08/2013 06:19 PM, Mark Brown wrote:
> On Fri, Nov 08, 2013 at 09:52:16AM +0800, Qiao Zhou wrote:
>> On 11/06/2013 07:24 PM, Mark Brown wrote:
>
>>> What is TISSP mode in an audio context?
>
>> It's normal SSP mode, and it has a pulse of one bit clock width,
>
> OK, what is SSP mode?
SSP mode is just one frame format defined in sscr0 register, and there 
are 3 other mode, such as SPI mode, National Semiconductor 
Microwire(NSM) mode, Programmable Serial Protocol(PSP) mode.
The SPI/NSM are not used for audio usage, and currently only PSP mode is 
used pxa-ssp driver. We have the requirement now to support this SSP 
mode. The benefit is that we don't need to configure detailed timing in 
transmit/receiving since HW handles it automatically.
The SSP mode is something like the PCM format for mono stream for voice 
related scenario. In current audio format definition and pxa-ssp driver 
implementation, I don't find suitable way to handle it. so I add such 
SSP-format to differentiate it from PSP mode. Do I make a confusion of 
SSP mode and audio frame format? please help comment. thanks.
>


-- 

Best Regards
Qiao
