From: John Hsu <KCHSU0@nuvoton.com>
Subject: Re: [PATCH 1/2 v2] ASoC: nau8825: non-clock jack
 detection for power saving at standby
Date: Fri, 20 May 2016 11:12:39 +0800
Message-ID: <573E80A7.50602@nuvoton.com>
References: <1463131037-19220-1-git-send-email-KCHSU0@nuvoton.com>
 <20160513104841.GA22038@sirena.org.uk> <573926C5.70704@nuvoton.com>
 <20160518170549.GR8104@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C93B6260647
 for <alsa-devel@alsa-project.org>; Fri, 20 May 2016 05:12:43 +0200 (CEST)
In-Reply-To: <20160518170549.GR8104@sirena.org.uk>
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
Cc: AP MS30 Linux ALSA <alsa-devel@alsa-project.org>, "anatol.pomozov@gmail.com" <anatol.pomozov@gmail.com>, AC30 YHChuang <YHCHuang@nuvoton.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "benzh@chromium.org" <benzh@chromium.org>, AC30 CTLin0 <CTLIN0@nuvoton.com>, MS40 MHKuo <MHKuo@nuvoton.com>, "yong.zhi@intel.com" <yong.zhi@intel.com>
List-Id: alsa-devel@alsa-project.org

On 5/19/2016 1:05 AM, Mark Brown wrote:
> On Mon, May 16, 2016 at 09:47:49AM +0800, John Hsu wrote:
>
>   
>> There is another patch is made by this patch.
>> [PATCH 2/2] ASoC: nau8825: cross talk suppression measurement function
>>     
>
> I'm confused about what's going on here...  if you're sending multiple
> patches that need to be grouped together you should always send them all
> together.  If you're not sending a group of patches then you shouldn't
> use numbering in the subject line.
>
>   

I understand. Thank you very much.

>> Besides, please help to review the following patch for the DC offset
>> issue. Thank you very much.
>> [PATCH] ASoC: nau8825: apply BIQ to reduce recording signal DC offset
>>     
>
> This is hard to review since it's quite complex and doing things that
> look like they might be using general purpose parts of the chip for
> specialist purposes.
>   

We find there is a DC offset issue when recording. For the issue, it
needs a HPF in ADC to reduce the offset, but no such hardware circuit.
Thus, the driver configures the biquard filter as HPF when headset
connected. It is a must setup for the codec. This patch sets the
coefficients A1, A2, B0, B1, and B3 in the biquad filter to make the
HPF funciton.
