From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [patch 3/3] t5325: add audio support
Date: Tue, 7 Sep 2010 11:23:24 +0100
Message-ID: <20100907102323.GA25830@sirena.org.uk>
References: <20100907070127.305740006@rtp-net.org>
	<20100907071011.081288402@rtp-net.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 0261F2412E
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Sep 2010 12:23:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100907071011.081288402@rtp-net.org>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>, Martin Michlmayr <tbm@cyrius.com>, Saeed Bishara <saeed@marvell.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 07, 2010 at 09:01:30AM +0200, Arnaud Patard wrote:
> This patch declares the i2c audio codec and initialise audio.
> 
> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>

This is going to depend on the ASoC CODEC driver for the device so will
need to be merged along with that - if it's OK to do that can the
Kirkwood guys please ack it?
