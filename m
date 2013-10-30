From: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH v2] ASoC: Add pinctrl PM to components of
 active DAIs
Date: Wed, 30 Oct 2013 09:47:30 +0800
Message-ID: <20131030014729.GD9605@MrMyself>
References: <1383016374-30919-1-git-send-email-b42378@freescale.com>
 <CAH9JG2X3HHLYLuyPzT3TPX4N0nwJR7xU4yhnkFWyMxHeEV3mbg@mail.gmail.com>
 <20131029032512.GA8812@MrMyself> <20131029034220.GB8812@MrMyself>
 <20131029161959.GF16686@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 by alsa0.perex.cz (Postfix) with ESMTP id 26E26261AA1
 for <alsa-devel@alsa-project.org>; Wed, 30 Oct 2013 02:56:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20131029161959.GF16686@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Kyungmin Park <kmpark@infradead.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 29, 2013 at 09:19:59AM -0700, Mark Brown wrote:
> On Tue, Oct 29, 2013 at 11:42:20AM +0800, Nicolin Chen wrote:
> 
> > So I think maybe I was right at the first place that it's okay not to set
> > a condition here? Since the card is going to suspend, why do we need to
> > care codec's behavior? Please correct me if I'm wrong.
> 
> There's no reason CODECs can't implement pinctrl if they want to.

Hmm..Sorry, I'm little confused. What should I do? Adding a pinctrl_pm
for codec_dai->pins? Or a condition like "if (!codec_dai->active)"?

Thank you,
Nicolin Chen
