From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: TWL4030: Enable voice
	filters	for voice sidetone
Date: Tue, 23 Jun 2009 22:51:20 +0100
Message-ID: <20090623215120.GA16188@opensource.wolfsonmicro.com>
References: <67059DBF19D7214F9C66BB0EA91BA90E3543F31C@dlee04.ent.ti.com>
	<200906230838.20351.peter.ujfalusi@nokia.com>
	<20090623101615.GG5422@sirena.org.uk>
	<200906231618.35877.peter.ujfalusi@nokia.com>
	<67059DBF19D7214F9C66BB0EA91BA90E3555FEAD@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3C494244E3
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Jun 2009 23:51:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <67059DBF19D7214F9C66BB0EA91BA90E3555FEAD@dlee04.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Lopez Cruz, Misael" <x0052729@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 23, 2009 at 02:45:02PM -0500, Lopez Cruz, Misael wrote:

> If we register widgets based on an option passed through platform
> data, then we won't be able to switch between options, right?
> I think switching between option1/2 during runtime is needed,
> otherwise 4-channels and voice support will be mutually exclusive.

Is it realistic that a platform will want to switch between those two
cases at runtime?
