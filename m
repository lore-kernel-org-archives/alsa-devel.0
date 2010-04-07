From: Maurus Cuelenaere <mcuelenaere@gmail.com>
Subject: Re: [PATCH] ALSA: hda: Add support for Medion WIM2160
Date: Wed, 07 Apr 2010 15:53:14 +0200
Message-ID: <4BBC8E4A.3080206@gmail.com>
References: <j2mb2e8f9f71004060912n88d89a79ke46f427aee6c22cb@mail.gmail.com>	<s5h1ves4iol.wl%tiwai@suse.de>	<k2kb2e8f9f71004061008tc94b8ff7w2295d146211d1d2d@mail.gmail.com>	<s5hy6gzdcbd.wl%tiwai@suse.de>	<4BBC710C.3090802@gmail.com>	<s5hk4sj3252.wl%tiwai@suse.de>	<4BBC73A9.4040008@gmail.com>	<s5hhbnn31ym.wl%tiwai@suse.de>	<4BBC7C18.2090902@gmail.com>
	<s5h8w8z2zeh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.149])
	by alsa0.perex.cz (Postfix) with ESMTP id 18C5310393D
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Apr 2010 15:53:18 +0200 (CEST)
Received: by ey-out-1920.google.com with SMTP id 4so147204eyg.16
	for <alsa-devel@alsa-project.org>; Wed, 07 Apr 2010 06:53:17 -0700 (PDT)
In-Reply-To: <s5h8w8z2zeh.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Op 07-04-10 14:57, Takashi Iwai schreef:
> At Wed, 07 Apr 2010 14:35:36 +0200,
> Maurus Cuelenaere wrote:
>    
>> Audio works, headphone output does not and so does automatic
>> speaker-headphone switching (haven't tested line in).
>>
>> Attached is the output of alsa-info.sh
>>
>> Tested version was commit 489008cd58740fe3842822681d33bf87c07c3412 on
>> branch sound-2.6/topic/hda.
>>      
> OK, thanks for checking.  The problem is that BIOS doesn't set up the
> pins correctly, especially the headphone pin.  So, the quirk is
> mandatory, more or less.
>
> I applied your patch to fix/hda branch now.
>    

Ok, thanks.

-- 
Maurus Cuelenaere
