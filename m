From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: question on dapm_reg_event()
Date: Wed, 6 Jan 2010 17:48:59 +0200
Message-ID: <20100106174859.227f1cd8.jhnikula@gmail.com>
References: <771cded01001041810n490145ednefccea066eaf271a@mail.gmail.com>
	<20100106145321.GC5783@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f212.google.com (mail-ew0-f212.google.com
	[209.85.219.212])
	by alsa0.perex.cz (Postfix) with ESMTP id 3CAA710382B
	for <alsa-devel@alsa-project.org>; Wed,  6 Jan 2010 16:48:30 +0100 (CET)
Received: by ewy4 with SMTP id 4so72699873ewy.32
	for <alsa-devel@alsa-project.org>; Wed, 06 Jan 2010 07:48:29 -0800 (PST)
In-Reply-To: <20100106145321.GC5783@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Haojian Zhuang <haojian.zhuang@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 6 Jan 2010 14:53:22 +0000
Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> On Mon, Jan 04, 2010 at 09:10:27PM -0500, Haojian Zhuang wrote:
> 
> > I just have a question on dapm code. In dapm_reg_event(), -(w->reg +
> > 1) is input parameter of snd_soc_update_bits(). Why we need to use
> > negative value as input parameter at here? Why do we not use w->reg at
> > here?
> 
> Hrm, no, that's not at all clear to me either.  CCing Jarkko who
> contributed the register write control originally.

IIRC, there were some reason to avoid register update by the
dapm_update_bits and negative register value was used to prevent it.

Reg+1 makes sure that the value is negative also for register 0.


-- 
Jarkko
