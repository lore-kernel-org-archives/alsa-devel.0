From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/6] ASoC: Add resource managed
	snd_dmaengine_pcm_register()
Date: Mon, 25 Nov 2013 20:31:36 +0100
Message-ID: <5293A598.2020701@metafoo.de>
References: <1385299262-24304-1-git-send-email-lars@metafoo.de>
 <20131125171922.GO14725@sirena.org.uk> <52938C20.5030906@metafoo.de>
 <20131125182344.GS14725@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-025.synserver.de (smtp-out-048.synserver.de
 [212.40.185.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 431E7261B11
 for <alsa-devel@alsa-project.org>; Mon, 25 Nov 2013 20:31:09 +0100 (CET)
In-Reply-To: <20131125182344.GS14725@sirena.org.uk>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Ryan Mallon <rmallon@gmail.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, H Hartley Sweeten <hsweeten@visionengravers.com>, Bo Shen <voice.shen@atmel.com>, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 11/25/2013 07:23 PM, Mark Brown wrote:
> On Mon, Nov 25, 2013 at 06:42:56PM +0100, Lars-Peter Clausen wrote:
> 
>> I didn't put it there because it has a dependency on
>> SND_SOC_GENERIC_DMAENGINE_PCM. Sothe options were to either add
>> ifdefery to soc-devres.c or to put the managed function in
>> soc-generic-dmaengine-pcm.c.
> 
> Hrm, OK though I'd probably have gone with the ifdefs on this one.  I'll
> wait for more testing anyway.
> 

I'll change it for v2, no problem.
