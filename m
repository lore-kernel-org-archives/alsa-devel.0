From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ASoC: TWL4030: Add capture source
	selection and mic gain control
Date: Tue, 2 Dec 2008 10:27:18 +0000
Message-ID: <20081202102717.GA7940@sirena.org.uk>
References: <1228172848-5221-1-git-send-email-notasas@gmail.com>
	<20081201232652.GA10702@sirena.org.uk>
	<6ed0b2680812020215l3072dee8wc47e69b5bebb6b77@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E5301245A5
	for <alsa-devel@alsa-project.org>; Tue,  2 Dec 2008 11:27:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <6ed0b2680812020215l3072dee8wc47e69b5bebb6b77@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 02, 2008 at 12:15:51PM +0200, Grazvydas Ignotas wrote:
> On Tue, Dec 2, 2008 at 1:26 AM, Mark Brown <broonie@sirena.org.uk> wrote:

> > Hrm.  Disabling the gain like this is likely to cause trouble for jack
> > detect.  However, that's not implemented yet so not a problem currently.

> Well the TRM doesn't mention jack detect at all (except headset detect
> using separate switch connected to GPIO). Or is that some software
> feature?

Hardware normally.

> >> +     SOC_DOUBLE_TLV("Microphone Boost", TWL4030_REG_ANAMIC_GAIN,
> >> +             0, 3, 5, 0, microphone_gain_tlv),

> > Should be "Microphone Boost Volume" or possibly just "Microphone Volume".

> Setting this to 0 still records from MICs, but the signal is rather
> weak, so it looks more like boost to me. This control also affects
> aux/line inputs if they are selected, and causes rather bad

So Microphone Boost Volume then (the addition of Volume is the important
bit here).

> distortions for them if control is not set to 0. Perhaps this control
> could be disabled (or at least automatically set to 0) while aux/line
> inputs are selected? Can that be done?

Yes, have your custom control update it and use snd_ctl_notify() to kick
applications if you update the user visible value.  Even better would be
to do something more fancy and use a custom control to present a
shadowed control to user space so they don't see the adjustment.
