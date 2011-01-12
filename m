From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [uclinux-dist-devel] [PATCH] ASoC: Blackfin TDM:
 use external frame syncs
Date: Wed, 12 Jan 2011 16:45:03 +0000
Message-ID: <20110112164503.GE20911@opensource.wolfsonmicro.com>
References: <1294819195-29119-1-git-send-email-vapier@gentoo.org>
	<20110112111222.GC20911@opensource.wolfsonmicro.com>
	<AANLkTins-dSkJ1e_Z4RmffpgC1wQ-chkXFZ1hq162gP=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6F2C2103809
	for <alsa-devel@alsa-project.org>; Wed, 12 Jan 2011 17:47:13 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <AANLkTins-dSkJ1e_Z4RmffpgC1wQ-chkXFZ1hq162gP=@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Barry Song <barry.song@analog.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 12, 2011 at 11:36:25AM -0500, Mike Frysinger wrote:
> On Wed, Jan 12, 2011 at 06:12, Mark Brown wrote:

> > This sounds a lot like the TDM mode needs to be clock slave on the
> > external bus, though it's a bit hard to tell?

> i believe that's the case

In that case I'd expect an update to your set_dai_fmt() operation
disallowing any configuration except CBM_CFM.  Though I see that's the
case already so I'm kind of surprised the system worked at all -
whatever CODECs you're using with the TDM DAI may well be buggy.
