From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Update on TLV320AIC3204 Driver
Date: Wed, 16 Jun 2010 15:51:53 +0100
Message-ID: <20100616145153.GD24491@rakim.wolfsonmicro.main>
References: <20100611055512.GG23431@www.longlandclan.yi.org>
	<201006151642.32385.peter.ujfalusi@nokia.com>
	<20100615135322.GG14510@rakim.wolfsonmicro.main>
	<201006160833.12197.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5B9201038E5
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Jun 2010 16:51:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <201006160833.12197.peter.ujfalusi@nokia.com>
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
Cc: alsa-devel@alsa-project.org, ext Stuart Longland <redhatter@gentoo.org>, Eric B??nard <eric@eukrea.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 16, 2010 at 08:33:12AM +0300, Peter Ujfalusi wrote:

> Have I missed something?

No, it's failing to do the shifts.  Looking at the cs42l51 driver it
looks like all the registers on that chip are fully occupied by the
volume controls so it's not an issue for the only current user.
