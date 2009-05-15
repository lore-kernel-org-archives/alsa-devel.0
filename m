From: Ben Dooks <ben-alsa@fluff.org>
Subject: Advice on ASoC support for series of boards
Date: Fri, 15 May 2009 20:34:06 +0100
Message-ID: <20090515193406.GD23895@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from trinity.fluff.org (trinity.fluff.org [89.16.178.74])
	by alsa0.perex.cz (Postfix) with ESMTP id 3541D1039BB
	for <alsa-devel@alsa-project.org>;
	Fri, 15 May 2009 21:34:09 +0200 (CEST)
Received: from ben by trinity.fluff.org with local (Exim 4.63)
	(envelope-from <ben@trinity.fluff.org>) id 1M53AU-0005c7-VO
	for alsa-devel@alsa-project.org; Fri, 15 May 2009 20:34:07 +0100
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I would like some advice before I start on a project to move our
series of boards to the ASoC framework.

All the boards shared the same I2S wiring and all but one have
the same TI CODEC wired in similar configuration. The differences
are in the presence and connection of a speaker AMP (GPIO controlled).

Is there a standard method for binding an AMP to an driver, or is it
necessary to have the AMPs in the driver itself? If not, what would
people recommend to be the best example of this?

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
