From: John Hsu <KCHSU0@nuvoton.com>
Subject: Re: [PATCH 1/2 v2] ASoC: nau8825: non-clock jack
 detection for power saving at standby
Date: Mon, 16 May 2016 09:47:49 +0800
Message-ID: <573926C5.70704@nuvoton.com>
References: <1463131037-19220-1-git-send-email-KCHSU0@nuvoton.com>
 <20160513104841.GA22038@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id EB16726523B
 for <alsa-devel@alsa-project.org>; Mon, 16 May 2016 03:47:53 +0200 (CEST)
In-Reply-To: <20160513104841.GA22038@sirena.org.uk>
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

On 5/13/2016 6:48 PM, Mark Brown wrote:
> On Fri, May 13, 2016 at 05:17:17PM +0800, John Hsu wrote:
>   
>> The driver changes jack type detection interruption to non-clock archi-
>> tecture for less 1mW power saving. The architecture is called manual mode
>>     
>
> I'm missing patch 2/2 here?
>   

There is another patch is made by this patch.
[PATCH 2/2] ASoC: nau8825: cross talk suppression measurement function
Besides, please help to review the following patch for the DC offset
issue. Thank you very much.
[PATCH] ASoC: nau8825: apply BIQ to reduce recording signal DC offset
