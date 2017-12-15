From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [RFC PATCH 1/2] ASoC: add support of mclk clock
 providers in wm8894 driver
Date: Fri, 15 Dec 2017 11:51:22 +0000
Message-ID: <20171215115122.ckxgoqzlliufz7cm@localhost.localdomain>
References: <1513270438-18523-1-git-send-email-olivier.moysan@st.com>
 <1513270438-18523-2-git-send-email-olivier.moysan@st.com>
 <20171214173025.GL9788@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 6BF60267B4F
 for <alsa-devel@alsa-project.org>; Fri, 15 Dec 2017 12:51:25 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20171214173025.GL9788@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: benjamin.gaignard@st.com, alsa-devel@alsa-project.org, Olivier Moysan <olivier.moysan@st.com>, alexandre.torgue@st.com, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, arnaud.pouliquen@st.com, tiwai@suse.com, lgirdwood@gmail.com, mcoquelin.stm32@gmail.com, linux-arm-kernel@lists.infradead.org, kernel@stlinux.com
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 14, 2017 at 05:30:25PM +0000, Mark Brown wrote:
> On Thu, Dec 14, 2017 at 05:53:57PM +0100, Olivier Moysan wrote:
> 
> > +	pdata->mclk1 = devm_clk_get(wm8994->dev, "MCLK1");
> > +	if (IS_ERR(pdata->mclk1))
> > +		pdata->mclk1 = NULL;
> 
> These should special case -EPROBE_DEFER so we defer properly if we need
> to (and ideally log an error in case there was a MCLK and we legit ran
> into an error).

We probably want the special case on there being no clock at all
which should silently proceed as this code does and then actual
errors and PROBE_DEFERs can log and fail.

Thanks,
Charles
