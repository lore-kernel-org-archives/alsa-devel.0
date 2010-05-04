From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] powerpc/8610: add probing
	for	individual DMA channels, not just DMA controllers
Date: Tue, 4 May 2010 20:22:54 +0100
Message-ID: <20100504192253.GA28622@sirena.org.uk>
References: <1272923655-31807-1-git-send-email-timur@freescale.com>
	<20100504145430.GC3651@opensource.wolfsonmicro.com>
	<4BE03926.4050900@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 55BF924442
	for <alsa-devel@alsa-project.org>;
	Tue,  4 May 2010 21:22:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4BE03926.4050900@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, May 04, 2010 at 10:11:34AM -0500, Timur Tabi wrote:

> Also remove the "gianfar" compatible from mpc8610_ids[], since there is no
> gianfar (or any other networking device) on the 8610.

Meh, sorry.  Though this is a very good example of why you shouldn't
randomly mix unrelated changes into one patch :)
