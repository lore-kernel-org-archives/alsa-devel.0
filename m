From: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH v2] ASoC: Add pinctrl PM to components of
 active DAIs
Date: Tue, 29 Oct 2013 11:25:13 +0800
Message-ID: <20131029032512.GA8812@MrMyself>
References: <1383016374-30919-1-git-send-email-b42378@freescale.com>
 <CAH9JG2X3HHLYLuyPzT3TPX4N0nwJR7xU4yhnkFWyMxHeEV3mbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 by alsa0.perex.cz (Postfix) with ESMTP id 833442652BE
 for <alsa-devel@alsa-project.org>; Tue, 29 Oct 2013 04:41:29 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAH9JG2X3HHLYLuyPzT3TPX4N0nwJR7xU4yhnkFWyMxHeEV3mbg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Kyungmin,

On Tue, Oct 29, 2013 at 12:35:06PM +0900, Kyungmin Park wrote:
> > +       /* deactivate pins to sleep state */
> > +       for (i = 0; i < card->num_rtd; i++) {
> > +               struct snd_soc_pcm_runtime *rtd = &card->rtd[i];
> > +               struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> > +               pinctrl_pm_select_sleep_state(cpu_dai->dev);
> 
> I wonder doesn't check it's active or not? if codec is used during
> suspend. it doesn't set sleep state?

I thought codec wouldn't do anything meaningful to cpu dai since the
whole system is going to suspend. But it should be better to add the
condition here as well. I'll send a v3.

Thank you for the comments,
Nicolin Chen
