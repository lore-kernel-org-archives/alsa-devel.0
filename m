From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: question on dapm_reg_event()
Date: Wed, 6 Jan 2010 15:59:17 +0000
Message-ID: <20100106155917.GA11245@rakim.wolfsonmicro.main>
References: <771cded01001041810n490145ednefccea066eaf271a@mail.gmail.com>
	<20100106145321.GC5783@sirena.org.uk>
	<20100106174859.227f1cd8.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 50AF02454C
	for <alsa-devel@alsa-project.org>; Wed,  6 Jan 2010 16:59:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20100106174859.227f1cd8.jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Haojian Zhuang <haojian.zhuang@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 06, 2010 at 05:48:59PM +0200, Jarkko Nikula wrote:
> Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> > Hrm, no, that's not at all clear to me either.  CCing Jarkko who
> > contributed the register write control originally.

> IIRC, there were some reason to avoid register update by the
> dapm_update_bits and negative register value was used to prevent it.

> Reg+1 makes sure that the value is negative also for register 0.

Ah, you're using some of the shared fields that the generic widget
handling code then tries to interpret itself.  It'd probably be less
surprising to special case this widget in the generic code (as we do in
a few other cases, like the PGA ramping).
