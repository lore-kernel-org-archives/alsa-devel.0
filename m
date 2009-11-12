From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] add support to reorder CPU and Codec
	DAI	suspend/resume
Date: Thu, 12 Nov 2009 10:46:41 +0000
Message-ID: <20091112104640.GA11656@sirena.org.uk>
References: <1257923457-31470-1-git-send-email-21cnbao@gmail.com>
	<20091111112431.GA18005@opensource.wolfsonmicro.com>
	<3c17e3570911110448v7f7da90bs8ecad60c4afda5bc@mail.gmail.com>
	<20091111142050.GB32595@sirena.org.uk>
	<3c17e3570911110634k60ecc02fwf52c168e9f5ad7a2@mail.gmail.com>
	<20091111144252.GB20417@opensource.wolfsonmicro.com>
	<3c17e3570911112147y40c3ebd9q85f99decfdefff78@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id B12A510392F
	for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2009 11:46:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <3c17e3570911112147y40c3ebd9q85f99decfdefff78@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 12, 2009 at 01:47:36PM +0800, Barry Song wrote:
> On Wed, Nov 11, 2009 at 10:42 PM, Mark Brown

> > It'd really like to understand what's going wrong with the controller
> > here - it should just sync up off the frame sync signal.

> Don't know what happens exactly in hardware controllers . But I
> "fixed" this porblem by isolating interfaces's sync/clock pins from
> Codec(config them to GPIOs), then the whole system gets normal. Since
> you have a plan for pm-link, I will use this way to keep the fix in
> blackfin locally.

Thinking about this further I think you need the GPIO fix anyway.  There
will be some CODECs (I'm mostly thinking of fixed function ones with no
software control) that won't stop generating clocks unless power is
removed.
