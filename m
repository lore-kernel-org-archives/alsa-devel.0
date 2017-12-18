From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v2] ASOC: wm8960: Add multiple MCLK
	frequency support
Date: Mon, 18 Dec 2017 09:31:22 +0000
Message-ID: <20171218093122.mgghz4mkxtvix6uu@localhost.localdomain>
References: <1513168650-102028-1-git-send-email-chen.liu.opensource@gmail.com>
 <20171214161954.wfik3ygadwii3zhm@localhost.localdomain>
 <CACJSzi0Kuknj6xFpambi87a1cXecGdfNGQ7PpgywwZV=9_U1yA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id A026B266C72
 for <alsa-devel@alsa-project.org>; Mon, 18 Dec 2017 10:31:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CACJSzi0Kuknj6xFpambi87a1cXecGdfNGQ7PpgywwZV=9_U1yA@mail.gmail.com>
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
Cc: shengjiu.wang@freescale.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, tiwai@suse.com, broonie@kernel.org, daniel.baluta@nxp.com
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 15, 2017 at 09:07:15PM +0800, chen liu wrote:
> 2017-12-15 0:19 GMT+08:00 Charles Keepax <ckeepax@opensource.cirrus.com>:
> > On Wed, Dec 13, 2017 at 08:37:30PM +0800, Chen.Liu wrote:
> When the MCLK clock frequency cannot meet the SYSCLK clock
> frequency of the wm8960 codec,we must use the PLL divider to
> generate the clock frequency.
> 
> For what you are talking about setting the SYSCLK clock frequency
> automatically and manually,the difference is that one uses the PLL
> divider to generate the SYSCLK clock frequency and the other one
> provides the SYSCLK clock frequency directly through the MCLK.
> 
> Although the driver already supports setting the SYSCLK_DIV register,
> it can only be set to 1,thus causing the codec to not support multiple
> MCLK clock frequency.(For more information, please see the wm8960
> codec manual)
> 
> The important purpose of this patch is to support multiple MCLK
> clock frequency.

Sorry I think I am not following something here, could you be a
bit more specific, especially about why the automatic approach
doesn't meet your needs.

As far as I can see this will let you set the SYSCLKDIV using the
manual method and it can be easily set to either 1 or 2:

static int wm8960_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
...
	switch (div_id) {
		case WM8960_SYSCLKDIV:
			reg = snd_soc_read(codec, WM8960_CLOCK1) & 0x1f9;
		snd_soc_write(codec, WM8960_CLOCK1, reg | div);
		break;
...

And as for the automatic method:

static int wm8960_configure_pll(struct snd_soc_codec *codec, int freq_in,
...
	for (i = 0; i < ARRAY_SIZE(sysclk_divs); ++i) {
		if (sysclk_divs[i] == -1) continue;
...

This will iterate through all the sysclk_dividers and pick one
that is appropriate either 1 or 2. So in what way does the
automatic method not support a SYSCLK_DIV of 2?

Thanks,
Charles
