From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 5/8] ASoC: ep93xx: Setup dma data in DAI
 probe
Date: Mon, 13 May 2013 20:47:54 +0200
Message-ID: <5191355A.6000406@metafoo.de>
References: <1366478947-9377-1-git-send-email-lars@metafoo.de>
 <1366478947-9377-5-git-send-email-lars@metafoo.de>
 <20130513142121.GB16673@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-091.synserver.de (smtp-out-091.synserver.de
 [212.40.185.91])
 by alsa0.perex.cz (Postfix) with ESMTP id EFBE1261A5D
 for <alsa-devel@alsa-project.org>; Mon, 13 May 2013 20:48:17 +0200 (CEST)
In-Reply-To: <20130513142121.GB16673@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Ryan Mallon <rmallon@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Hartley Sweeten <hsweeten@visionengravers.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 05/13/2013 04:21 PM, Mark Brown wrote:
> On Sat, Apr 20, 2013 at 07:29:04PM +0200, Lars-Peter Clausen wrote:
>> This allows us to access the DAI DMA data when we create the PCM. We'll use
>> this when converting ep39xx to generic DMA engine PCM driver.
> 
> Hrm, it seems to still apply against the current code so I did that.
> Hopefully the tooling worked OK but please check.

Looks fine, the only other change was the removal of
platform_set_drvdata(..., NULL).
