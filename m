From: "sandeep lahane" <sandeep.lahane@gmail.com>
Subject: Re: Issues with alsa-lib-1.0.13 built using arm gcc
	4.1.1
Date: Tue, 18 Mar 2008 12:10:46 -0700
Message-ID: <2d51cbf80803181210j226e3686lebf7cb1264c875df@mail.gmail.com>
References: <2d51cbf80803172006g368e54c0n93b014a4b71da506@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ik-out-1112.google.com (ik-out-1112.google.com [66.249.90.177])
	by alsa0.perex.cz (Postfix) with ESMTP id 844DC103894
	for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2008 20:10:49 +0100 (CET)
Received: by ik-out-1112.google.com with SMTP id b32so50458ika.0
	for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2008 12:10:48 -0700 (PDT)
In-Reply-To: <2d51cbf80803172006g368e54c0n93b014a4b71da506@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 17, 2008 at 8:06 PM, sandeep lahane <sandeep.lahane@gmail.com>
wrote:

>
>
> Hello,
>
> I have written an external io type plugin for an arm based board.
> While debugging the plugin, I encountered unexpected errors
> which I doubt are because of gcc optimizations, and after looking up on
> web it seems that arm-gcc 4.1.1 which we are using has some known bugs
> due to which alsa-library functions behave unexpectedly.
> E.g. snd_mask_refine() reportedly behaves differently when it is
> compiled using different optimization levels, I am facing the same issue
> where snd_mask_refine() returns unexpected (-EINVAL) and after I modify
> the
> code as in src/pcm/mask_inline.h
>
>  MASK_INLINE void snd_mask_copy(snd_mask_t *mask, const snd_mask_t *v)
>  {
> -  *mask = *v;
> +    memcpy(mask->bits, v->bits, MASK_SIZE * 4);
>  }
>
> snd_mask_refine() returns 0 which is valid but I get segfaults just after
> returning from snd_pcm_ioplug_hw_refine().
>
> Is this a known bug and if yes/no then is there any list of known
> bugs/quirks when using alsa-lib with arm gcc 4.1.1?
>
>
> I am attaching a log below, pardon for non-alsa flavour of debug messages
> in the log.
>
>
Pruning the log in previous email.

It looks like the issue has been resolved by building alsa-lib and
alsa-utils at optimization level 0. The snd_hw_refine() returns wrong values
at other optimiztion levels so it has to be either patched/modified to
nullify  -O settings  or  optimization level 0 has to be used. I had tried
out patching the function
and then it returns correct value, but alsa-lib segfaults after successfully
returning
from it. So currently I am going ahead with building them at -O0.

-- 

Regards,
Sandeep.
