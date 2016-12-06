From: John Hsu <KCHSU0@nuvoton.com>
Subject: Re: [PATCH] ASoC: nau8825: disable sinc filter for
	high THD of ADC
Date: Tue, 6 Dec 2016 10:07:40 +0800
Message-ID: <58461D6C.2040506@nuvoton.com>
References: <1480643338-9423-1-git-send-email-KCHSU0@nuvoton.com>
 <20161205115009.ri5qpgzlfszumvo7@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F00D266686
 for <alsa-devel@alsa-project.org>; Tue,  6 Dec 2016 03:07:45 +0100 (CET)
In-Reply-To: <20161205115009.ri5qpgzlfszumvo7@sirena.org.uk>
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
Cc: AP MS30 Linux ALSA <alsa-devel@alsa-project.org>, "anatol.pomozov@gmail.com" <anatol.pomozov@gmail.com>, AC30 YHChuang <YHCHuang@nuvoton.com>, AC30 WTLi <WTLI@nuvoton.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "benzh@chromium.org" <benzh@chromium.org>, AC30 CTLin0 <CTLIN0@nuvoton.com>, MS40 MHKuo <MHKuo@nuvoton.com>, "yong.zhi@intel.com" <yong.zhi@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi,
On 12/5/2016 7:50 PM, Mark Brown wrote:
> On Fri, Dec 02, 2016 at 09:48:58AM +0800, John Hsu wrote:
>
>   
>> This bit will enable 4th order SINC filter.  
>> =1, filter will enable;  but it consumes higher power.
>> =0, the sinc filter is disable, and it should always keep 0 value to
>> get high THD.
>>     
>
>   
>> Therefor, disable the filter when codec initiation for better
>> performance when recording.
>>     
>
> This looks like something that users should be able to control at
> runtime - while some users are going to prefer lower power there will
> most likely also be some users who prefer the better performance (or
> perhaps even users who switch depending on if they're running on battery
> or something).
>   

The function is not suitable for the voice application and easy to
make distortion. Therefore, we want to disalbe it as default to
get a high signal to distortion ratio. Yes, I agree it that users
maybe want to eanble it sometimes. I can add a kcontrol for the
function as well.
