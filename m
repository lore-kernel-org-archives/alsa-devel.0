From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCHv2 0/3] ASoC: Extend DAPM to handle
	cross-device paths
Date: Fri, 12 Nov 2010 16:07:11 +0200
Message-ID: <20101112160711.7edf33cd.jhnikula@gmail.com>
References: <1289553806-28625-1-git-send-email-jhnikula@gmail.com>
	<20101112135144.GC17283@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 301F610395C
	for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2010 15:07:26 +0100 (CET)
Received: by eyg24 with SMTP id 24so1755462eyg.38
	for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2010 06:07:25 -0800 (PST)
In-Reply-To: <20101112135144.GC17283@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, 12 Nov 2010 13:51:44 +0000
Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> On Fri, Nov 12, 2010 at 11:23:23AM +0200, Jarkko Nikula wrote:
> 
> > One fix is in beginning of dapm_power_widgets that d->dev_power is zeroed only
> 
> Fix relative to the previous version, this is?
> 
Yep, I noticed that previous version had the bug that widgetless codec
bias would shutdown if any other device initiates power change.


-- 
Jarkko
