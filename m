From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 2/2] ASoC: DAPM - Make sure DAPM widget IO
 ops hold the component mutex.
Date: Wed, 07 Mar 2012 11:13:25 +0000
Message-ID: <1331118805.3829.18.camel@odin>
References: <1331057779-4630-1-git-send-email-lrg@ti.com>
	<1331057779-4630-2-git-send-email-lrg@ti.com>
	<20120306200354.GB19635@opensource.wolfsonmicro.com>
	<1331115061.3829.11.camel@odin>
	<20120307105426.GA3107@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog104.obsmtp.com (na3sys009aog104.obsmtp.com
	[74.125.149.73])
	by alsa0.perex.cz (Postfix) with ESMTP id C68331045AB
	for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2012 12:13:44 +0100 (CET)
Received: by mail-ww0-f47.google.com with SMTP id dt13so5039311wgb.4
	for <alsa-devel@alsa-project.org>; Wed, 07 Mar 2012 03:13:27 -0800 (PST)
In-Reply-To: <20120307105426.GA3107@opensource.wolfsonmicro.com>
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

On Wed, 2012-03-07 at 10:54 +0000, Mark Brown wrote:
> On Wed, Mar 07, 2012 at 10:11:01AM +0000, Liam Girdwood wrote:
> > On Tue, 2012-03-06 at 20:03 +0000, Mark Brown wrote:
> 
> > > Actually for CODECs we don't need to hold the CODEC mutex for I/O if
> > > we've pushed the cache down into regmap - regmap does all the locking
> > > for us.  I'll send a followup patch.
> 
> > I know, but this patch did check for regmap usage in
> > soc_widget_update_bits_locked(). With your fix we are doing the regmap
> > test twice.
> 
> Yes, we are but it's a simple comparison with integer so not the end of
> the world.  I'd much rather have the check in the locking code so it's
> clear what's expected instead of split between one of the call sites and
> the locking function where it might easily get missed if someone adds a
> new user.

Ah, I'm thinking with a different perspective here ;-)

My reasoning is that the widget lock will guarantee the component lock.
With the regmap test we don't guarantee a component lock and subsequent
new widget lock users may depend on this lock.

Liam
