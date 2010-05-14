From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: soc multi chip support
Date: Fri, 14 May 2010 20:45:50 +0100
Message-ID: <1273866350.3069.30.camel@odin>
References: <AANLkTiniGB0A4n_Q_E54jOTnG9I5TNfykQTR1z9klYIl@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id D61171038D6
	for <alsa-devel@alsa-project.org>;
	Fri, 14 May 2010 21:45:53 +0200 (CEST)
Received: by wwf26 with SMTP id 26so991123wwf.38
	for <alsa-devel@alsa-project.org>; Fri, 14 May 2010 12:45:52 -0700 (PDT)
In-Reply-To: <AANLkTiniGB0A4n_Q_E54jOTnG9I5TNfykQTR1z9klYIl@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Attila RS <avgrind911@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-05-14 at 10:30 -0700, Attila RS wrote:
> Hi,
> 
> I have 2 of the same audio codecs connected to an omap (each codec has it's
> own i2c address and each has its own mcbsp channel). I can configure and use
> each one individually, but have not found a way to configure both at the
> same time so that each codec shows up as an alsa device. I did some
> searching and found that this may not be supported yet. Is that the case or
> has anyone done this yet or is working on it?

ASoC multi-component support is working well, although not yet merged
upstream yet.

Please pull the multi-component branch here for support :-

git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6.git

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
