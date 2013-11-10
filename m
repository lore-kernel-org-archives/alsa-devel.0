From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH V0] ASoC: pxa-ssp: add TISSP mode support
Date: Sun, 10 Nov 2013 10:29:06 +0100
Message-ID: <527F51E2.7010401@zonque.org>
References: <1383640208-11919-1-git-send-email-zhouqiao@marvell.com>
 <20131106112421.GI11602@sirena.org.uk> <527C43D0.2030301@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D7F6261A86
 for <alsa-devel@alsa-project.org>; Sun, 10 Nov 2013 10:29:10 +0100 (CET)
In-Reply-To: <527C43D0.2030301@marvell.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Qiao Zhou <zhouqiao@marvell.com>, Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Eric Miao <eric.y.miao@gmail.com>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, "trinity.qiao.zhou@gmail.com" <trinity.qiao.zhou@gmail.com>, Chao Xie <cxie4@marvell.com>
List-Id: alsa-devel@alsa-project.org

On 11/08/2013 02:52 AM, Qiao Zhou wrote:
> On 11/06/2013 07:24 PM, Mark Brown wrote:
>> On Tue, Nov 05, 2013 at 04:30:08PM +0800, Qiao Zhou wrote:
>>> add TISSP mode support. with this mode enabled, ssp controller
>>> works in TI-ssp protocol automatically and doesn't need to
>>> configure sspsp register to set the timing for tx/rx.
>>
>> What is TISSP mode in an audio context?
> It's normal SSP mode, and it has a pulse of one bit clock width, which 
> is the frame start signal. previously it's mainly used for voice call 
> which is mono stream. current I2S or DSP_x format use PSP, which 
> configures the details of transmit/receive timing. we can also use PSP 
> to suit this SSP format. But since the SSP controller provides such HW 
> convenience, so we want to add it. I'm not sure it's proper, and want to 
> ask for suggestions.

This sounds like a special case you want to address, rather than
something that should be recognized by the core.

The question is what you want to achive here. What kind of peripheral do
you have connected to the other side of the PXA, and why does it need
this special needle peak on the frame clock rather than a 50% duty-cycle?

Also, I vaguely remember huge problems we had in setting up the SSP
controller of a PXA SoC. The SSP IP would do all sort of things instead
of what's described in the docs. Which silicon are you working on?


Thanks,
Daniel
