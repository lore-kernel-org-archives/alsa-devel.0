From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 00/18] ASoC updates
Date: Tue, 9 Dec 2008 15:01:11 +0000
Message-ID: <20081209150110.GA20933@rakim.wolfsonmicro.main>
References: <20081209140101.GA17558@rakim.wolfsonmicro.main>
	<s5hk5a9e7lf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 346E124475
	for <alsa-devel@alsa-project.org>; Tue,  9 Dec 2008 16:01:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hk5a9e7lf.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 09, 2008 at 03:39:08PM +0100, Takashi Iwai wrote:

> Thanks, now I pulled this.  But it seems that there are few build
> problems.

Any beyond the Atmel ones you pointed out already for which:

The following changes since commit f0752331b89ce79063f765545dd7dd5f49d9a713:
  Mark Brown (1):
        ASoC: Convert WM8900 to allow registration by machine code

are available in the git repository at:

  git://opensource.wolfsonmicro.com/linux-2.6-asoc for-tiwai

Mark Brown (1):
      ASoC: Fix typos in Atmel module registration

 sound/soc/atmel/atmel-pcm.c     |    2 +-
 sound/soc/atmel/atmel_ssc_dai.c |    5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)
