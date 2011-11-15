From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] ASoC: sta32x: add workaround for ESD
	reset issue
Date: Tue, 15 Nov 2011 11:56:30 +0000
Message-ID: <20111115115630.GD3077@opensource.wolfsonmicro.com>
References: <1321287798-20462-1-git-send-email-js@sig21.net>
	<1321287798-20462-4-git-send-email-js@sig21.net>
	<20111114213716.GG6528@opensource.wolfsonmicro.com>
	<20111115115013.GA23409@sig21.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 85B7B243F9
	for <alsa-devel@alsa-project.org>; Tue, 15 Nov 2011 12:56:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20111115115013.GA23409@sig21.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Johannes Stezenbach <js@sig21.net>
Cc: alsa-devel@alsa-project.org, Sven Neumann <s.neumann@raumfeld.com>, Liam Girdwood <lrg@ti.com>, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 15, 2011 at 12:50:13PM +0100, Johannes Stezenbach wrote:
> On Mon, Nov 14, 2011 at 09:37:17PM +0000, Mark Brown wrote:

> > Applied, though it would be nicer if idle_bias_off were also enabled so
> > that this only has an effect when audio is active (otherwise I can't
> > imagine anything cares about the reset).

> OK, I must admit the meaning of this comment was not clear to me,
> but after grepping in git log I found
> a850260e4722706805fda3a0f6e5bc1539e83bac

Please always quote human readable text, not just git commit ids.

> Is that what you mean?

Yes.  
