From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2.6.26-rc2] ASoC: Fix wrong enum count for
	jack_function in N810 machine driver
Date: Tue, 13 May 2008 14:23:53 +0100
Message-ID: <20080513132353.GD21292@sirena.org.uk>
References: <1210682524-13966-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 23CC524B05
	for <alsa-devel@alsa-project.org>;
	Tue, 13 May 2008 15:23:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1210682524-13966-1-git-send-email-jarkko.nikula@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, May 13, 2008 at 03:42:04PM +0300, Jarkko Nikula wrote:

> Fix this typo and avoid similar errors by using ARRAY_SIZE macro.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

and queued for Takashi if he doesn't pick it up directly first.
