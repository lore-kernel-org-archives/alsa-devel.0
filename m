From: youling 257 <youling257@gmail.com>
Subject: Re: [PATCH v2] conf: Move UCM profile snippets into
	components subdirectory
Date: Wed, 28 Nov 2018 19:09:17 +0800
Message-ID: <CAOzgRdb4VuAE_Tux2HkvoV_qiY_2o-H8ziBqSNRHi3k=6tCBzw@mail.gmail.com>
References: <20181128095654.22915-1-tiwai@suse.de>
 <CAOzgRdbg_zwpGqAVmi0rgGdLrhz_AyOhUFtvoscN0gXAS2utoQ@mail.gmail.com>
 <s5hbm695vh1.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io1-f68.google.com (mail-io1-f68.google.com
 [209.85.166.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 2640F2679A7
 for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2018 12:09:18 +0100 (CET)
Received: by mail-io1-f68.google.com with SMTP id s22so19620755ioc.8
 for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2018 03:09:18 -0800 (PST)
In-Reply-To: <s5hbm695vh1.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

src/conf/ucm/chtrt5645/HiFi.conf, a lot of cset command, why quote
PlatformEnableSeq.conf? although PlatformEnableSeq.conf is custom
command for bytcr/chtbsw platform.
if chtrt5645/HiFi.conf <searchdir:ucm> and
<platforms/bytcr/PlatformEnableSeq.conf>, do you think the code is not
neat?
so i said revert "conf/ucm: bytcr-rt5645: Use the generic
bytcr/PlatformEnableSeq.conf".
chtrt5645-mono-speaker-analog-mic/HiFi.conf not quote PlatformEnableSeq.conf.

2018-11-28 18:48 GMT+08:00, Takashi Iwai <tiwai@suse.de>:
> On Wed, 28 Nov 2018 11:40:56 +0100,
> youling 257 wrote:
>>
>> I'm still not see '<searchdir:ucm>' in the
>> src/conf/ucm/chtrt5645/HiFi.conf,
>> if needn't '<searchdir:ucm>', so can remove '<searchdir:ucm>' in other
>> files?
>> bytcr-rt5640/HiFi.conf, bytcr-rt5651/HiFi.conf, chtnau8824/HiFi.conf,
>> ......, remove <searchdir:ucm>?
>>
>> my understand, no '<searchdir:ucm>',
>> '<platforms/bytcr/PlatformEnableSeq.conf>' won't work.
>
> OK, point taken.  Yes, it's a missing piece.
>
> So, just adding <searchdir:ucm> makes things working on your machine,
> right?
>
> If so, I'll refresh the patch to address it.
>
>
> thanks,
>
> Takashi
>
>>
>> 	EnableSequence [
>> 		cdev "hw:chtrt5645"
>>
>> 		<platforms/bytcr/PlatformEnableSeq.conf>
>>
>> 		# Output Configuration
>> 		cset "name='DAC1 L Mux' IF1 DAC"
>> 		cset "name='DAC1 R Mux' IF1 DAC"
>>
