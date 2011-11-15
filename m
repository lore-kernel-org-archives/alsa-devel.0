From: Johannes Stezenbach <js@sig21.net>
Subject: Re: [PATCH 3/3] ASoC: sta32x: add workaround for ESD
	reset issue
Date: Tue, 15 Nov 2011 12:50:13 +0100
Message-ID: <20111115115013.GA23409@sig21.net>
References: <1321287798-20462-1-git-send-email-js@sig21.net>
	<1321287798-20462-4-git-send-email-js@sig21.net>
	<20111114213716.GG6528@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bar.sig21.net (bar.sig21.net [80.81.252.164])
	by alsa0.perex.cz (Postfix) with ESMTP id 70CF1243F9
	for <alsa-devel@alsa-project.org>; Tue, 15 Nov 2011 12:51:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20111114213716.GG6528@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Sven Neumann <s.neumann@raumfeld.com>, Liam Girdwood <lrg@ti.com>, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 14, 2011 at 09:37:17PM +0000, Mark Brown wrote:
> On Mon, Nov 14, 2011 at 05:23:18PM +0100, Johannes Stezenbach wrote:
> > sta32x resets and loses all configuration during ESD test.
> > Work around by polling the CONFA register once a second
> > and restore all coeffcients and registers when CONFA
> > changes unexpectedly.
> 
> Applied, though it would be nicer if idle_bias_off were also enabled so
> that this only has an effect when audio is active (otherwise I can't
> imagine anything cares about the reset).

OK, I must admit the meaning of this comment was not clear to me,
but after grepping in git log I found
a850260e4722706805fda3a0f6e5bc1539e83bac
Is that what you mean?

Thanks
Johannes
