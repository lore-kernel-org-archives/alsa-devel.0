From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: davici-mcasp: "tx-num-evt" confusion with number
 of serializers
Date: Tue, 26 Feb 2013 19:40:37 +0100
Message-ID: <512D01A5.8050206@topic.nl>
References: <1631475.f7GPhLiLxV@ganymedes>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atl4mhob13.myregisteredsite.com
 (atl4mhob13.myregisteredsite.com [209.17.115.51])
 by alsa0.perex.cz (Postfix) with ESMTP id DF054265329
 for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2013 19:40:39 +0100 (CET)
Received: from mailpod.hostingplatform.com (mail.networksolutionsemail.com
 [205.178.146.50])
 by atl4mhob13.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id
 r1QIecEh030785
 for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2013 13:40:38 -0500
In-Reply-To: <1631475.f7GPhLiLxV@ganymedes>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 02/26/2013 03:06 PM, Michal Bachraty wrote:
> Hi,
> I'm  working on multichannel version of davinci-mcasp and also davinci-pcm. I
> have first version running and now I want to refine code. I found one confusion
> in davinci-mcasp with using of DT property "tx-num-evt".  In DT binding
> documentation "tx-num-evt" is defined as "FIFO levels", but in Mcasp src, there
> is code, which mixes tx-num-evt with number of serializers (i2s data lines)
> that are enabled for data playback and receive (dev->txnumevt * tx_ser)
>
> mcasp_mod_bits(dev->base + MCASP_VER3_WFIFOCTL,
>                  (((dev->txnumevt * tx_ser) << 8), NUMEVT_MASK);
>
>  From dacinci pcm,  DMA data tranfer use txnumevt as number of serializers and
> also for data prefetching.
> I undestand definition "FIFO levels" as how many prefetched data are in FIFO.
> Prefetched data are for me frame data / 2  ( all left or right channels for
> one sampling time). This results me from AM335x FIFO documantation.
> What is original purpose for "tx-num-evt" parameter?

 From what I remember (I'm using the davinci to record from up to 8 
codecs chips simultaneously) the value sets a threshold for the DMA 
request (if the FIFO is enabled - and I can't think of a reason why 
anyone would NOT want to enable the fifo...).

Postponing the DMA request until there are #channels data entries in the 
fifo buffer makes sense to me. Setting the txnumevt to a higher value 
might reduce the load on the memory controller (that's what TI claims), 
at the cost of a higher risk of overrunning the fifo, and increased 
latency. Setting it to less than the number of channels isn't useful 
either - which application would be interested in "half" the channel data?

I have always considered the parameter to be a boolean (please use the 
fifo) rather than an integer setting.

-- 
Mike Looijmans - Topic Automation
