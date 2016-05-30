From: John Hsu <KCHSU0@nuvoton.com>
Subject: Re: [PATCH 1/2 v2] ASoC: nau8825: non-clock jack
 detection for power saving at standby
Date: Mon, 30 May 2016 10:00:51 +0800
Message-ID: <574B9ED3.5070005@nuvoton.com>
References: <1463131037-19220-1-git-send-email-KCHSU0@nuvoton.com>
 <20160513104841.GA22038@sirena.org.uk> <573926C5.70704@nuvoton.com>
 <20160518170549.GR8104@sirena.org.uk> <573E80A7.50602@nuvoton.com>
 <20160520110137.GJ8206@sirena.org.uk> <5742641A.9070409@nuvoton.com>
 <20160523170432.GA8206@sirena.org.uk> <5743CD4E.6020805@nuvoton.com>
 <20160524110309.GI8206@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E5252605F1
 for <alsa-devel@alsa-project.org>; Mon, 30 May 2016 04:00:55 +0200 (CEST)
In-Reply-To: <20160524110309.GI8206@sirena.org.uk>
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

On 5/24/2016 7:03 PM, Mark Brown wrote:
> On Tue, May 24, 2016 at 11:41:02AM +0800, John Hsu wrote:
>   
>> On 5/24/2016 1:04 AM, Mark Brown wrote:
>>     
>
>   
>>> The trouble is you'd have to do the configuration in userspace or do
>>> something like only do the DC offset correction if no other filter is
>>> configured.  TBH it's not unreasonable to suggest people should just
>>> configured a high pass filter if they're having issues, though it's a
>>> bit more work :(
>>>       
>
>   
>> Is it acceptable if we change our patch to do the DC offset correction
>> instead of general BIQ filter for the issue?
>>     
>
> That's probably going in the opposite direction to what I'd expect...
> I've not properly read the patch yet and there's quite a backlog from
> the merge window...
>   

I see. The configuration is an array of filter coefficients. Maybe
we'll make it with bytes type kcontrol for userspace. Is it suitable
for the case?
