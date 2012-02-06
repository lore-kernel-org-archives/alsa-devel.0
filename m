From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: DAPM - Export
 mixer|mux_update_power() to public API.
Date: Mon, 06 Feb 2012 14:24:47 +0000
Message-ID: <1328538287.6799.19.camel@odin>
References: <1328535135-8765-1-git-send-email-lrg@ti.com>
	<20120206134025.GI3070@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog116.obsmtp.com (na3sys009aog116.obsmtp.com
	[74.125.149.240])
	by alsa0.perex.cz (Postfix) with ESMTP id 3273C103AFE
	for <alsa-devel@alsa-project.org>; Mon,  6 Feb 2012 15:24:58 +0100 (CET)
Received: by mail-wi0-f171.google.com with SMTP id hm2so15490303wib.30
	for <alsa-devel@alsa-project.org>; Mon, 06 Feb 2012 06:24:49 -0800 (PST)
In-Reply-To: <20120206134025.GI3070@opensource.wolfsonmicro.com>
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

On Mon, 2012-02-06 at 13:40 +0000, Mark Brown wrote:
> On Mon, Feb 06, 2012 at 01:32:15PM +0000, Liam Girdwood wrote:
> 
> > +int snd_soc_dapm_mux_update_power(struct snd_soc_dapm_widget *widget,
> > +				 struct snd_kcontrol *kcontrol, int change,
> > +				 int mux, struct soc_enum *e);
> 
> We should get rid of the change parameter before exporting this, we've
> already got all the conditionals in the callers so it never gets called
> without change being set and any users should be doing the same thing.

That's true, and I can't quite remember why there was a change parameter
to begin with.

Liam
