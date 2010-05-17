From: Attila RS <avgrind911@gmail.com>
Subject: Re: soc multi chip support
Date: Mon, 17 May 2010 10:29:57 -0700
Message-ID: <AANLkTinN_2faDOB01eaRjorFoLI6E_vVXpBBO-XZvrqH@mail.gmail.com>
References: <AANLkTiniGB0A4n_Q_E54jOTnG9I5TNfykQTR1z9klYIl@mail.gmail.com>
	<1273866350.3069.30.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gw0-f51.google.com (mail-gw0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 83C6F24702
	for <alsa-devel@alsa-project.org>;
	Mon, 17 May 2010 19:30:00 +0200 (CEST)
Received: by gwj23 with SMTP id 23so1129525gwj.38
	for <alsa-devel@alsa-project.org>; Mon, 17 May 2010 10:29:59 -0700 (PDT)
In-Reply-To: <1273866350.3069.30.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks. I pulled down the multi-component branch and am looking through it.
I started with TI's latest PSP, which is based on 2.6.32, but as expected
there are numerous changes between it and the the multi-component branch.

Are there any devices in the multi-component branch that are using multiple
audio codecs? Just looking for a good example.

Attila

On Fri, May 14, 2010 at 12:45 PM, Liam Girdwood <lrg@slimlogic.co.uk> wrote:

> On Fri, 2010-05-14 at 10:30 -0700, Attila RS wrote:
> > Hi,
> >
> > I have 2 of the same audio codecs connected to an omap (each codec has
> it's
> > own i2c address and each has its own mcbsp channel). I can configure and
> use
> > each one individually, but have not found a way to configure both at the
> > same time so that each codec shows up as an alsa device. I did some
> > searching and found that this may not be supported yet. Is that the case
> or
> > has anyone done this yet or is working on it?
>
> ASoC multi-component support is working well, although not yet merged
> upstream yet.
>
> Please pull the multi-component branch here for support :-
>
> git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6.git
>
> Liam
> --
> Freelance Developer, SlimLogic Ltd
> ASoC and Voltage Regulator Maintainer.
> http://www.slimlogic.co.uk
>
>
