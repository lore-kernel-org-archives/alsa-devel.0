From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: Support two wm8962 codec in i.mx6 board.
Date: Tue, 17 Mar 2015 18:33:01 -0700
Message-ID: <20150318013301.GA6432@Asurada-GSX>
References: <CAOaGyfUHS90nKcSxpQZm7X3Lgwtb_9V4xLzyObhd5v=diGHJLw@mail.gmail.com>
 <20150317005503.GA5480@Asurada-GSX>
 <CAOaGyfUBoQLpa0YZjKEtZXmhRL_p=zGq3XEJ9oZHbHrVr1SQ8w@mail.gmail.com>
 <20150317180006.GA5336@Asurada>
 <CAOaGyfUk6LLkZhLXpLVE_akGTD3Ekk0TX_u1Gzw5y3oidBMQOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f181.google.com (mail-pd0-f181.google.com
 [209.85.192.181])
 by alsa0.perex.cz (Postfix) with ESMTP id D7D97265062
 for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2015 02:33:09 +0100 (CET)
Received: by pdnc3 with SMTP id c3so26525521pdn.0
 for <alsa-devel@alsa-project.org>; Tue, 17 Mar 2015 18:33:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAOaGyfUk6LLkZhLXpLVE_akGTD3Ekk0TX_u1Gzw5y3oidBMQOg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Embedded <programassem@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 18, 2015 at 09:12:19AM +0800, Shawn Embedded wrote:

>    Yes, it's and old version, without support of device tree.
>    For AUDMUX configuration, is the code below enough, snippet 1 and 2?

I think so.

>     And here I have another question about clock source sharing
> between the two codecs.
>     The two wm8962 codecs use the same clock source from imx6, in my
> case, clko, as the code mentioned below,

> Since the two codecs share the same clock source, clko, and we donot
> know when mxc_wm8962_init() and wm8962_clk_enable() will be called by
> using the function pointer exactly, do you think it's necessary to
> make NULL to init, make wm8962_clk_enable_do_nothing to clock_enable,
> and manually calling mxc_wm8962_init() and wm8962_clk_enable() in the
> xxx_board_init() function instead?

I don't think you need to change this part.

> 2. In imx-wm8962.c:
> 
> static int __devinit imx_wm8962_probe(struct platform_device *pdev)
> {
>     ....
>     imx_audmux_config(src, ext);    // should keep the same, not need
> to change, right?
>     ....
> }

No, you don't need to.
 
>   But there is a question here.
>   How should I track the  card_priv and its copy for the two codecs repectively.
>   They are used heavily.
>    In order to make the functions run without problems, seems
> necessary to differentiate the function call is for which codec of the
> two, right?
>   The same situation may exist for other just copied global variables
> in imx-wm8962.c.

Each dai-link will create an individual sound card during system
boot-up. Use 'aplay -l', you will see they are different devices.
