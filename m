From: Michal Bachraty <michal.bachraty@streamunlimited.com>
Subject: davici-mcasp: "tx-num-evt" confusion with number of
	serializers
Date: Tue, 26 Feb 2013 15:06:54 +0100
Message-ID: <1631475.f7GPhLiLxV@ganymedes>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.inode.at (mx01.lb01.inode.at [62.99.145.1])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A6D8265302
 for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2013 15:06:56 +0100 (CET)
Received: from [81.89.61.168] (port=12571 helo=ganymedes.localnet)
 by smartmx-01.inode.at with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.69) (envelope-from <michal.bachraty@streamunlimited.com>)
 id 1UALBI-0005hG-2x
 for alsa-devel@alsa-project.org; Tue, 26 Feb 2013 15:06:56 +0100
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

Hi,
I'm  working on multichannel version of davinci-mcasp and also davinci-pcm. I 
have first version running and now I want to refine code. I found one confusion 
in davinci-mcasp with using of DT property "tx-num-evt".  In DT binding 
documentation "tx-num-evt" is defined as "FIFO levels", but in Mcasp src, there 
is code, which mixes tx-num-evt with number of serializers (i2s data lines) 
that are enabled for data playback and receive (dev->txnumevt * tx_ser)

mcasp_mod_bits(dev->base + MCASP_VER3_WFIFOCTL,
                (((dev->txnumevt * tx_ser) << 8), NUMEVT_MASK); 

>From dacinci pcm,  DMA data tranfer use txnumevt as number of serializers and 
also for data prefetching. 
I undestand definition "FIFO levels" as how many prefetched data are in FIFO. 
Prefetched data are for me frame data / 2  ( all left or right channels for 
one sampling time). This results me from AM335x FIFO documantation.
What is original purpose for "tx-num-evt" parameter?

Thanks,
Michal
