From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH v2 1/2] ALSA: jack: create jack kcontrols
 for every jack input device
Date: Wed, 25 Mar 2015 10:14:32 +0800
Message-ID: <CAN8cciYKmOZOzp9OXTgsDA_ti_w7_ceGkYgkjQZzTZvpFgfu3w@mail.gmail.com>
References: <1426841719-14576-3-git-send-email-yang.jie@intel.com>
 <s5hd2446mt2.wl-tiwai@suse.de>
 <E7B1D079BA13FB44A978CC8F69C7D6A901BDB90F@SHSMSX101.ccr.corp.intel.com>
 <s5hvbhv6eio.wl-tiwai@suse.de>
 <E7B1D079BA13FB44A978CC8F69C7D6A901BDB93C@SHSMSX101.ccr.corp.intel.com>
 <s5hr3sj6bzj.wl-tiwai@suse.de>
 <E7B1D079BA13FB44A978CC8F69C7D6A901BDB993@SHSMSX101.ccr.corp.intel.com>
 <s5hegoj69bs.wl-tiwai@suse.de>
 <1427108203.2968.57.camel@tkkaskin-mobl3.ger.corp.intel.com>
 <550FFE2B.7050008@canonical.com>
 <20150323164129.GE14954@sirena.org.uk>
 <5511093F.1010708@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f181.google.com (mail-ob0-f181.google.com
 [209.85.214.181])
 by alsa0.perex.cz (Postfix) with ESMTP id DC54D260688
 for <alsa-devel@alsa-project.org>; Wed, 25 Mar 2015 03:14:33 +0100 (CET)
Received: by obcjt1 with SMTP id jt1so8995413obc.2
 for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2015 19:14:33 -0700 (PDT)
In-Reply-To: <5511093F.1010708@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Tanu Kaskinen <tanu.kaskinen@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

>>
>>
>>>> One thing that is unclear for me is that how are those jacks
represented
>>>> that support any of headsets/headphones/microphones, but don't provide
>>>> information about which device type has been plugged in.
>>
>>
>>> For headphone or headset, independent switches:
>>
>>
>>>   * "Headphone Jack"
>>>   * "Headset Mic Jack"
>>
>>
>>> For headphone or headset, one hw switch only:
>>
>>
>>>   * "Headphone Jack"
>>>   * "Headset Mic Phantom Jack"
>>
>>
>> I'd have expected these to be the same thing, just with the second case
>> always having the same state for both switches.
>
>
> We need to distinguish the use cases: in case of independent switches, we
can make the assumption that if the user plugged in a headset, the user
wants to use the headset mic instead of the internal mic, so we switch to
it.
>

What will happen for those Dell Alienware 14, 15 and 17 which have three
jacks: headset, headphone and mic

http://www.dell.com/support/home/us/en/19/product-support/product/alienware-17/manuals

Alienware 17 Quick Start Guide
