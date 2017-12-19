From: chen liu <chen.liu.opensource@gmail.com>
Subject: Re: [PATCH v2] ASOC: wm8960: Add multiple MCLK
	frequency support
Date: Tue, 19 Dec 2017 14:19:48 +0800
Message-ID: <CACJSzi0hbv2p_6dXkp2AFwyYVzmU6_H56LgJxY70_ZKn2y=aUw@mail.gmail.com>
References: <1513168650-102028-1-git-send-email-chen.liu.opensource@gmail.com>
 <20171214161954.wfik3ygadwii3zhm@localhost.localdomain>
 <CACJSzi0Kuknj6xFpambi87a1cXecGdfNGQ7PpgywwZV=9_U1yA@mail.gmail.com>
 <20171218093122.mgghz4mkxtvix6uu@localhost.localdomain>
 <CACJSzi13ZdOjvz1A2YFbE3z0nUPjeC7i5Dh+ZTnsQH55ON=YMA@mail.gmail.com>
 <20171218115526.z336fwohv5mt45sk@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ua0-f170.google.com (mail-ua0-f170.google.com
 [209.85.217.170])
 by alsa0.perex.cz (Postfix) with ESMTP id B8731266EBE
 for <alsa-devel@alsa-project.org>; Tue, 19 Dec 2017 07:19:50 +0100 (CET)
Received: by mail-ua0-f170.google.com with SMTP id a25so4955391uak.3
 for <alsa-devel@alsa-project.org>; Mon, 18 Dec 2017 22:19:50 -0800 (PST)
In-Reply-To: <20171218115526.z336fwohv5mt45sk@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: shengjiu.wang@freescale.com, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, tiwai@suse.com, broonie@kernel.org, daniel.baluta@nxp.com
List-Id: alsa-devel@alsa-project.org

2017-12-18 19:55 GMT+08:00 Charles Keepax <ckeepax@opensource.cirrus.com>:

> On Mon, Dec 18, 2017 at 07:32:41PM +0800, chen liu wrote:
> > 2017-12-18 17:31 GMT+08:00 Charles Keepax <ckeepax@opensource.cirrus.com
> >:
> >
> > > On Fri, Dec 15, 2017 at 09:07:15PM +0800, chen liu wrote:
> > > > 2017-12-15 0:19 GMT+08:00 Charles Keepax <
> ckeepax@opensource.cirrus.com
> > > >:
> > > > > On Wed, Dec 13, 2017 at 08:37:30PM +0800, Chen.Liu wrote:
> > According to your detailed description above, I understand what you mean.
> > For the 'wm8960_configure_pll' function,it deduces a reasonable PLL
> output
> > clock frequency based on the 'freq_in' frequency,the sample rate,and the
> bit
> > clock.
> >
> > static int wm8960_configure_clocking(struct snd_soc_codec*codec)
> > ...
> >         freq_out = wm8960_configure_pll(codec, freq_in, &i, &j, &k);
> >         if (freq_out < 0) {
> >                 dev_err(codec->dev, "failed to configure clock via
> PLL\n");
> >                 return freq_out;
> >         }
> >         wm8960_set_pll(codec, freq_in, freq_out);
> > ...
> >
> > In the 'wm8960_configure_clocking' function, it sets the PLL divider by
> > calling
> > the 'wm8960_set_pll' function after calling the 'wm8960_configure_pll'.
> > However,there is no support for SYSCLK_DIV = 2 in the 'wm8960_set_pll'
> > function.
> >
> > Looking forward to your reply.
>
> Indeed yes, as it looks like the intention was you would set the
> SYSCLKDIV manually if setting the PLL manually. But why not just
> call wm8960_set_pll will WM8960_SYSCLK_AUTO, and then your code
> will use the configure_pll stuff?
>
> I would like to understand what about that approach isn't working
> for you as that seems like the easiest solution.
>

Hi Charles,

Thanks for your reply.

For your question,i will explain in detail below.

First at all,we can not call the 'wm8960_set_pll' function directly in the
machine
driver,but we can call the 'wm8960_set_dai_pll' function with
'WM8960_SYSCLK_AUTO' as a parameter.

example:
sample rate = 44100HZ,  MCLK = 24MHZ, channel = 2;

In the Machine driver, we call 'snd_soc_dai_set_pll(codec_dai,
WM8960_SYSCLK_AUTO, 0, 24000000, 0);' function to automatically
configure the clock frequency.

When we playback the audio file,the ALSA middle layer will call the
'wm8960_hw_params' function to configure the hardware parameters and the
clock frequency.At the bottom of this function it will call the
'wm8960_configure_clocking' function to configure the clock frequency.

static int wm8960_configure_clocking(struct snd_soc_codec *codec)
...
        freq_in = wm8960->freq_in; //Should be 24MHZ
...
        if (wm8960->clk_id == WM8960_SYSCLK_AUTO) {
                /* disable the PLL and using MCLK to provide sysclk */
                wm8960_set_pll(codec, 0, 0);
                freq_out = freq_in;   //should be 24MHZ
        } else if (wm8960->sysclk) {
                freq_out = wm8960->sysclk;
        } else {
                dev_err(codec->dev, "No SYSCLK configured\n");
                return -EINVAL;
        }
...
        if (wm8960->clk_id != WM8960_SYSCLK_PLL) {
                // If the freq_out is 24MHZ,ret will be less than zero.
                ret = wm8960_configure_sysclk(wm8960, freq_out, &i, &j, &k);
                if (ret >= 0) {
                        goto configure_clock;
                } else if (wm8960->clk_id != WM8960_SYSCLK_AUTO) {
                        dev_err(codec->dev, "failed to configure clock\n");
                        return -EINVAL;
                }
        }
        // Then this branch will be executed.
        //  If the sample rate is 44100HZ, the value of freq_out will be
11.2896MHZ
        freq_out = wm8960_configure_pll(codec, freq_in, &i, &j, &k);
        if (freq_out < 0) {
                dev_err(codec->dev, "failed to configure clock via PLL\n");
                return freq_out;
        }
       // The 'wm8960_set_pll' function will be executed,this function is
very important.
       // But now, the freq_in is 24MHZ and the freq_out is 11.2896MHZ.
        wm8960_set_pll(codec, freq_in, freq_out);
...

Because the 'wm8960_configure_pll' function has been pre-scaled by 2 for
freq_out,
but the value of freq_out is not multiplied by 2 in the 'pll_factors'
function, it prints the
"WM8960 PLL: Unsupported N =" error message.


Looking forward to your reply.


Thanks,
Chen.
