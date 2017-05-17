From: Bhumika Goyal <bhumirks@gmail.com>
Subject: Re: [PATCH] ALSA: sound/isa: constify snd_kcontrol_new
	structures
Date: Wed, 17 May 2017 18:03:45 +0530
Message-ID: <CAOH+1jGYQpTsfaMSUF+iGuj6uERkb_PK_nJO_KZu42e05E5r5g@mail.gmail.com>
References: <1495021136-6999-1-git-send-email-bhumirks@gmail.com>
 <s5h4lwjd68p.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f46.google.com (mail-it0-f46.google.com
 [209.85.214.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 29DBD266EAD
 for <alsa-devel@alsa-project.org>; Wed, 17 May 2017 14:33:46 +0200 (CEST)
Received: by mail-it0-f46.google.com with SMTP id g126so7925448ith.0
 for <alsa-devel@alsa-project.org>; Wed, 17 May 2017 05:33:46 -0700 (PDT)
In-Reply-To: <s5h4lwjd68p.wl-tiwai@suse.de>
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
Cc: Julia Lawall <julia.lawall@lip6.fr>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, May 17, 2017 at 5:50 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Wed, 17 May 2017 13:38:56 +0200,
> Bhumika Goyal wrote:
>>
>> Declare snd_kcontrol_new structures as const as they are only passed an
>> argument to the function snd_ctl_new1. This argument is of type const,
>> so snd_kcontrol_new structures having this property can be made const.
>> Done using Coccinelle:
>>
>> @r disable optional_qualifier@
>> identifier x;
>> position p;
>> @@
>> static struct snd_kcontrol_new x@p={...};
>>
>> @ok@
>> identifier r.x;
>> position p;
>> @@
>> snd_ctl_new1(&x@p,...)
>>
>> @bad@
>> position p != {r.p,ok.p};
>> identifier r.x;
>> @@
>> x@p
>>
>> @depends on !bad disable optional_qualifier@
>> identifier r.x;
>> @@
>> +const
>> struct snd_kcontrol_new x;
>>
>> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
>
> As I already asked, could you send as a patchset if you have multiple
> similar patches?
>

Sure. Will combine the already sent ones and some new ones into a
patchset and send again.

Thanks,
Bhumika

>
> thanks,
>
> Takashi
