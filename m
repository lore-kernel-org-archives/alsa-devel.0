From: youling 257 <youling257@gmail.com>
Subject: Re: [PATCH v2] conf: Move UCM profile snippets into
	components subdirectory
Date: Wed, 28 Nov 2018 20:19:38 +0800
Message-ID: <CAOzgRdbWcBCo5UfaQwAtG59Jcw2swv6iNLu6FXwFq=+GbThikw@mail.gmail.com>
References: <20181128095654.22915-1-tiwai@suse.de>
 <CAOzgRdbg_zwpGqAVmi0rgGdLrhz_AyOhUFtvoscN0gXAS2utoQ@mail.gmail.com>
 <s5hbm695vh1.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io1-f67.google.com (mail-io1-f67.google.com
 [209.85.166.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 4FF9C2679A7
 for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2018 13:19:40 +0100 (CET)
Received: by mail-io1-f67.google.com with SMTP id u19so19797186ioc.2
 for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2018 04:19:40 -0800 (PST)
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
Yes.

> If so, I'll refresh the patch to address it.
>
>
> thanks,
>
> Takashi
Agree.
