From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add max98088 CODEC driver
Date: Thu, 23 Sep 2010 13:04:43 +0100
Message-ID: <20100923120443.GF25663@rakim.wolfsonmicro.main>
References: <B2150E1E4418E1438554A300EA5040E40D469C1248@ITSVLEX06.it.maxim-ic.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B49CE2414A
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Sep 2010 14:04:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <B2150E1E4418E1438554A300EA5040E40D469C1248@ITSVLEX06.it.maxim-ic.internal>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Hsiang <Peter.Hsiang@maxim-ic.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jesse Marroquin <Jesse.Marroquin@maxim-ic.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 22, 2010 at 07:58:48PM -0700, Peter Hsiang wrote:

> This patch adds the MAX98088 CODEC driver.

> Signed-off-by: Peter Hsiang <peter.hsiang@maxim-ic.com>

When you submitted the driver on the 31st of August my first comment in
the review was:

| The major issue with this is that the driver needs to be updated to
| current ASoC versions - you should always be working against the trees
| that are in linux-next for new drivers.  For ASoC you should be looking
| at:

|   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git

Currently you should be looking at for-next or for-2.6.37, though the
branch names will change as kernel development moves forward.

This must be rectified before the driver can be considered for inclusion
in the kernel.  As things stand the code will not compile.
