From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCHv4] dmaengine: Add support for BCM2835
Date: Thu, 14 Nov 2013 17:23:08 +0100
Message-ID: <11018682.0TjgocUWod@flatron>
References: <5283BC93.1090801@koalo.de> <2385512.qcT1vt8HYp@flatron>
 <CABDT8WyUK6tDneDEm0G3o0zJHXaVTZp8JAMxOp5LRKQYG-7Umw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f172.google.com (mail-wi0-f172.google.com
 [209.85.212.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 07A87261A2F
 for <alsa-devel@alsa-project.org>; Thu, 14 Nov 2013 17:23:08 +0100 (CET)
Received: by mail-wi0-f172.google.com with SMTP id i19so2762057wiw.11
 for <alsa-devel@alsa-project.org>; Thu, 14 Nov 2013 08:23:08 -0800 (PST)
In-Reply-To: <CABDT8WyUK6tDneDEm0G3o0zJHXaVTZp8JAMxOp5LRKQYG-7Umw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Florian Meier <florian.meier@koalo.de>
Cc: devicetree <devicetree@vger.kernel.org>, alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Stephen Warren <swarren@wwwdotorg.org>, Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>, dmaengine <dmaengine@vger.kernel.org>, Matt Porter <matt.porter@linaro.org>, Dan Williams <dan.j.williams@intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Thursday 14 of November 2013 17:14:31 Florian Meier wrote:
> >> >> I am becoming desperate anyway that this migration will ever fully
> >> >> take place....
> >> >
> >> > Why not? It's just a matter of people like you working on this (and
> >> > addressing some review comments ;)).
> >>
> >> The most common comment about this is that people will not put effort in
> >> the upstream kernel as long as there is no comfortable way for debugging
> >> in the upstream kernel (i.e. at least USB support).......
> >
> > Right, you need USB to have ethernet working. Still, IMHO UART (for
> > console) + ethernet (for file transfer or NFS root) is the reasonable
> > setup allowing you to debug further drivers in a comfortable way.
> 
> I am fine with UART and switching SD cards :-)
> But apparently this is not generally accepted.

Still, isn't some work on USB support for RPi already going on? I believe
Matt Porter (now on Cc) has been working on unifying dwc2 host-mode
driver with Samsung s3c-hsotg device-mode driver (for the same IP) to
get full OTG support on all applicable platforms.

Best regards,
Tomasz
