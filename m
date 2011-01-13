From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [uclinux-dist-devel] [PATCH] ASoC: Blackfin TDM:
 use external frame syncs
Date: Thu, 13 Jan 2011 13:39:58 +0000
Message-ID: <1294925998.3453.7.camel@odin>
References: <1294819195-29119-1-git-send-email-vapier@gentoo.org>
	<20110112111222.GC20911@opensource.wolfsonmicro.com>
	<AANLkTins-dSkJ1e_Z4RmffpgC1wQ-chkXFZ1hq162gP=@mail.gmail.com>
	<20110112164503.GE20911@opensource.wolfsonmicro.com>
	<AANLkTik24XnZ+couVccG8y2Husb0WQGbhtWKO1W5oX2T@mail.gmail.com>
	<20110112171904.GF20911@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 909E110385E
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2011 14:40:02 +0100 (CET)
Received: by wyi11 with SMTP id 11so1696280wyi.38
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2011 05:40:02 -0800 (PST)
In-Reply-To: <20110112171904.GF20911@opensource.wolfsonmicro.com>
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
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Mike Frysinger <vapier@gentoo.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 2011-01-12 at 17:19 +0000, Mark Brown wrote:
> On Wed, Jan 12, 2011 at 12:11:44PM -0500, Mike Frysinger wrote:
> > On Wed, Jan 12, 2011 at 11:45, Mark Brown wrote:
> 
> > > In that case I'd expect an update to your set_dai_fmt() operation
> > > disallowing any configuration except CBM_CFM.  Though I see that's the
> > > case already so I'm kind of surprised the system worked at all -
> > > whatever CODECs you're using with the TDM DAI may well be buggy.
> 
> > Sonic or perhaps Scott or Bob would have to comment.  i have a limited
> > understanding of the SPORT/audio, so i can only theorize based on the
> > sparse changelogs i'm given.
> 
> OK.  The change is *probably* OK in itself (I have a similar changelog
> issue) but it may be pointing up an issue with the CODEC driver, it'd be
> worth investigating that too to make sure there isn't a matching issue
> on the CODEC side.
> _______________________________________________

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
