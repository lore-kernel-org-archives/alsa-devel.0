From: "Timur Tabi" <timur@freescale.com>
Subject: Re: [PATCH] Clean up ASOC functions to support 32b
	values instead of 16b
Date: Wed, 23 Jul 2008 20:41:39 -0500
Message-ID: <ed82fe3e0807231841s2489781fr7515cd0bd0195586@mail.gmail.com>
References: <20080723233635.6900.55269.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 544B01037F8
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Jul 2008 03:41:41 +0200 (CEST)
Received: by wr-out-0506.google.com with SMTP id 36so1490970wra.24
	for <alsa-devel@alsa-project.org>; Wed, 23 Jul 2008 18:41:40 -0700 (PDT)
In-Reply-To: <20080723233635.6900.55269.stgit@terra>
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
To: Jon Smirl <jonsmirl@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 23, 2008 at 6:36 PM, Jon Smirl <jonsmirl@gmail.com> wrote:

> +int snd_soc_update_bits(struct snd_soc_codec *codec, uint reg,
> +                               uint mask, uint value);
> +int snd_soc_test_bits(struct snd_soc_codec *codec, uint reg,
> +                               uint mask, uint value);

Please use "unsigned int" instead of "uint".


> -       short reg_cache_size;
> -       short reg_cache_step;
> +       uint reg_cache_size;
> +       uint reg_cache_step;

size_t?

>  struct soc_enum {
> -       unsigned short reg;
> -       unsigned short reg2;
> -       unsigned char shift_l;
> -       unsigned char shift_r;
> -       unsigned int max;
> +       uint reg;
> +       uint reg2;
> +       uint shift_l;
> +       uint shift_r;
> +       uint max;

In this case, 'max' was already the right size.  You're now mixing the
real types with abbreviated ones, and so it's inconsistent.

-- 
Timur Tabi
Linux kernel developer at Freescale
