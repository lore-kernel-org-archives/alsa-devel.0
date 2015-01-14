From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: Regression with .set_bias_level in pcm512x?
Date: Wed, 14 Jan 2015 09:03:36 +0100
Message-ID: <54B622D8.90008@metafoo.de>
References: <0bea1026e90a46769a573470a3efc935@EMAIL.axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-243.synserver.de (smtp-out-243.synserver.de
 [212.40.185.243])
 by alsa0.perex.cz (Postfix) with ESMTP id AE3DC2606DA
 for <alsa-devel@alsa-project.org>; Wed, 14 Jan 2015 09:03:36 +0100 (CET)
In-Reply-To: <0bea1026e90a46769a573470a3efc935@EMAIL.axentia.se>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Rosin <peda@axentia.se>, "'alsa-devel@alsa-project.org'" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 01/13/2015 11:49 PM, Peter Rosin wrote:
> Hi!
>
> I'm working on adding support for DAIFMT_CBM_CFM and DAIFMT_CBM_CFS
> to pcm512x, and it works nicely in the 3.10 kernel + Atmel-patches were I have
> developed the code. Now I'm trying to forward-port it and test it on
> 3.18 + other-Atmel-patches in preparation for submission. However, there
> seems to be a regression in that the (pre-existing) pcm512x_set_bias_level
> callback is never called in the 3.18 version.
>
> I see that there has been some core work on set_bias_level, and suspect
> it has something to do with dapm and components, but I think someone else
> will find the problem much quicker than I am able to.
>
> I have feebly tried to revert 0bd2ac3dae74ee25c5ea171cb572731c7a89c248
> and 68f831c2724ab72c0088471b2ed1dc99e81948ef, but that didn't help. That
> also seems a bit backwards. So, what needs to be done in the pcm512x driver
> to have set_bias_level called?

It's unlikely that these commits have anything to do with it.

I think it is more likely that the DAPM state (for whatever reason) never 
actually changes. Check the state of the DAPM context and all the widgets in 
/sys/kernel/debug/asoc/your_card/... and compare their state when the system 
is idle to when it should not be idle.

- Lars
