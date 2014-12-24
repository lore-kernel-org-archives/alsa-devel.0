From: Xuebing Wang <xbing6@gmail.com>
Subject: Re: Can not rmmod snd_hda_codec_hdmi
Date: Wed, 24 Dec 2014 17:49:32 +0800
Message-ID: <1419414572.1861.3.camel@gmail.com>
References: <1419332872.4067.10.camel@xbing-ubuntu>
 <680798B3-0846-423E-80F5-11AA542B563A@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f46.google.com (mail-pa0-f46.google.com
 [209.85.220.46])
 by alsa0.perex.cz (Postfix) with ESMTP id AA1002612BD
 for <alsa-devel@alsa-project.org>; Wed, 24 Dec 2014 10:49:48 +0100 (CET)
Received: by mail-pa0-f46.google.com with SMTP id lf10so9714404pab.5
 for <alsa-devel@alsa-project.org>; Wed, 24 Dec 2014 01:49:47 -0800 (PST)
In-Reply-To: <680798B3-0846-423E-80F5-11AA542B563A@ladisch.de>
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
Cc: "; Libin Yang" <libin.yang@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "; Takashi Iwai" <tiwai@suse.de>, ";
 Mengdong Lin" <mengdong.lin@intel.com>, Anssi Hannula <anssi.hannula@iki.fi>, "; Fengguang Wu" <fengguang.wu@intel.com>
List-Id: alsa-devel@alsa-project.org

Clemens, thanks for your help.

I am using Fedora 21 (Ubuntu 14.04.1 has the same problem).

'rmmod snd-hda-intel' shows this module is in use too. 

'modinfo snd-hda-intel', nor file /lib/modules/.../modules.dep shows that any kernel modules depends
on snd-hda-intel or snd_hda_codec_hdmi.

Is it possible that a kernel thread is using these 2 modules?

Any ideas? Thanks.


On Tue, 2014-12-23 at 17:21 +0100, Clemens Ladisch wrote:
> Xuebing Wang wrote:
> >rmmod: ERROR: Module snd_hda_codec_hdmi is in use
> 
> rmmod snd-hda-intel first.
> 
> 
> Regards,
> Clemens
> 
