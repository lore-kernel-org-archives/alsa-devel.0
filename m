From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [PATCH] enable concurrent digital outputs for
	ALC1200
Date: Fri, 6 Feb 2009 16:40:41 +0800
Message-ID: <20090206084041.GC28267@localhost>
References: <49538A00.3070009@gmx.net> <20081226024838.GA13302@localhost>
	<4954CE2A.2040309@gmx.net> <20081230095414.GA1206@localhost>
	<495FEA39.1000404@gmx.net> <20090206070227.GA17793@localhost>
	<s5hmyd0803x.wl%tiwai@suse.de> <20090206081306.GA26674@localhost>
	<s5hk5847z4h.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 85B7D244C2
	for <alsa-devel@alsa-project.org>; Fri,  6 Feb 2009 09:41:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hk5847z4h.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Thomas Schneider <nailstudio@gmx.net>
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 06, 2009 at 10:23:10AM +0200, Takashi Iwai wrote:
> At Fri, 6 Feb 2009 16:13:06 +0800,
> Wu Fengguang wrote:
> > 
> > On Fri, Feb 06, 2009 at 10:01:54AM +0200, Takashi Iwai wrote:
> > > At Fri, 6 Feb 2009 15:02:27 +0800,
> > > Wu Fengguang wrote:
> > > > 
> > > > Add the SPDIF pin as slave digital out to enable concurrent
> > > > HDMI/SPDIF outputs for ASUS M3A-H/HDMI with ALC1200 codec.
> > > > 
> > > > Tested-by: Thomas Schneider <nailstudio@gmx.net>
> > > > Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
> > > 
> > > Applied now.  Thanks.
> > > 
> > > (We need a bit more (clean-up) work on these issues...)
> > 
> > I have an old patch that tries to convert the dig_out_pin from a
> > scaler into an array. I wonder if this is the way to go... 
> 
> Well, my original thought was about the situation that both codec and
> spec->multiout have the same slave_dig_out array.  It's a bit
> confusing.

Ah yes, there are so many slave_dig_outs now ;-)  

        alc1200_slave_dig_outs
     => preset->slave_dig_outs
     => spec->multiout.slave_dig_outs
     => codec->slave_dig_outs
