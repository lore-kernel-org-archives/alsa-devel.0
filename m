From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [patch 2/3] kirkwood: Add audio support to hp
 t5325 thin clients
Date: Tue, 7 Sep 2010 11:21:51 +0100
Message-ID: <20100907102151.GF7886@rakim.wolfsonmicro.main>
References: <20100907070127.305740006@rtp-net.org>
	<20100907071009.661466468@rtp-net.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DDD59244A1
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Sep 2010 12:21:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100907071009.661466468@rtp-net.org>
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

On Tue, Sep 07, 2010 at 09:01:29AM +0200, Arnaud Patard wrote:
> This patch is adding support for hp t5325 thin clients.
> There's a alc5623 codec connected to the i2s interface.
> 
> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>

This looks OK, though if you could move the module_init()/module_exit()
next to the functions that'd be better.
