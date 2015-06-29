From: Haojian Zhuang <haojian.zhuang@linaro.org>
Subject: Re: ASoC: 88pm860x: Question about
 pm860x_set_dai_sysclk implementation
Date: Mon, 29 Jun 2015 10:02:10 +0800
Message-ID: <1435543330.1744.1.camel@linaro.org>
References: <1435503659.6929.1.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f169.google.com (mail-pd0-f169.google.com
 [209.85.192.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 69D9D265185
 for <alsa-devel@alsa-project.org>; Mon, 29 Jun 2015 04:02:09 +0200 (CEST)
Received: by pdbep18 with SMTP id ep18so85518601pdb.1
 for <alsa-devel@alsa-project.org>; Sun, 28 Jun 2015 19:02:06 -0700 (PDT)
In-Reply-To: <1435503659.6929.1.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Sun, 2015-06-28 at 23:00 +0800, Axel Lin wrote:
> Hi Haojian,
> In sound/soc/codecs/88pm860x-codec.c (pm860x_set_dai_sysclk):
> When dir != PM860X_CLK_DIR_OUT, current code set
> pm860x->dir = PM860X_CLK_DIR_IN; and then return -EINVAL.
> This looks confusion.
> Since there is no comment for that, I'm wondering if the
> return -EINVAL is intentional or not.
> 
> Regards,
> Axel
> 

Hi Axel,

Since we didn't support slave mode in our solution, I just return
-EINVAL for PM860X_CLK_DIR_IN. I'm sorry to add the confused code.
Could you help to format a patch to add the comments?

Regards
Haojian
