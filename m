From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] emu10k1: Fix coccicheck warning
Date: Sun, 10 Mar 2013 20:49:12 +0100
Message-ID: <513CE3B8.9020308@ladisch.de>
References: <1362919067-17250-1-git-send-email-cvicentiu@gmail.com>	<513CB587.5010304@ladisch.de>
 <CACzaYTOE=tVst3=TvUCtxpMuUOtJiHQ3o2wbgWeMvxwZy41DMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id DAC602651B0
 for <alsa-devel@alsa-project.org>; Sun, 10 Mar 2013 20:50:31 +0100 (CET)
In-Reply-To: <CACzaYTOE=tVst3=TvUCtxpMuUOtJiHQ3o2wbgWeMvxwZy41DMw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vicentiu Ciorbaru <cvicentiu@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, wfp5p@virginia.edu, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Vicentiu Ciorbaru wrote:
> On Sun, Mar 10, 2013 at 6:32 PM, Clemens Ladisch <clemens@ladisch.de> wrote:
>> Vicentiu Ciorbaru wrote:
>>> Removed redundant cast of kmalloc return pointer.
>>
>>> -         (icode->gpr_map = (u_int32_t __user *)
>>> -          kcalloc(512 + 256 + 256 + 2 * 1024, sizeof(u_int32_t),
>>> -                  GFP_KERNEL)) == NULL ||
>>> +         (icode->gpr_map = kcalloc(512 + 256 + 256 + 2 * 1024,
>>> +                             sizeof(u_int32_t), GFP_KERNEL)) == NULL ||
>>
>> Why would casting to __user be redundant?
>
> My reasoning behind the patch is that the C standard does not require a
> specific cast of a void pointer in order to set it to the type of the
> member gpr_map of the struct snd_emu10k1_fx8010_code. I named it redundant
> because the compiler would cast to it anyway.

That's correct as far as the C standard is concerned.  However, __user is
a non-standard extension.

> The line also appears as a warning when running make coccicheck.

And when you remove the __user, you get a warning when running make C=x.

Both coccinelle and sparse are merely tools for finding likely bugs.
When it isn't possible to make them both happy with or without the cast,
that just shows that the code itself is badly designed.

The driver should be redesigned to not access user and kernel space
memory through the same pointer.


Regards,
Clemens
