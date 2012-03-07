From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 2/2] ASoC: DAPM - Make sure DAPM widget IO
 ops hold the component mutex.
Date: Wed, 07 Mar 2012 10:11:01 +0000
Message-ID: <1331115061.3829.11.camel@odin>
References: <1331057779-4630-1-git-send-email-lrg@ti.com>
	<1331057779-4630-2-git-send-email-lrg@ti.com>
	<20120306200354.GB19635@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog124.obsmtp.com (na3sys009aog124.obsmtp.com
	[74.125.149.151])
	by alsa0.perex.cz (Postfix) with ESMTP id CF9F01040B3
	for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2012 11:11:20 +0100 (CET)
Received: by wico1 with SMTP id o1so3110527wic.40
	for <alsa-devel@alsa-project.org>; Wed, 07 Mar 2012 02:11:04 -0800 (PST)
In-Reply-To: <20120306200354.GB19635@opensource.wolfsonmicro.com>
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

On Tue, 2012-03-06 at 20:03 +0000, Mark Brown wrote:
> On Tue, Mar 06, 2012 at 06:16:19PM +0000, Liam Girdwood wrote:
> 
> > +	if (w->codec)
> > +		mutex_lock(&w->codec->mutex);
> 
> Actually for CODECs we don't need to hold the CODEC mutex for I/O if
> we've pushed the cache down into regmap - regmap does all the locking
> for us.  I'll send a followup patch.

I know, but this patch did check for regmap usage in
soc_widget_update_bits_locked(). With your fix we are doing the regmap
test twice.

Liam
