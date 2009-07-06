From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 0/2] davinci ASoC interface changes
Date: Mon,  6 Jul 2009 15:02:01 -0700
Message-ID: <1246917723-27071-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f192.google.com (mail-px0-f192.google.com
	[209.85.216.192])
	by alsa0.perex.cz (Postfix) with ESMTP id 37F6C103877
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jul 2009 00:02:07 +0200 (CEST)
Received: by pxi30 with SMTP id 30so739849pxi.16
	for <alsa-devel@alsa-project.org>; Mon, 06 Jul 2009 15:02:05 -0700 (PDT)
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
Cc: davinci-linux-open-source@linux.davincidsp.com, broonie@sirena.org.uk
List-Id: alsa-devel@alsa-project.org

This series updates the DaVinci ASoC support after various DaVinci core
interface changes.  These core changes are part of the DaVinci core
changes submitted for 2.6.32.

This compiles on top of the v2.6.31-rc2 based 'davinci-next' branch of
the DaVinci git repo here:
git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-davinci.git

Naresh Medisetty (1):
  ASoC: DaVinci: Change default output volume

Sudhakar Rajashekhara (1):
  ASoC: davinci: update after EDMA interface changes

 sound/soc/codecs/tlv320aic3x.h  |    2 +-
 sound/soc/davinci/davinci-evm.c |    8 ++++----
 sound/soc/davinci/davinci-pcm.c |    6 +++---
 3 files changed, 8 insertions(+), 8 deletions(-)
