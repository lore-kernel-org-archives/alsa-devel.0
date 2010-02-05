From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: pandora: Add APLL supply to fix
 audio output
Date: Fri, 05 Feb 2010 10:13:21 +0000
Message-ID: <1265364801.3177.6.camel@odin>
References: <1265324133-23607-1-git-send-email-notasas@gmail.com>
	<201002050850.56430.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f223.google.com (mail-ew0-f223.google.com
	[209.85.219.223])
	by alsa0.perex.cz (Postfix) with ESMTP id 03521243A8
	for <alsa-devel@alsa-project.org>; Fri,  5 Feb 2010 11:13:25 +0100 (CET)
Received: by ewy23 with SMTP id 23so492414ewy.4
	for <alsa-devel@alsa-project.org>; Fri, 05 Feb 2010 02:13:25 -0800 (PST)
In-Reply-To: <201002050850.56430.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@Nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, ext Grazvydas Ignotas <notasas@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-02-05 at 08:50 +0200, Peter Ujfalusi wrote:
> On Friday 05 February 2010 00:55:33 ext Grazvydas Ignotas wrote:
> > Pandora's external DAC is using 256*Fs output from the TWL4030
> > codec, and TWL4030 needs to have APLL enabled for it's 256*Fs
> > output to function.
> > 
> > Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
> > ---
> > I noticed this a bit late because TWL4030 codec used to have APLL
> > enable hardcoded until that was clean up by not-so-old patch.
> > Would be nice to see this in next -rc, as without this audio
> > won't work completely on pandora (again)..
> 
> Yeah, when I made the changes to the twl4030 codec, I did missed the pandora 
> setup..
> 
> Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

Btw, I may be getting a pandora soon so I should be able to keep on top
of any future breakages.

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
