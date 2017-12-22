From: chen liu <chen.liu.opensource@gmail.com>
Subject: Re: [PATCH v2] ASOC: wm8960: Add multiple MCLK
	frequency support
Date: Fri, 22 Dec 2017 18:40:04 +0800
Message-ID: <CACJSzi0DjUTrbNOH4ykg=3uD=6+TuMdNB7ku_KhQOGLLbgOSWQ@mail.gmail.com>
References: <1513168650-102028-1-git-send-email-chen.liu.opensource@gmail.com>
 <20171214161954.wfik3ygadwii3zhm@localhost.localdomain>
 <CACJSzi0Kuknj6xFpambi87a1cXecGdfNGQ7PpgywwZV=9_U1yA@mail.gmail.com>
 <20171218093122.mgghz4mkxtvix6uu@localhost.localdomain>
 <CACJSzi13ZdOjvz1A2YFbE3z0nUPjeC7i5Dh+ZTnsQH55ON=YMA@mail.gmail.com>
 <20171218115526.z336fwohv5mt45sk@localhost.localdomain>
 <CACJSzi0hbv2p_6dXkp2AFwyYVzmU6_H56LgJxY70_ZKn2y=aUw@mail.gmail.com>
 <20171221164810.ocdl3im5gy3mipmn@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f45.google.com (mail-vk0-f45.google.com
 [209.85.213.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 231752678E1
 for <alsa-devel@alsa-project.org>; Fri, 22 Dec 2017 11:40:25 +0100 (CET)
Received: by mail-vk0-f45.google.com with SMTP id x64so695846vkd.6
 for <alsa-devel@alsa-project.org>; Fri, 22 Dec 2017 02:40:25 -0800 (PST)
In-Reply-To: <20171221164810.ocdl3im5gy3mipmn@localhost.localdomain>
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

2017-12-22 0:48 GMT+08:00 Charles Keepax <ckeepax@opensource.cirrus.com>:
> On Tue, Dec 19, 2017 at 02:19:48PM +0800, chen liu wrote:
>> 2017-12-18 19:55 GMT+08:00 Charles Keepax <ckeepax@opensource.cirrus.com>:
>> > On Mon, Dec 18, 2017 at 07:32:41PM +0800, chen liu wrote:
>> > > 2017-12-18 17:31 GMT+08:00 Charles Keepax <ckeepax@opensource.cirrus.com
>> > > > On Fri, Dec 15, 2017 at 09:07:15PM +0800, chen liu wrote:
>> > > > > 2017-12-15 0:19 GMT+08:00 Charles Keepax <
>> > ckeepax@opensource.cirrus.com
>> > > > > > On Wed, Dec 13, 2017 at 08:37:30PM +0800, Chen.Liu wrote:

> One thing I don't understand though is it looks like the freq_out
> returned from wm8960_configure_pll should already be taking the
> SYSCLK_DIV into account:
>
> for (j = 0; j < ARRAY_SIZE(dac_divs); ++j) {
>         sysclk = lrclk * dac_divs[j];
>         freq_out = sysclk * sysclk_divs[i];
>
> So if lrclk=44100, j=0, i=2 which I believe is the case in
> question we should get:
>
> sysclk = 44100 * 256 = 11.2896MHz
> freq_out = 11.2896MHz * 2 = 22.5792MHz
>
> So when wm8960_configure_pll returns i=2 then it should also be
> setting freq_out as 22.5792MHz. So you final call there to
> wm8960_set_pll should be:

Hi Charles,

You are right.

This problem seems to affect only the clock frequency configured in
manual mode.

Because i'm directly calling the 'snd_soc_dai_set_pll' function in the
machine driver,the driver will  prompts ''WM8960 PLL: Unsupported N"
error message.
The following code is part of how i configured the clock frequency in the
machine driver:
======================================================
+       if (params_rate(params) == 44100)
+               pll_out = 11289600;
+       else
+               pll_out = 12288000;
+
+       ret = snd_soc_dai_set_pll(codec_dai, WM8960_SYSCLK_PLL, 0,
+
data->clk_frequency, pll_out);

======================================================

On the other hand,i think if the codec support these MCLK clock frequency
in the manual,so no matter use manual mode and automatic mode to
configure the clock frequency,the driver prompt errors is very bad.

Thanks again,
Chen.
