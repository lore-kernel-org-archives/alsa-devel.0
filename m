From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Sound support for Neuros OSD2 Davinci based board.
Date: Fri, 27 Nov 2009 16:47:33 +0000
Message-ID: <20091127164733.GC11913@rakim.wolfsonmicro.main>
References: <4B0E7D5E.3080906@chelcom.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BDE8A24393
	for <alsa-devel@alsa-project.org>; Fri, 27 Nov 2009 17:47:38 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4B0E7D5E.3080906@chelcom.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "A. Porodko" <panda@chelcom.ru>
Cc: alsa-devel@alsa-project.org, David Brownell <dbrownell@users.sourceforge.net>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Troy Kisky <troy.kisky@boundarydevices.com>, Kevin Hilman <khilman@deeprootsystems.com>, Chaithrika U S <chaithrika@ti.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 26, 2009 at 06:06:38PM +0500, A. Porodko wrote:
> Hello,
> 
> Here is a patch for Neuros OSD2 Davinci (DM6446) based board sound support.
> Patch made against 2.6.32-rc6 kernel.

This doesn't apply against current ASoC.  Could you please regenerate
against this branch:

git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.33
