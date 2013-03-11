From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: Re: davici-mcasp: "tx-num-evt" confusion with number
 of serializers
Date: Mon, 11 Mar 2013 07:09:11 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ED402D0@DBDE01.ent.ti.com>
References: <1631475.f7GPhLiLxV@ganymedes>
 <20130301100820.GU25302@opensource.wolfsonmicro.com>
 <B5906170F1614E41A8A28DE3B8D121433ED3D3B4@DBDE01.ent.ti.com>
 <37886470.pk5FC04C8c@ganymedes>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id A020B2650E5
 for <alsa-devel@alsa-project.org>; Mon, 11 Mar 2013 08:09:16 +0100 (CET)
In-Reply-To: <37886470.pk5FC04C8c@ganymedes>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Michal Bachraty <michal.bachraty@streamunlimited.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mike Looijmans <mike.looijmans@topic.nl>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Hebbar,
 Gururaja" <gururaja.hebbar@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 08, 2013 at 21:41:05, Michal Bachraty wrote:
> 
> No, 
> In davinci-mcasp code, there is fifo_level assigned with txnumevt
> 
> 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> 		fifo_level = dev->txnumevt;
> 	else
> 		fifo_level = dev->rxnumevt;
> 
> That code can  be changed to computing fifo_level to dev->txnumevt * 
> active_serializers and then it is needed to remove  active_serializers from 
> davinci-pcm. Code fuctionality will be same as is now with applied patch 
> [PATCH v3] davinci-mcasp: Add support for multichannel playback
> Also there is need to change dst_cidx from 4  to 0, othewise when no fifo is 
> used, it won't work properly. 
> 

Ok. Can you submit the next version addressing these issues?

Regards,
Vaibhav
