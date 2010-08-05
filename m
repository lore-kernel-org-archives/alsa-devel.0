From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH v5 0/1] A codec driver for the TI WL1273 FM
 Radio.
Date: Thu, 05 Aug 2010 14:30:45 +0100
Message-ID: <1281015045.3076.121.camel@odin>
References: <1281004993-15601-1-git-send-email-matti.j.aaltonen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 374501038C9
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Aug 2010 15:30:48 +0200 (CEST)
Received: by wwb17 with SMTP id 17so3620452wwb.20
	for <alsa-devel@alsa-project.org>; Thu, 05 Aug 2010 06:30:47 -0700 (PDT)
In-Reply-To: <1281004993-15601-1-git-send-email-matti.j.aaltonen@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, peter.ujfalusi@nokia.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-08-05 at 13:43 +0300, Matti J. Aaltonen wrote:
> Hello.
> 
> New in the fifth version:
> 
> > > > +/* codec private data */
> > > > +struct wl1273_priv {
> > > > +   struct snd_soc_codec codec;
> > > > +   enum wl1273_mode mode;
> > > > +   struct wl1273_core *core;
> > > > +   unsigned int channels;
> > > > +};
> > > 
> > > ...why would anything outside the driver be peering into this?
> > 
> > Well, I see no reason... So I'll move it from the header to the c -file
> > and then it's fine?
> 
> OK... that's most probably what you mean. So I've moved the private
> struct definition from the header to the code file. And following the same
> logic I also moved the mode enum definition.
> 
> Cheers,
> Matti A.

This looks fine, although can you redo this against multi-component.
This should just involve changes to your probe() and remove().

Thanks

Liam 
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
