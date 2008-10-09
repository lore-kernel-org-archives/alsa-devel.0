From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Fwd: [PATCH 7/9] ASoC: Blackfin: I2S CPU DAI driver
Date: Thu, 9 Oct 2008 11:44:01 +0100
Message-ID: <20081009104359.GA31180@sirena.org.uk>
References: <1220516528-20301-1-git-send-email-cooloney@kernel.org>
	<1220516528-20301-8-git-send-email-cooloney@kernel.org>
	<20080904144343.GB32531@rakim.wolfsonmicro.main>
	<520f0cf10810082353r2694535evc3edbcb2b3c76796@mail.gmail.com>
	<520f0cf10810082358t274a46afy7d9c5bbc5ca56de7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id EFD6B24420
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Oct 2008 12:44:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <520f0cf10810082358t274a46afy7d9c5bbc5ca56de7@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John Kacur <jkacur@gmail.com>
Cc: Cliff Cai <cliff.cai@analog.com>, Bryan Wu <cooloney@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 09, 2008 at 08:58:08AM +0200, John Kacur wrote:
> On Thu, Sep 4, 2008 at 4:43 PM, Mark Brown
> <broonie@opensource.wolfsonmicro.com> wrote:

> code, and IMO make it more readable, something like this?
> +       switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> +       case SND_SOC_DAIFMT_CBM_CFM: /* Passing Case */
> +               break;
> +       case SND_SOC_DAIFMT_CBS_CFS: /* Failing Cases */
> +       case SND_SOC_DAIFMT_CBM_CFS:
> +       case SND_SOC_DAIFMT_CBS_CFM:
> +               ret = -EINVAL;
> +               break;
> +       default:
> +               printk(KERN_INFO "Unknown SND_SOC_DAIFMT kind\n");
> +               ret = -EINVAL;
> +               break;
> +       }

Yes, that's better - I'd remove the comments (they don't add much) and
the prinkt() should be a KERN_ERR or higher severity since this should
only happen as a result of a buggy machine driver.  You could also just
have a single default: for the unsupported types.
