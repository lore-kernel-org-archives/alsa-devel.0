From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 3/3] Add ALSA driver for Atmel AC97
	controller
Date: Wed, 4 Feb 2009 13:01:56 +0000
Message-ID: <20090204130156.GD29849@sirena.org.uk>
References: <1233748114-6353-1-git-send-email-hans-christian.egtvedt@atmel.com>
	<1233748114-6353-2-git-send-email-hans-christian.egtvedt@atmel.com>
	<1233748114-6353-3-git-send-email-hans-christian.egtvedt@atmel.com>
	<1233748114-6353-4-git-send-email-hans-christian.egtvedt@atmel.com>
	<20090204120045.GB29849@sirena.org.uk>
	<20090204131505.380492af@hcegtvedt> <49898F64.2000107@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 8B49A243BF
	for <alsa-devel@alsa-project.org>; Wed,  4 Feb 2009 14:01:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <49898F64.2000107@atmel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Cc: alsa-devel@alsa-project.org, Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 04, 2009 at 01:51:48PM +0100, Sedji Gaouaou wrote:

> Maybe we could share the same code we some #define in it?

Or have separate files for the DMA on each platform (might be worth
having a look at how the PXA AC97 stuff is split up - it does share all
the DMA code but it's split out from the AC97 controller code.
