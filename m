From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: davinci-i2c,pcm updates
Date: Mon, 06 Jul 2009 14:47:15 -0700
Message-ID: <871votmql8.fsf@deeprootsystems.com>
References: <1246761001-21982-1-git-send-email-troy.kisky@boundarydevices.com>
	<20090705114122.GA5334@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f188.google.com (mail-pz0-f188.google.com
	[209.85.222.188])
	by alsa0.perex.cz (Postfix) with ESMTP id D990224151
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Jul 2009 23:47:18 +0200 (CEST)
Received: by pzk26 with SMTP id 26so1608968pzk.16
	for <alsa-devel@alsa-project.org>; Mon, 06 Jul 2009 14:47:17 -0700 (PDT)
In-Reply-To: <20090705114122.GA5334@sirena.org.uk> (Mark Brown's message of
	"Sun\, 5 Jul 2009 12\:41\:23 +0100")
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
Cc: Chaithrika U S <chaithrika@ti.com>, alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com, Troy Kisky <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

Mark Brown <broonie@opensource.wolfsonmicro.com> writes:

> Could you give a pointer to the SRAM allocator patch, please?

SRAM allocater changes are in mainline as of 2.6.31.  See
arch/arm/mach-davinci/sram.c.

Kevin
