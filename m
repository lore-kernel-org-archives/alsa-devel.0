From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v2] ASOC: wm8960: Add multiple MCLK
	frequency support
Date: Mon, 18 Dec 2017 11:55:26 +0000
Message-ID: <20171218115526.z336fwohv5mt45sk@localhost.localdomain>
References: <1513168650-102028-1-git-send-email-chen.liu.opensource@gmail.com>
 <20171214161954.wfik3ygadwii3zhm@localhost.localdomain>
 <CACJSzi0Kuknj6xFpambi87a1cXecGdfNGQ7PpgywwZV=9_U1yA@mail.gmail.com>
 <20171218093122.mgghz4mkxtvix6uu@localhost.localdomain>
 <CACJSzi13ZdOjvz1A2YFbE3z0nUPjeC7i5Dh+ZTnsQH55ON=YMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id AF54F266AE1
 for <alsa-devel@alsa-project.org>; Mon, 18 Dec 2017 13:05:21 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CACJSzi13ZdOjvz1A2YFbE3z0nUPjeC7i5Dh+ZTnsQH55ON=YMA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: chen liu <chen.liu.opensource@gmail.com>
Cc: shengjiu.wang@freescale.com, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, tiwai@suse.com, broonie@kernel.org, daniel.baluta@nxp.com
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 18, 2017 at 07:32:41PM +0800, chen liu wrote:
> 2017-12-18 17:31 GMT+08:00 Charles Keepax <ckeepax@opensource.cirrus.com>:
> 
> > On Fri, Dec 15, 2017 at 09:07:15PM +0800, chen liu wrote:
> > > 2017-12-15 0:19 GMT+08:00 Charles Keepax <ckeepax@opensource.cirrus.com
> > >:
> > > > On Wed, Dec 13, 2017 at 08:37:30PM +0800, Chen.Liu wrote:
> According to your detailed description above, I understand what you mean.
> For the 'wm8960_configure_pll' function,it deduces a reasonable PLL output
> clock frequency based on the 'freq_in' frequency,the sample rate,and the bit
> clock.
> 
> static int wm8960_configure_clocking(struct snd_soc_codec*codec)
> ...
>         freq_out = wm8960_configure_pll(codec, freq_in, &i, &j, &k);
>         if (freq_out < 0) {
>                 dev_err(codec->dev, "failed to configure clock via PLL\n");
>                 return freq_out;
>         }
>         wm8960_set_pll(codec, freq_in, freq_out);
> ...
> 
> In the 'wm8960_configure_clocking' function, it sets the PLL divider by
> calling
> the 'wm8960_set_pll' function after calling the 'wm8960_configure_pll'.
> However,there is no support for SYSCLK_DIV = 2 in the 'wm8960_set_pll'
> function.
> 
> Looking forward to your reply.

Indeed yes, as it looks like the intention was you would set the
SYSCLKDIV manually if setting the PLL manually. But why not just
call wm8960_set_pll will WM8960_SYSCLK_AUTO, and then your code
will use the configure_pll stuff?

I would like to understand what about that approach isn't working
for you as that seems like the easiest solution.

Thanks,
Charles
