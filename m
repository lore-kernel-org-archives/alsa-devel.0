From: Bryan Wu <cooloney@kernel.org>
Subject: Re: [PATCH] ASoC: count reaches 10001, not 10000.
Date: Mon, 9 Feb 2009 01:45:09 +0800
Message-ID: <386072610902080945h592c5e16l3be87f0e61490e2c@mail.gmail.com>
References: <498F13B1.1090704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.175])
	by alsa0.perex.cz (Postfix) with ESMTP id D56A024356
	for <alsa-devel@alsa-project.org>; Sun,  8 Feb 2009 18:45:10 +0100 (CET)
Received: by wf-out-1314.google.com with SMTP id 26so1603918wfd.23
	for <alsa-devel@alsa-project.org>; Sun, 08 Feb 2009 09:45:09 -0800 (PST)
In-Reply-To: <498F13B1.1090704@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Roel Kluin <roel.kluin@gmail.com>, Cliff Cai <cliff.cai@analog.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 9, 2009 at 1:17 AM, Roel Kluin <roel.kluin@gmail.com> wrote:
> With a postfix increment count reaches 10001, not 10000.
>

Thanks a lot, it looks fine for me. Add Cliff to this email, since he
is maintaining this driver.

-Bryan

> diff --git a/sound/soc/blackfin/bf5xx-ad73311.c b/sound/soc/blackfin/bf5xx-ad73311.c
> index 7f2a5e1..edfbdc0 100644
> --- a/sound/soc/blackfin/bf5xx-ad73311.c
> +++ b/sound/soc/blackfin/bf5xx-ad73311.c
> @@ -114,7 +114,7 @@ static int snd_ad73311_configure(void)
>        SSYNC();
>
>        /* When TUVF is set, the data is already send out */
> -       while (!(status & TUVF) && count++ < 10000) {
> +       while (!(status & TUVF) && ++count < 10000) {
>                udelay(1);
>                status = bfin_read_SPORT_STAT();
>                SSYNC();
> @@ -123,7 +123,7 @@ static int snd_ad73311_configure(void)
>        SSYNC();
>        local_irq_enable();
>
> -       if (count == 10000) {
> +       if (count >= 10000) {
>                printk(KERN_ERR "ad73311: failed to configure codec\n");
>                return -1;
>        }
>
