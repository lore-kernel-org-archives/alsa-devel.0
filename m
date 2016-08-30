From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 1/4] ALSA: control: return payload length
	for	TLV operation
Date: Tue, 30 Aug 2016 10:04:26 +0200
Message-ID: <d41ab924-ca4a-39ac-651e-73a4662c3f1d@ladisch.de>
References: <1472514285-3769-1-git-send-email-o-takashi@sakamocchi.jp>
 <1472514285-3769-2-git-send-email-o-takashi@sakamocchi.jp>
 <8bb43ca3-eaf1-9f03-1f73-540f96941ae1@ladisch.de>
 <9f0188ab-31c9-d42d-ba2c-8718d5b97c49@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id CD42026670B
 for <alsa-devel@alsa-project.org>; Tue, 30 Aug 2016 10:04:27 +0200 (CEST)
In-Reply-To: <9f0188ab-31c9-d42d-ba2c-8718d5b97c49@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: tiwai@suse.de, vinod.koul@intel.com, alsa-devel@alsa-project.org, broonie@linaro.org, omair.m.abdullah@intel.com
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> On Aug 30 2016 16:05, Clemens Ladisch wrote:
>> If there were any TLV callback that did not set _tlv[1] to the actual
>> size, it would be buggy, and just needed to be fixed to do so.
>
> TLV feature of ALSA control interface is not only used to transfer
> threshold level information, but also arbitrary data for I/O by
> developers in ALSA SoC part. The '_tlv[1]' protocol is not necessarily
> kept by them.

Which specific ASoC driver does this?


Regards,
Clemens
