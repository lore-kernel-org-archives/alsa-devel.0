From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: snd_array_free - snd: bad kfree when HDA reconfig
Date: Wed, 14 Sep 2011 08:04:46 +0800
Message-ID: <CAN8cciaVf7eoenrPmR2d4gxqyqs4TAk1OVt3wgzLi_qo09hQuw@mail.gmail.com>
References: <CAN8cciZcDYzWdLZxGZQH40Q2Vi2+7D3oNpk48Jw=X7n-Q5Tvwg@mail.gmail.com>
	<s5hlitu8api.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id BFAE92439A
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Sep 2011 02:04:47 +0200 (CEST)
Received: by fxe22 with SMTP id 22so1116291fxe.38
	for <alsa-devel@alsa-project.org>; Tue, 13 Sep 2011 17:04:46 -0700 (PDT)
In-Reply-To: <s5hlitu8api.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/9/12 Takashi Iwai <tiwai@suse.de>:
> At Fri, 2 Sep 2011 15:16:28 +0800,
> Raymond Yau wrote:
>>
>> These errors "snd: bad kfree" occur when reconfig HDA from model
>> "6stack-dig-fp" to "auto" and vice versa
>
> Doesn't this happen when you unload the device, right?

These errors "snd: bad kfree" also happen when unload and reload the driver

rmmod snd-hda-intel
insmod snd-hda-inteel


> And, it happens when writing to /sys/class/sound/hwC0D0/clear?
>
>> Is "HD-Audio reconfiguration" still experimental ?
>
> Somehow yet, but mostly it worked for me :)
>

I just use hda reconfig to change the model="auto" to "6stack-dig-fp"
and vice versa

This mean that I need to implement "Independent HP" switch which allow
user to change the topology if this feature is still experimental

>
>> ALSA hda_hwdep.c:220: hda-codec: reconfiguring
>> snd: bad kfree (called from f8be4636)
>
> Hmm, this is a magic check in external alsa-driver builds.
> I guess it's just a bug there -- the override of krealloc() is
> missing.
>
> Does the patch below (to alsa-driver tree) fix the problem?
>

Do I need to specify any option and run configure script again ?

alsa-driver compiled without error but fail to loaded and complain
ksize undefined symbol
