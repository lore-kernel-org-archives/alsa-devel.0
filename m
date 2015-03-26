From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH v2 1/2] ALSA: jack: create jack kcontrols
 for every jack input device
Date: Thu, 26 Mar 2015 10:34:33 +0800
Message-ID: <CAN8ccibfeMrGXzp7-0CV7OMO-m7d-q9i5PxvSm7Zos-vOK9ADg@mail.gmail.com>
References: <1426841719-14576-1-git-send-email-yang.jie@intel.com>
 <1426841719-14576-3-git-send-email-yang.jie@intel.com>
 <s5hd2446mt2.wl-tiwai@suse.de>
 <E7B1D079BA13FB44A978CC8F69C7D6A901BDB90F@SHSMSX101.ccr.corp.intel.com>
 <s5hvbhv6eio.wl-tiwai@suse.de>
 <E7B1D079BA13FB44A978CC8F69C7D6A901BDB93C@SHSMSX101.ccr.corp.intel.com>
 <s5hr3sj6bzj.wl-tiwai@suse.de>
 <E7B1D079BA13FB44A978CC8F69C7D6A901BDB993@SHSMSX101.ccr.corp.intel.com>
 <s5hegoj69bs.wl-tiwai@suse.de>
 <1427108203.2968.57.camel@tkkaskin-mobl3.ger.corp.intel.com>
 <550FFE2B.7050008@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f54.google.com (mail-oi0-f54.google.com
 [209.85.218.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 4842226057B
 for <alsa-devel@alsa-project.org>; Thu, 26 Mar 2015 03:34:34 +0100 (CET)
Received: by oiag65 with SMTP id g65so38264461oia.2
 for <alsa-devel@alsa-project.org>; Wed, 25 Mar 2015 19:34:33 -0700 (PDT)
In-Reply-To: <550FFE2B.7050008@canonical.com>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Tanu Kaskinen <tanu.kaskinen@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, "broonie@kernel.org" <broonie@kernel.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

>>
>> One thing that is unclear for me is that how are those jacks represented
>> that support any of headsets/headphones/microphones, but don't provide
>> information about which device type has been plugged in.
>
>
> For headphone or headset, independent switches:
>
>  * "Headphone Jack"
>  * "Headset Mic Jack"
>
> For headphone or headset, one hw switch only:
>
>  * "Headphone Jack"
>  * "Headset Mic Phantom Jack"

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/log/sound/pci/hda?qt=grep&q=dell-headset-multi

I don't understand how can Dell OptiPlex  3030 All-in-One and XPS 15
laoptop can use the same pin config "dell-headset-multi" ?

There is line out jack in aio spec : Universal Headset (Side)1
Line-out(Rear)

While xps 15 notebook has internal speaker and headset
