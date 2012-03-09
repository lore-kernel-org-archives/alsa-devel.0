From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: dapm: Remove bodges for no-widget
	CODECs
Date: Fri, 09 Mar 2012 17:21:26 +0000
Message-ID: <1331313686.3789.0.camel@odin>
References: <1331219169-21998-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<4F596895.2080401@freescale.com>
	<20120309122122.GL3273@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog118.obsmtp.com (na3sys009aog118.obsmtp.com
	[74.125.149.244])
	by alsa0.perex.cz (Postfix) with ESMTP id 58272104666
	for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2012 18:21:32 +0100 (CET)
Received: by mail-we0-f170.google.com with SMTP id h12so1372141wer.15
	for <alsa-devel@alsa-project.org>; Fri, 09 Mar 2012 09:21:30 -0800 (PST)
In-Reply-To: <20120309122122.GL3273@opensource.wolfsonmicro.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>, Tabi Timur-B04825 <B04825@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2012-03-09 at 12:21 +0000, Mark Brown wrote:
> On Fri, Mar 09, 2012 at 02:19:02AM +0000, Tabi Timur-B04825 wrote:
> > Mark Brown wrote:
> 
> > > I don't actually have any no widget CODECs so can't really test - Timur,
> > > would it be possible for you to give it a spin?
> 
> > I'm assuming you're talking about the CS4270?  I don't even know what a 
> > dapm widget is.  Is there anything in particular I should check when 
> > testing this patch?
> 
> Does it power up.

If it works as expected:-

Acked-by: Liam Girdwood <lrg@ti.com>
