From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH -next] ASoC: pandora: Add DAC regulator
 support
Date: Fri, 05 Feb 2010 15:16:50 +0000
Message-ID: <1265383010.3177.13.camel@odin>
References: <1265375612-9079-1-git-send-email-notasas@gmail.com>
	<1265378923.3177.11.camel@odin>
	<6ed0b2681002050629p1d38c19m19d1a124ddce307a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f223.google.com (mail-ew0-f223.google.com
	[209.85.219.223])
	by alsa0.perex.cz (Postfix) with ESMTP id A3852243DA
	for <alsa-devel@alsa-project.org>; Fri,  5 Feb 2010 16:16:51 +0100 (CET)
Received: by ewy23 with SMTP id 23so338215ewy.4
	for <alsa-devel@alsa-project.org>; Fri, 05 Feb 2010 07:16:51 -0800 (PST)
In-Reply-To: <6ed0b2681002050629p1d38c19m19d1a124ddce307a@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-02-05 at 16:29 +0200, Grazvydas Ignotas wrote:
> On Fri, Feb 5, 2010 at 4:08 PM, Liam Girdwood <lrg@slimlogic.co.uk> wrote:
> > On Fri, 2010-02-05 at 15:13 +0200, Grazvydas Ignotas wrote:
> >> Pandora's external DAC is connected to VSIM TWL4030 supply, so let's
> >> start switching it too to save more power.
> >>
> >> Also DAC got it's own DAPM handler and the delay was removed
> >> (it gave on audible improvement).
> >>
> >
> > That's good to hear (pun intended).
> 
> Uh, I meant "no audible improvement". However I've just checked the
> DAC datasheet again and it requires 1ms delay between turning on/off
> the supply and switching /PD pin (connected to
> OMAP3_PANDORA_DAC_POWER_GPIO). Even though I hear no difference,
> adding the delays back just in case. Updated patch attached.
> _______________________________________________

Btw, have you tried turning the volume to mute when the DAC is enabled.
It may lessen the pop at switch on.

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
