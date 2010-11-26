From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC don't apply] ASoC: Add support for optional
 auxiliary dailess codecs
Date: Fri, 26 Nov 2010 13:59:41 +0000
Message-ID: <20101126135941.GG30360@rakim.wolfsonmicro.main>
References: <1290700058-9270-1-git-send-email-jhnikula@gmail.com>
	<20101126153548.a5a5f3c6.jhnikula@gmail.com>
	<20101126134151.GF30360@rakim.wolfsonmicro.main>
	<201011261555.34396.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7B875103D3D
	for <alsa-devel@alsa-project.org>; Fri, 26 Nov 2010 14:59:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <201011261555.34396.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 26, 2010 at 03:55:34PM +0200, Peter Ujfalusi wrote:

> So, if let's say I rewrite the tpa6130a2 driver as DAIless CODEC driver, and 
> connect to a system, where we already have a proper codec. What should I expect?
> Can this work with 'reasonable' ;) amount of work (or non) on the core side?

Jarkko's patch should make it work, we just need to figure out if the
pcm_runtime thing (I'm living in the hope that he's tested it!).
