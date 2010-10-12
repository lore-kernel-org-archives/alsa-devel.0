From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [patch 3/3] t5325: add audio support
Date: Tue, 12 Oct 2010 18:18:46 +0100
Message-ID: <20101012171845.GI30933@rakim.wolfsonmicro.main>
References: <20101012094453.660938870@rtp-net.org>
	<20101012100039.492443712@rtp-net.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4331D24489
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Oct 2010 19:18:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20101012100039.492443712@rtp-net.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: alsa-devel@alsa-project.org, Saeed Bishara <saeed@marvell.com>, Martin Michlmayr <tbm@cyrius.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 12, 2010 at 11:44:56AM +0200, Arnaud Patard wrote:
> This patch declares the i2c audio codec and initialise audio.
> 

Looks like the changelogs for this and the previous patch got
transposed.

> +#include <sound/alc5623.h>

This will need to be merged along with the CODEC driver.
