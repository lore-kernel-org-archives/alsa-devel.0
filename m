From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Blackfin TDM: use external frame
	syncs
Date: Wed, 12 Jan 2011 11:12:22 +0000
Message-ID: <20110112111222.GC20911@opensource.wolfsonmicro.com>
References: <1294819195-29119-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AE12F103ABC
	for <alsa-devel@alsa-project.org>; Wed, 12 Jan 2011 12:14:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1294819195-29119-1-git-send-email-vapier@gentoo.org>
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

On Wed, Jan 12, 2011 at 02:59:55AM -0500, Mike Frysinger wrote:
> From: Barry Song <barry.song@analog.com>

> We don't want to use internal frame syncs otherwise we sometimes
> get out of sync, so don't enable them when setting up the SPORT.

This sounds a lot like the TDM mode needs to be clock slave on the
external bus, though it's a bit hard to tell?
