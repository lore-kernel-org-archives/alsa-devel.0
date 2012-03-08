From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: dapm: Add API call to query valid
	DAPM paths.
Date: Thu, 08 Mar 2012 11:42:30 +0000
Message-ID: <1331206950.3782.5.camel@odin>
References: <1331142952-6502-1-git-send-email-lrg@ti.com>
	<20120307191547.GX3107@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog101.obsmtp.com (na3sys009aog101.obsmtp.com
	[74.125.149.67])
	by alsa0.perex.cz (Postfix) with ESMTP id 9DB4E10B9FA
	for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2012 12:42:33 +0100 (CET)
Received: by mail-ww0-f51.google.com with SMTP id ed3so255480wgb.20
	for <alsa-devel@alsa-project.org>; Thu, 08 Mar 2012 03:42:32 -0800 (PST)
In-Reply-To: <20120307191547.GX3107@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2012-03-07 at 19:15 +0000, Mark Brown wrote:
> On Wed, Mar 07, 2012 at 05:55:52PM +0000, Liam Girdwood wrote:
> 
> > +struct snd_soc_dapm_widget_list;
> 
> I might be blind but I think the hunk that actually declares the widget
> list got dropped from the header...  probably in some other part of the
> series you haven't pushed out yet?

I had to double check myself to be sure and Stephen added it a while
back :-

fafd2176f72148e83c64a1f818ff33fceed83d08

> 
> > +		dev_vdbg(widget->dapm->dev," %c : %s -> %s -> %s\n",
> > +			path->sink && path->connect ? '*' : ' ',
> > +			widget->name, path->name, path->sink->name);
> > +
> 
> This and the input user look like good candidates for a tracepoint, it's
> probably pretty useful to have them around and more accessible than vdbg
> is.  It's the sort of information people often look for, and it's real
> time unlike the debugfs picture which isn't capturing stuff when DAPM is
> looking at it.
> 
> > +	dapm_reset(card);
> 
> This function isn't in mainline, another patch series reordering thing I
> expect.  

It's in 6c120e19fa587710d80757a6e364961a017fb6c3

> It does also look like we need some locking somewhere along the
> line here (even if the only thing here is a big scary comment saying the
> relevant locks need to be held).

Oh yeah, this was post the mutex patches and got missed. 

> 
> > +	dev_dbg(dai->dev, "%s: found %d paths\n",
> > +			stream ? "capture" : "playback", paths);
> 
> Tracepoint again?  Much less clear for this one.  I do think we should
> be dumping the stats we've been collecting for the neighbour walks, very
> useful if performance blows up again.

Yep, Tracepoint it is then.

Liam
