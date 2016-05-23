From: John Hsu <KCHSU0@nuvoton.com>
Subject: Re: [PATCH 1/2 v2] ASoC: nau8825: non-clock jack
 detection for power saving at standby
Date: Mon, 23 May 2016 09:59:54 +0800
Message-ID: <5742641A.9070409@nuvoton.com>
References: <1463131037-19220-1-git-send-email-KCHSU0@nuvoton.com>
 <20160513104841.GA22038@sirena.org.uk> <573926C5.70704@nuvoton.com>
 <20160518170549.GR8104@sirena.org.uk> <573E80A7.50602@nuvoton.com>
 <20160520110137.GJ8206@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0637C2604A9
 for <alsa-devel@alsa-project.org>; Mon, 23 May 2016 03:59:58 +0200 (CEST)
In-Reply-To: <20160520110137.GJ8206@sirena.org.uk>
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

Hi,

On 5/20/2016 7:01 PM, Mark Brown wrote:
> On Fri, May 20, 2016 at 11:12:39AM +0800, John Hsu wrote:
>   
>> On 5/19/2016 1:05 AM, Mark Brown wrote:
>>     
>
>   
>>>> [PATCH] ASoC: nau8825: apply BIQ to reduce recording signal DC offset
>>>>         
>
>   
>>> This is hard to review since it's quite complex and doing things that
>>> look like they might be using general purpose parts of the chip for
>>> specialist purposes.
>>>       
>
>   
>> We find there is a DC offset issue when recording. For the issue, it
>> needs a HPF in ADC to reduce the offset, but no such hardware circuit.
>> Thus, the driver configures the biquard filter as HPF when headset
>> connected. It is a must setup for the codec. This patch sets the
>> coefficients A1, A2, B0, B1, and B3 in the biquad filter to make the
>> HPF funciton.
>>     
>
> I understand what it's doing but obviously a biquad filter isn't
> specialized for this function...
>   

Yes, the biquad filter is general purpose feature. Could you give us
suggestion about how to implement the biquad filter for common fea-
ture and to fix DC offset as well?
