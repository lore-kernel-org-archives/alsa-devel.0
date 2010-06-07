From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC PATCH v3 0/3] ep93xx i2s audio
Date: Tue, 8 Jun 2010 00:52:16 +0100
Message-ID: <F302D76F-8D7D-4F4B-ACC5-D7F76998AA4A@opensource.wolfsonmicro.com>
References: <1275628285-12642-1-git-send-email-ryan@bluewatersys.com>
	<1275914732.3045.105.camel@odin>
	<4C0D58BB.5030505@bluewatersys.com>
	(sfid-20100607_213827_729716_0AEBDFD1)
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E37BE103879
	for <alsa-devel@alsa-project.org>;
	Tue,  8 Jun 2010 01:52:24 +0200 (CEST)
In-Reply-To: <4C0D58BB.5030505@bluewatersys.com>
	(sfid-20100607_213827_729716_0AEBDFD1)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ryan Mallon <ryan@bluewatersys.com>
Cc: john.cooper@third-harmonic.com, chasedouglas@gmail.com, dhuggins@cs.cmu.edu, alsa-devel@alsa-project.org, Russell King <rmk@arm.linux.org.uk>, r&d4@dave-tech.it, hartleys@visionengravers.com, buytenh@wantstofly.org, marshall@coolbananas.co.nz, linux-arm-kernel@lists.infradead.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 7 Jun 2010, at 21:38, Ryan Mallon wrote:

> Russell, Mark has picked up patch 2/3 via the alsa tree. Should I submit
> 1/3 and 3/3 via the arm patch system with Liam's ack?

At least 3/3 needs to go via the ASoC tree since it depends on 2/3. It may make sense for all of them to go that way, or perhaps 1/3 could go separately via the ARM tree (in which case I'd ack it too).
