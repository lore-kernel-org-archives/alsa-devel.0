From: Martin Geier <martin.geier@streamunlimited.com>
Subject: Re: snd_pcm_set_params faild on set_buffer_time_near
 and set_period_time_near
Date: Thu, 23 Jul 2015 09:33:43 +0200
Message-ID: <55B098D7.9060207@streamunlimited.com>
References: <55AE0831.2010206@streamunlimited.com>
 <CAN8cciYbrxgP6TvC36kPzgaTrFJ00oxXfDu2zxPyGA9UW837SA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bsmtp.bon.at (bsmtp8.bon.at [213.33.87.20])
 by alsa0.perex.cz (Postfix) with ESMTP id C00942604D3
 for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2015 09:33:45 +0200 (CEST)
In-Reply-To: <CAN8cciYbrxgP6TvC36kPzgaTrFJ00oxXfDu2zxPyGA9UW837SA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I am using 'davinci' soc driver with board specific driver.

On 23.07.2015 09:19, Raymond Yau wrote:
>
>
> >
> > I tried to configure alsa device with snd_pcm_set_params function, 
> requested
> > parameters was:
> > channel 2, rate: 22050, soft_resample: 1, latency: 50000
>
> The function snd_pcm_set_params does not always succed especially you 
> are using 22050Hz which is 20ms increment
>
> Which soc driver ? It is quite difficult to find the soutce by chip name
>
> https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/tree/sound/soc
>

-- 
*StreamUnlimited*
High Tech Campus Vienna, Gutheil-Schoder-Gasse 10, A-1102 Vienna, Austria
Levocska 9, 851 01 Bratislava, Slovakia
Email: martin.geier@streamunlimited.com
www.streamunlimited.com
