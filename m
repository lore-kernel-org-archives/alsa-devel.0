From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 1/4] ALSA: control: return payload length
 for TLV operation
Date: Tue, 30 Aug 2016 21:22:53 +0900
Message-ID: <57C57A9D.1080805@sakamocchi.jp>
References: <1472514285-3769-1-git-send-email-o-takashi@sakamocchi.jp>
 <1472514285-3769-2-git-send-email-o-takashi@sakamocchi.jp>
 <8bb43ca3-eaf1-9f03-1f73-540f96941ae1@ladisch.de>
 <9f0188ab-31c9-d42d-ba2c-8718d5b97c49@sakamocchi.jp>
 <d41ab924-ca4a-39ac-651e-73a4662c3f1d@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 25CAE266B4F
 for <alsa-devel@alsa-project.org>; Tue, 30 Aug 2016 14:22:57 +0200 (CEST)
In-Reply-To: <d41ab924-ca4a-39ac-651e-73a4662c3f1d@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: tiwai@suse.de, vinod.koul@intel.com, alsa-devel@alsa-project.org, broonie@linaro.org, omair.m.abdullah@intel.com
List-Id: alsa-devel@alsa-project.org

On Aug 30 2016 17:04, Clemens Ladisch wrote:
> Takashi Sakamoto wrote:
>> On Aug 30 2016 16:05, Clemens Ladisch wrote:
>>> If there were any TLV callback that did not set _tlv[1] to the actual
>>> size, it would be buggy, and just needed to be fixed to do so.
>>
>> TLV feature of ALSA control interface is not only used to transfer
>> threshold level information, but also arbitrary data for I/O by
>> developers in ALSA SoC part. The '_tlv[1]' protocol is not necessarily
>> kept by them.
> 
> Which specific ASoC driver does this?

As of 4.8, soc-wm-adsp does it, with a help of soc-core.


Regards

Takashi Sakamoto
