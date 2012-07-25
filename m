From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] ia64: rename platform_name to ia64_platform_name
Date: Wed, 25 Jul 2012 01:18:39 -0700
Message-ID: <1343204319.1693.6.camel@joe2Laptop>
References: <20120725080653.GA18233@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ia64-owner@vger.kernel.org>
In-Reply-To: <20120725080653.GA18233@localhost>
Sender: linux-ia64-owner@vger.kernel.org
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, linux-ia64@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2012-07-25 at 16:06 +0800, Fengguang Wu wrote:
> The macro name is too generic and conflicts with
> snd_soc_dai_link.platform_name, which triggers lots of ALSA build errors.

Is platform_name particularly special?

Perhaps it's be better to rename all the other
platform_<foo> uses to ia64_platform_<foo>

[]

> diff --git a/arch/ia64/include/asm/machvec.h b/arch/ia64/include/asm/machvec.h
[]
> @@ -120,7 +120,7 @@ extern void machvec_tlb_migrate_finish (struct mm_struct *);
>  # ifdef MACHVEC_PLATFORM_HEADER
>  #  include MACHVEC_PLATFORM_HEADER
>  # else
> -#  define platform_name		ia64_mv.name
> +#  define ia64_platform_name	ia64_mv.name
>  #  define platform_setup	ia64_mv.setup
>  #  define platform_cpu_init	ia64_mv.cpu_init
>  #  define platform_irq_init	ia64_mv.irq_init

Maybe something like:

$ git ls-files arch/ia64 | \
  xargs sed -r -i 's/\bplatform_([a-z_]+)\b/ia64_platform_\1/g'

