From: Leon Romanovsky <leon@leon.nu>
Subject: [PATCH 00/12] ASoC: ALC5632: Capture path improvements
Date: Sat, 11 Feb 2012 23:10:33 +0200
Message-ID: <1328994645-8237-1-git-send-email-leon@leon.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 2DF62103866
	for <alsa-devel@alsa-project.org>; Sat, 11 Feb 2012 22:11:02 +0100 (CET)
Received: by eekd49 with SMTP id d49so1252422eek.38
	for <alsa-devel@alsa-project.org>; Sat, 11 Feb 2012 13:11:00 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: lrg@ti.com, broonie@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
Cc: Leon Romanovsky <leon@leon.nu>
List-Id: alsa-devel@alsa-project.org

This patches is bringing improved support of capture path to ALC5632 codec.

Andrey Danin (10):
  ASoC: alc5632: Coding style. Remove two extra empty lines.
  ASoC: alc5632: Fixed voice DAC volume step.
  ASoC: alc5632: Add voice DAC playback switch
  ASoC: alc5632: Rename capture switches to common scheme XXX2REC
  ASoC: alc5632: Remove unexisting route from Phone Mix to Mono Mix
  ASoC: alc5632: Refactored DAPM routes to add voice support
  ASoC: alc5632: Add DMIC switches and controls
  ASoC: alc5632: Fix I2S digital interface power for recording
  ASoC: alc5632: Allow 8kHz stream support.
  ASoC: alc5632: Connect HP/HPL/HPR mix'es to HPOut Mix

Paul Fertser (2):
  ASoC: alc5632: Fix Boost Volume TLVs used for the external
    microphones
  ASoC: alc5632: Fix Capture/Playback attributes for microphone inputs

 sound/soc/codecs/alc5632.c |  183 +++++++++++++++++++++++++++++++-------------
 sound/soc/codecs/alc5632.h |    1 +
 2 files changed, 130 insertions(+), 54 deletions(-)

-- 
1.7.3.4
