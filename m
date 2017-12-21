From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v2] ASOC: wm8960: Add multiple MCLK
	frequency support
Date: Thu, 21 Dec 2017 16:48:10 +0000
Message-ID: <20171221164810.ocdl3im5gy3mipmn@localhost.localdomain>
References: <1513168650-102028-1-git-send-email-chen.liu.opensource@gmail.com>
 <20171214161954.wfik3ygadwii3zhm@localhost.localdomain>
 <CACJSzi0Kuknj6xFpambi87a1cXecGdfNGQ7PpgywwZV=9_U1yA@mail.gmail.com>
 <20171218093122.mgghz4mkxtvix6uu@localhost.localdomain>
 <CACJSzi13ZdOjvz1A2YFbE3z0nUPjeC7i5Dh+ZTnsQH55ON=YMA@mail.gmail.com>
 <20171218115526.z336fwohv5mt45sk@localhost.localdomain>
 <CACJSzi0hbv2p_6dXkp2AFwyYVzmU6_H56LgJxY70_ZKn2y=aUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id B27A0266BBC
 for <alsa-devel@alsa-project.org>; Thu, 21 Dec 2017 17:48:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CACJSzi0hbv2p_6dXkp2AFwyYVzmU6_H56LgJxY70_ZKn2y=aUw@mail.gmail.com>
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

On Tue, Dec 19, 2017 at 02:19:48PM +0800, chen liu wrote:
> 2017-12-18 19:55 GMT+08:00 Charles Keepax <ckeepax@opensource.cirrus.com>:
> > On Mon, Dec 18, 2017 at 07:32:41PM +0800, chen liu wrote:
> > > 2017-12-18 17:31 GMT+08:00 Charles Keepax <ckeepax@opensource.cirrus.com
> > > > On Fri, Dec 15, 2017 at 09:07:15PM +0800, chen liu wrote:
> > > > > 2017-12-15 0:19 GMT+08:00 Charles Keepax <
> > ckeepax@opensource.cirrus.com
> > > > > > On Wed, Dec 13, 2017 at 08:37:30PM +0800, Chen.Liu wrote:
>         // Then this branch will be executed.
>         //  If the sample rate is 44100HZ, the value of freq_out will be
> 11.2896MHZ
>         freq_out = wm8960_configure_pll(codec, freq_in, &i, &j, &k);
>         if (freq_out < 0) {
>                 dev_err(codec->dev, "failed to configure clock via PLL\n");
>                 return freq_out;
>         }
>        // The 'wm8960_set_pll' function will be executed,this function is
> very important.
>        // But now, the freq_in is 24MHZ and the freq_out is 11.2896MHZ.
>         wm8960_set_pll(codec, freq_in, freq_out);
> ...
> 
> Because the 'wm8960_configure_pll' function has been pre-scaled by 2 for
> freq_out,
> but the value of freq_out is not multiplied by 2 in the 'pll_factors'
> function, it prints the
> "WM8960 PLL: Unsupported N =" error message.

Ah ok so I hadn't realised you were using the SYSCLK_AUTO stuff
and finding an issue with it. Thank you very much for the
explanation.

One thing I don't understand though is it looks like the freq_out
returned from wm8960_configure_pll should already be taking the
SYSCLK_DIV into account:

for (j = 0; j < ARRAY_SIZE(dac_divs); ++j) {
	sysclk = lrclk * dac_divs[j];
	freq_out = sysclk * sysclk_divs[i];

So if lrclk=44100, j=0, i=2 which I believe is the case in
question we should get:

sysclk = 44100 * 256 = 11.2896MHz
freq_out = 11.2896MHz * 2 = 22.5792MHz

So when wm8960_configure_pll returns i=2 then it should also be
setting freq_out as 22.5792MHz. So you final call there to
wm8960_set_pll should be:

wm8960_set_pll(codec, 24MHz, 22.5792MHz);

Can you see why that isn't happening?

Thanks,
Charles
