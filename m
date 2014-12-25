From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ALSA: pcm_dmaengine: correct the error
	handler of dmaengine_prep_dma_cyclic
Date: Thu, 25 Dec 2014 10:02:33 +0100
Message-ID: <549BD2A9.505@metafoo.de>
References: <1419482475-4911-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-068.synserver.de (smtp-out-068.synserver.de
 [212.40.185.68])
 by alsa0.perex.cz (Postfix) with ESMTP id B4100264F1D
 for <alsa-devel@alsa-project.org>; Thu, 25 Dec 2014 10:02:34 +0100 (CET)
In-Reply-To: <1419482475-4911-1-git-send-email-21cnbao@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>, peter.ujfalusi@ti.com, tiwai@suse.de, broonie@linaro.org
Cc: alsa-devel@alsa-project.org, workgroup.linux@csr.com, Barry Song <Baohua.Song@csr.com>
List-Id: alsa-devel@alsa-project.org

On 12/25/2014 05:41 AM, Barry Song wrote:
> From: Barry Song <Baohua.Song@csr.com>
>
> preparing cyclic DMA description can fail either due to DMA desc list
> is full(-ENOMEM), or due to the coming DMA configuration is illegal or
> not supported by the acting DMA hardware(other ERR codes).

According to the API definition this returns either NULL or a valid 
descriptor, so the behavior in pcm_dmaengine is correct. Maybe your 
particular dmaengine driver as a incorrect implementation.

- Lars
