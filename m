From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: Can not rmmod snd_hda_codec_hdmi
Date: Wed, 24 Dec 2014 11:57:12 +0200
Message-ID: <549A8DF8.1010004@iki.fi>
References: <1419332872.4067.10.camel@xbing-ubuntu>	
 <680798B3-0846-423E-80F5-11AA542B563A@ladisch.de>
 <1419414572.1861.3.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3.ippnet.fi (mail3.ippnet.fi [62.197.168.3])
 by alsa0.perex.cz (Postfix) with ESMTP id AD1B22614D0
 for <alsa-devel@alsa-project.org>; Wed, 24 Dec 2014 10:57:14 +0100 (CET)
In-Reply-To: <1419414572.1861.3.camel@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xuebing Wang <xbing6@gmail.com>
Cc: "; Libin Yang" <libin.yang@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "; Takashi Iwai" <tiwai@suse.de>, ";
 Mengdong Lin" <mengdong.lin@intel.com>, Clemens Ladisch <clemens@ladisch.de>, "; Fengguang Wu" <fengguang.wu@intel.com>
List-Id: alsa-devel@alsa-project.org

24.12.2014, 11:49, Xuebing Wang kirjoitti:
> On Tue, 2014-12-23 at 17:21 +0100, Clemens Ladisch wrote:
>> Xuebing Wang wrote:
>>> rmmod: ERROR: Module snd_hda_codec_hdmi is in use
>>
>> rmmod snd-hda-intel first.
>>
> Clemens, thanks for your help.
> 
> I am using Fedora 21 (Ubuntu 14.04.1 has the same problem).
> 
> 'rmmod snd-hda-intel' shows this module is in use too. 
> 
> 'modinfo snd-hda-intel', nor file /lib/modules/.../modules.dep shows that any kernel modules depends
> on snd-hda-intel or snd_hda_codec_hdmi.
> 
> Is it possible that a kernel thread is using these 2 modules?
> 
> Any ideas? Thanks.

Run this to see if some userspace process is using the ALSA devices:
fuser -v /dev/snd/*

-- 
Anssi Hannula
